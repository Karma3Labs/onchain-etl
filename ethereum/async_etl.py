import sys
import os
import argparse
from dotenv import load_dotenv, find_dotenv
from pathlib import Path
import asyncio
import time

import utils

import pandas 
import gcsfs
import asyncpg
from loguru import logger

logger.remove()
level_per_module = {
    "": "INFO",
    "app": os.getenv("LOG_LEVEL", "INFO"),
    "silentlib": False
}
logger.add(sys.stdout, 
           colorize=True, 
           format="<green>{time}</green> | {module}:{file}:{function}:{line} | {level} | <level>{message}</level>",
           filter=level_per_module,
           level=0)

async def process_parquet(
        async_pool,
        parquet_engine: str, 
        pq_filepath: str, 
        dest_tablename: str
):
    logger.info(f"reading parquet file: {pq_filepath}")
    start_time = time.perf_counter()
    df = pandas.read_parquet(f"gs://{pq_filepath}", engine=parquet_engine)
    logger.info(f"gcs: {pq_filepath} took {time.perf_counter() - start_time} secs")

    logger.debug(utils.df_info_to_string(df))
    logger.info(f"{pq_filepath} has {len(df)} rows")

    logger.info(f"destination table : {dest_tablename}")
    async with async_pool.acquire() as conn:
        start_time = time.perf_counter()
        await conn.copy_records_to_table(
                            dest_tablename, 
                            records=df.itertuples(index=False), 
                            columns=df.columns.to_list(), 
                            timeout=300)
        logger.info(f"database: {pq_filepath} took {time.perf_counter() - start_time} secs")

async def main(parquet_engine: str):
    pqt_files_path = f"{os.getenv("GCS_BUCKET")}/{os.getenv("BLOB_PATH")}"
    logger.info(f"listing parquet files at {pqt_files_path}")
    fs = gcsfs.GCSFileSystem(project=os.getenv("GCS_PROJECT_ID"))
    pqt_filelist = fs.ls(pqt_files_path)
    logger.info(f"{len(pqt_filelist)} parquet files to process")

    async_pool = await asyncpg.create_pool(os.getenv("ASYNC_PGSQL_URL"), 
                                         min_size=1, 
                                         max_size=int(os.getenv("POSTGRES_POOL_SIZE", "2")))
    async with asyncio.TaskGroup() as task_group:
        [task_group.create_task(
            process_parquet(
                async_pool, 
                parquet_engine, 
                pqt_file, 
                os.getenv("DEST_TABLENAME"))) for pqt_file in pqt_filelist[:10]]
    await async_pool.close()


if __name__ == '__main__':
    logger.info(f"Starting ETL") 

    parser = argparse.ArgumentParser()
    parser.add_argument("-e", "--engine",
                        help="pyarrow or fastparquet" ,
                        type=lambda f: f if f in (["pyarrow", "fastparquet"]) else None, #TODO use enum
                        default="fastparquet") 
    parser.add_argument("-c", "--config",
                        help=".env file with configs" ,
                        type=lambda f: Path(f).expanduser().resolve())


    args = parser.parse_args()
    logger.info(f"args: {args}")

    if not args.config:
        dotenvfile = find_dotenv(usecwd=True)
    else:
        dotenvfile = args.config
    load_dotenv(dotenvfile)

    asyncio.run(main(args.engine)) 
    
    logger.info(f"Finished ETL") 