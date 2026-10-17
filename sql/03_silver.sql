-- SILVER: очистка + связка деталь <-> поставка.
-- 1) выбрасываем поставщиков с жалобами (то, что в Q16 делает NOT IN-подзапрос);
-- 2) джойним part и partsupp, оставляя только нужные колонки.
SET SESSION silver.compression_codec = 'ZSTD';

CREATE TABLE silver.lakehouse.part_supplier
WITH (format = 'PARQUET') AS
SELECT p.partkey, ps.suppkey, p.brand, p.type, p.size
FROM bronze.lakehouse.partsupp ps
JOIN bronze.lakehouse.part p ON p.partkey = ps.partkey
WHERE ps.suppkey NOT IN (
    SELECT suppkey FROM bronze.lakehouse.supplier
    WHERE comment LIKE '%Customer%Complaints%'
);
