SELECT CASE WHEN query LIKE '%(GZIP)%' THEN 'GZIP' ELSE 'ZSTD' END AS codec,
       date_diff('millisecond', created, "end") AS ms,
       created
FROM system.runtime.queries
WHERE query LIKE '-- Q16%'
ORDER BY created DESC
LIMIT 20;
