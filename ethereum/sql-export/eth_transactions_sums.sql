EXPORT DATA OPTIONS(
  uri='gs://vijay-onchain-bigquery-export/trx/20230101_20240218/*.pqt',
  format='PARQUET'
) AS
SELECT 
  trx.from_address,
  trx.to_address,
  min(trx.block_timestamp) as min_timestamp,
  max(trx.block_timestamp) as max_timestamp,
  sum(cast(trx.gas_price as numeric) * cast(trx.receipt_gas_used as numeric)) 
			as total_gas_value,
  sum(cast(trx.value as numeric)) 
			as total_txn_value,
  count(1) as txn_count,
  CASE ANY_VALUE(c2.address) WHEN ANY_VALUE(c2.address) THEN true ELSE false END 
			as to_address_is_contract,
  IFNULL(LOGICAL_OR(c2.is_erc20), false) as to_address_is_erc20,
  IFNULL(LOGICAL_OR(c2.is_erc721), false) as to_address_is_erc721,
FROM `bigquery-public-data.crypto_ethereum.transactions` AS trx 
LEFT JOIN `bigquery-public-data.crypto_ethereum.contracts` AS c1
  ON c1.address = trx.from_address
LEFT JOIN (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY address ORDER BY block_number DESC) AS rownum
    FROM `bigquery-public-data.crypto_ethereum.contracts`
   )   AS c2
  ON (c2.address = trx.to_address AND c2.rownum=1 ) 
  -- same contract address, multiple rows in contracts table - pick latest
WHERE
  trx.to_address IS NOT NULL
AND
  c1.address IS NULL -- we don't want from contract txns
AND 
  TIMESTAMP_TRUNC(trx.block_timestamp, DAY)
			BETWEEN TIMESTAMP("2023-01-01") AND TIMESTAMP("2024-02-18")
GROUP BY trx.from_address, trx.to_address

-- Successfully exported 161805004 rows into 742 files.
-- 2024-02-19T00:22:06.451238

