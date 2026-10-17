-- Q16 по Bronze (ZSTD). Запускается 5 раз подряд (см. README), метка perf_zstd нужна для поиска в system.runtime.queries.
SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey) AS supplier_cnt
FROM bronze.perf_zstd.partsupp ps JOIN bronze.perf_zstd.part p ON p.partkey = ps.partkey
WHERE p.brand <> 'Brand#45' AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49,14,23,45,19,3,36,9)
  AND ps.suppkey NOT IN (SELECT suppkey FROM bronze.perf_zstd.supplier WHERE comment LIKE '%Customer%Complaints%')
GROUP BY p.brand, p.type, p.size
ORDER BY supplier_cnt DESC, p.brand, p.type, p.size;
