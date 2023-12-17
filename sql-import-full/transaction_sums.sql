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
  CASE ANY_VALUE(c2.address) WHEN ANY_VALUE(c2.address) THEN true ELSE false END 
			as to_address_is_contract,
  CASE ANY_VALUE(c2.is_erc20) WHEN ANY_VALUE(c2.is_erc20) THEN true ELSE false END 
			as to_address_is_erc20,
  CASE ANY_VALUE(c2.is_erc721) WHEN ANY_VALUE(c2.is_erc721) THEN true ELSE false END 
			as to_address_is_erc721,
FROM transactions AS trx 
LEFT JOIN contracts AS c1
  ON c1.address = trx.from_address
LEFT JOIN (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY address ORDER BY block_number DESC) AS rownum
    FROM contracts
   )   AS c2
  ON (c2.address = trx.to_address AND c2.rownum=1) 
  -- same contract address, multiple rows in contracts table - pick latest
WHERE
  trx.to_address IS NOT NULL
AND
  c1.address IS NULL -- we don't want from contract txns
-- AND 
--   TIMESTAMP_TRUNC(trx.block_timestamp, DAY) 
-- 			BETWEEN TIMESTAMP("2023-12-05") AND TIMESTAMP("2023-12-05")
AND 
	EXTRACT(YEAR FROM trx.block_timestamp) = 2023
GROUP BY trx.from_address, trx.to_address, trx.block_timestamp
ORDER BY
  trx.block_timestamp
);