-- Bronze, пересозданный с кодеком ZSTD (схема bronze.perf_zstd)
DROP TABLE IF EXISTS bronze.perf_zstd.part;
DROP TABLE IF EXISTS bronze.perf_zstd.partsupp;
DROP TABLE IF EXISTS bronze.perf_zstd.supplier;
DROP SCHEMA IF EXISTS bronze.perf_zstd;
CREATE SCHEMA bronze.perf_zstd;
SET SESSION bronze.compression_codec = 'ZSTD';
CREATE TABLE bronze.perf_zstd.part     WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.part;
CREATE TABLE bronze.perf_zstd.partsupp WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.partsupp;
CREATE TABLE bronze.perf_zstd.supplier WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.supplier;
