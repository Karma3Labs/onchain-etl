EXPORT DATA
  OPTIONS (
    uri = 'gs://GCS_BUCKET_NAME/transaction_sums/*.csv',
    format = 'CSV',
    overwrite = true,
    header = true,
    field_delimiter = ',')
AS (
  SELECT 
  trx.from_address,
  trx.to_address,
	min(trx.block_timestamp) as min_timestamp,
  max(trx.block_timestamp) as max_timestamp,
  sum(cast(trx.gas_price as numeric)) 
			as gas_price,
	sum(cast(trx.receipt_gas_used as numeric))
			as gas_used,
  sum(cast(trx.value as numeric)) 
			as txn_value,
FROM transactions AS trx 
WHERE
  trx.to_address IS NOT NULL
GROUP BY trx.from_address, trx.to_address, trx.block_timestamp
ORDER BY
  trx.block_timestamp
);