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
	count(1) as txn_count,
  CASE ANY_VALUE(c2.address) WHEN ANY_VALUE(c2.address) THEN true ELSE false END 
			as to_address_is_contract,
  CASE ANY_VALUE(c2.is_erc20) WHEN ANY_VALUE(c2.is_erc20) THEN true ELSE false END 
			as to_address_is_erc20,
  CASE ANY_VALUE(c2.is_erc721) WHEN ANY_VALUE(c2.is_erc721) THEN true ELSE false END 
			as to_address_is_erc721
FROM transactions AS trx 
LEFT JOIN `bigquery-public-data.crypto_ethereum.contracts` AS c1
  ON c1.address = trx.from_address
LEFT JOIN (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY address ORDER BY block_number DESC) AS rownum
    FROM `bigquery-public-data.crypto_ethereum.contracts`
   )   AS c2
  ON (c2.address = trx.to_address AND c2.rownum=1) 
WHERE
  trx.to_address IS NOT NULL
AND
  c1.address IS NULL
AND
  EXTRACT(YEAR FROM trx.block_timestamp) >= 2023
GROUP BY trx.from_address, trx.to_address
);
