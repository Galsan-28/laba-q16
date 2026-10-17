-- BRONZE: сырые копии 3 таблиц TPC-H sf1, все колонки, без изменений.
SET SESSION bronze.compression_codec = 'ZSTD';

CREATE TABLE bronze.lakehouse.part     WITH (format = 'PARQUET') AS SELECT * FROM tpch.sf1.part;
CREATE TABLE bronze.lakehouse.partsupp WITH (format = 'PARQUET') AS SELECT * FROM tpch.sf1.partsupp;
CREATE TABLE bronze.lakehouse.supplier WITH (format = 'PARQUET') AS SELECT * FROM tpch.sf1.supplier;
