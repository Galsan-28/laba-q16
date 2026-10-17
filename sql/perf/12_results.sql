-- Времена выполнения Q16 (мс) и размер Bronze для каждого кодека.
SELECT CASE WHEN query LIKE '%perf_gzip%' THEN 'GZIP' ELSE 'ZSTD' END AS codec,
       round(date_diff('millisecond', created, "end")) AS elapsed_ms,
       round(date_diff('millisecond', started, "end")) AS exec_ms,
       created
FROM system.runtime.queries
WHERE state = 'FINISHED'
  AND query LIKE 'SELECT p.brand%'
  AND (query LIKE '%bronze.perf_gzip.%' OR query LIKE '%bronze.perf_zstd.%')
ORDER BY codec, created;

SELECT 'GZIP' AS codec, round(sum(sz)/1048576.0, 2) AS bronze_mb FROM (
  SELECT file_size_in_bytes sz FROM bronze.perf_gzip."part$files"
  UNION ALL SELECT file_size_in_bytes FROM bronze.perf_gzip."partsupp$files"
  UNION ALL SELECT file_size_in_bytes FROM bronze.perf_gzip."supplier$files")
UNION ALL
SELECT 'ZSTD', round(sum(sz)/1048576.0, 2) FROM (
  SELECT file_size_in_bytes sz FROM bronze.perf_zstd."part$files"
  UNION ALL SELECT file_size_in_bytes FROM bronze.perf_zstd."partsupp$files"
  UNION ALL SELECT file_size_in_bytes FROM bronze.perf_zstd."supplier$files");
