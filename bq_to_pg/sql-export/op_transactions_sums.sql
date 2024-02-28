EXPORT DATA OPTIONS (
    uri = 'gs://vijay-onchain-bigquery-export/op_trx/20230101_20240218/*.pqt',
    format = 'PARQUET'
) AS 
SELECT 
  trx.from_address,
  trx.to_address,
	min(trx.block_timestamp) as min_timestamp,
  max(trx.block_timestamp) as max_timestamp,
  sum(cast(trx.gas_price.bignumeric_value as numeric) * cast(trx.gas as numeric)) 
			as total_gas_value,
  sum(cast(trx.value.bignumeric_value as numeric)) 
			as total_txn_value,
  count(1) as txn_count
FROM `bigquery-public-data.goog_blockchain_optimism_mainnet_us.transactions` as trx
WHERE 
  TIMESTAMP_TRUNC(trx.block_timestamp, DAY)
			BETWEEN TIMESTAMP("2023-01-01") AND TIMESTAMP("2024-02-18")
  AND trx.from_address != trx.to_address
GROUP BY trx.from_address, trx.to_address

-- Successfully exported 37707749 rows into 260 files.
-- 2024-02-28 02:43:23.847250 UTC
