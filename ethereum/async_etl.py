import logging
import os
import csv
import argparse
from io import StringIO
from datetime import datetime, timezone
from dotenv import load_dotenv, find_dotenv
from pathlib import Path
import asyncio

import utils
from timer import Timer

import pandas as pd
import gcsfs
import asyncpg


async def process_parquet(
        logger: logging.Logger, 
        async_pool,
        parquet_engine: str, 
        pq_filepath: str, 
        dest_tablename: str
):
    logger.info(f"reading parquet file: {pq_filepath}")
    logger.info(f"parquet engine: {parquet_engine}")

    t = Timer(name=f"read_{pq_filepath}")
    t.start()
    df = pd.read_parquet(f"gs://{pq_filepath}", engine=parquet_engine)
    t.stop()

    logger.debug(utils.df_info_to_string(df))
    logger.info(f"{pq_filepath} has {len(df)} rows")

    t = Timer(name=f"to_sql_{pq_filepath}")
    t.start()
    logger.info(f"destination table : {dest_tablename}")
    async with async_pool.acquire() as conn:
        async with conn.transaction():
            await conn.copy_records_to_table(
                                dest_tablename, 
                                records=df.itertuples(index=False), 
                                columns=df.columns.to_list(), 
                                timeout=300)
    t.stop()

async def main(logger: logging.Logger, parquet_engine: str):
    pqt_files_path = f"{os.getenv("GCS_BUCKET")}/{os.getenv("BLOB_PATH")}"
    logger.info(f"listing parquet files at {pqt_files_path}")
    fs = gcsfs.GCSFileSystem(project=os.getenv("GCS_PROJECT_ID"))
    pqt_filelist = fs.ls(pqt_files_path)
    logger.info(f"{len(pqt_filelist)} parquet files to process")

    async_pool = await asyncpg.create_pool(os.getenv("PGSQL_URL"), 
                                         min_size=1, 
                                         max_size=os.getenv("POSTGRES_POOL_SIZE", 1))
    await process_parquet(logger, async_pool, parquet_engine, pqt_filelist[0], os.getenv("DEST_TABLENAME"))
    await async_pool.close()


if __name__ == '__main__':
    logger = logging.getLogger()
    utils.setup_consolelogger(logger=logger)

    logging.getLogger().setLevel(logging.INFO)
    logging.info(f"Starting ETL at {datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%fZ')}") 

    parser = argparse.ArgumentParser()
    parser.add_argument("-e", "--engine",
                        help="pyarrow or fastparquet" ,
                        type=lambda f: f if f in (["pyarrow", "fastparquet"]) else None, #TODO use enum
                        default="fastparquet") 
    parser.add_argument("-c", "--config",
                        help=".env file with configs" ,
                        type=lambda f: Path(f).expanduser().resolve())


    args = parser.parse_args()
    logging.info(f"args: {args}")

    if not args.config:
        dotenvfile = find_dotenv(usecwd=True)
    else:
        dotenvfile = args.config
    load_dotenv(dotenvfile)

    asyncio.run(main(logger, args.engine)) 
    
    logging.info(f"Finished ETL at {datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%fZ')}") 