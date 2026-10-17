-- GOLD: витрина = ответ на Q16 (brand, type, size, supplier_cnt).
SET SESSION gold.compression_codec = 'ZSTD';

CREATE TABLE gold.lakehouse.supplier_cnt_by_part
WITH (format = 'PARQUET') AS
SELECT brand, type, size, count(DISTINCT suppkey) AS supplier_cnt
FROM silver.lakehouse.part_supplier
WHERE brand <> 'Brand#45'
  AND type NOT LIKE 'MEDIUM POLISHED%'
  AND size IN (49, 14, 23, 45, 19, 3, 36, 9)
GROUP BY brand, type, size;
