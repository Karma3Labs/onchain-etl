EXPORT DATA
  OPTIONS (
    uri = 'gs://GCS_BUCKET_NAME/optimism_transaction_sums/*.csv',
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
  sum(trx.gas_price.bignumeric_value)
			as gas_price,
	sum(cast(trx.gas as numeric))
			as gas_used,
  sum(trx.value.bignumeric_value)
			as txn_value,
FROM transactions AS trx 
WHERE
  trx.to_address IS NOT NULL
GROUP BY trx.from_address, trx.to_address, trx.block_timestamp
ORDER BY
  trx.block_timestamp
);
