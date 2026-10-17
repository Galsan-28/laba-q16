-- Bronze, пересозданный с кодеком GZIP (схема bronze.perf_gzip)
DROP TABLE IF EXISTS bronze.perf_gzip.part;
DROP TABLE IF EXISTS bronze.perf_gzip.partsupp;
DROP TABLE IF EXISTS bronze.perf_gzip.supplier;
DROP SCHEMA IF EXISTS bronze.perf_gzip;
CREATE SCHEMA bronze.perf_gzip;
SET SESSION bronze.compression_codec = 'GZIP';
CREATE TABLE bronze.perf_gzip.part     WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.part;
CREATE TABLE bronze.perf_gzip.partsupp WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.partsupp;
CREATE TABLE bronze.perf_gzip.supplier WITH (format='PARQUET') AS SELECT * FROM tpch.sf1.supplier;
