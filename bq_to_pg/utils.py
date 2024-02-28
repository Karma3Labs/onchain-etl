import logging
import io
import sys
import psutil
import pandas as pd

LOG_FORMAT = '[%(asctime)s - %(levelname)s - %(filename)s:%(lineno)s - %(funcName)s ] %(message)s'

def df_info_to_string(df: pd.DataFrame):
  buf = io.StringIO()
  df.info(verbose=True, buf=buf, memory_usage="deep", show_counts=True)
  return buf.getvalue()

def log_memusage(logger:logging.Logger):
  mem_usage = psutil.virtual_memory()
  logger.info(f"Total: {mem_usage.total/(1024**2):.2f}M")
  logger.info(f"Used: {mem_usage.percent}%")
  logger.info(f"Used: {mem_usage.used/(1024**2):.2f}M")
  logger.info(f"Free: {mem_usage.free/(1024**2):.2f}M" )

def setup_consolelogger(logger:logging.Logger):
  # create a console handler
  ch = logging.StreamHandler(sys.stdout)
  ch.setLevel(logging.DEBUG)
  # create a logging format
  formatter = logging.Formatter(LOG_FORMAT)
  ch.setFormatter(formatter)
  # add the handler to the logger
  logger.addHandler(ch)