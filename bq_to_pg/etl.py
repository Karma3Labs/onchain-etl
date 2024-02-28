import logging
import os
import csv
import argparse
from io import StringIO
from datetime import datetime, timezone
from dotenv import load_dotenv, find_dotenv
from pathlib import Path

import utils
from timer import Timer

import pandas as pd
import gcsfs
from sqlalchemy import create_engine

def psql_insert_copy(table, conn, keys, data_iter): #mehod
    """
    Execute SQL statement inserting data

    Parameters
    ----------
    table : pandas.io.sql.SQLTable
    conn : sqlalchemy.engine.Engine or sqlalchemy.engine.Connection
    keys : list of str
        Column names
    data_iter : Iterable that iterates the values to be inserted
    """
    
    dbapi_conn = conn.connection
    with dbapi_conn.cursor() as cur:
        s_buf = StringIO()
        writer = csv.writer(s_buf)
        writer.writerows(data_iter)
        s_buf.seek(0)

        columns = ', '.join('"{}"'.format(k) for k in keys)
        if table.schema:
            table_name = '{}.{}'.format(table.schema, table.name)
        else:
            table_name = table.name

        sql = 'COPY {} ({}) FROM STDIN WITH CSV'.format(
            table_name, columns)
        cur.copy_expert(sql=sql, file=s_buf)


def process_parquet(
        logger: logging.Logger, 
        sql_engine,
        parquet_engine: str, 
        pq_filepath: str, 
        dest_tablename: str
):
    logger.info(f"reading parquet file: {pq_filepath}")
    logger.info(f"parquet engine: {parquet_engine}")
    t = Timer(name=f"read_{pq_filepath}")
    t.start()
    pq_df = pd.read_parquet(f"gs://{pq_filepath}", engine=parquet_engine)
    t.stop()
    logger.debug(utils.df_info_to_string(pq_df))
    logger.info(f"{pq_filepath} has {len(pq_df)} rows")
    t = Timer(name=f"to_sql_{pq_filepath}")
    t.start()
    logger.info(f"to_sql : {dest_tablename}")
    pq_df.to_sql(
        name=dest_tablename,
        con=sql_engine,
        if_exists="append",
        index=False,
        method=psql_insert_copy
    )
    t.stop()

def main(logger: logging.Logger, parquet_engine: str):
    pqt_files_path = f"{os.getenv("GCS_BUCKET")}/{os.getenv("BLOB_PATH")}"
    logger.info(f"listing parquet files at {pqt_files_path}")
    fs = gcsfs.GCSFileSystem(project=os.getenv("GCS_PROJECT_ID"))
    pqt_filelist = fs.ls(pqt_files_path)
    logger.info(f"{len(pqt_filelist)} parquet files to process")
    sql_engine = create_engine(os.getenv("PGSQL_URL"))
    for pqt_file in pqt_filelist:
        process_parquet(logger, sql_engine, parquet_engine, pqt_file, os.getenv("DEST_TABLENAME"))


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

    main(logger, args.engine)
    logging.info(f"Finished ETL at {datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%M:%S.%fZ')}") 