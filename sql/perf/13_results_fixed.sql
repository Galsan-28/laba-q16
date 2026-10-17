SELECT CASE WHEN query LIKE '%bronze.perf_gzip.%' THEN 'GZIP' ELSE 'ZSTD' END AS codec,
       date_diff('millisecond', created, "end") AS elapsed_ms,
       date_diff('millisecond', started, "end") AS exec_ms,
       created
FROM system.runtime.queries
WHERE state = 'FINISHED'
  AND query LIKE '%count(DISTINCT ps.suppkey)%'
  AND query NOT LIKE '%system.runtime.queries%'
  AND (query LIKE '%bronze.perf_gzip.%' OR query LIKE '%bronze.perf_zstd.%')
ORDER BY codec, created;
