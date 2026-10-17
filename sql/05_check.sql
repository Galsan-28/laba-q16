-- Проверка: Gold должен совпасть с эталонным запросом на tpch (должно вернуться 0 строк в обоих запросах).
(SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey) AS supplier_cnt
 FROM tpch.sf1.partsupp ps JOIN tpch.sf1.part p ON p.partkey = ps.partkey
 WHERE p.brand <> 'Brand#45' AND p.type NOT LIKE 'MEDIUM POLISHED%'
   AND p.size IN (49,14,23,45,19,3,36,9)
   AND ps.suppkey NOT IN (SELECT suppkey FROM tpch.sf1.supplier WHERE comment LIKE '%Customer%Complaints%')
 GROUP BY p.brand, p.type, p.size)
EXCEPT
(SELECT brand, type, size, supplier_cnt FROM gold.lakehouse.supplier_cnt_by_part);

(SELECT brand, type, size, supplier_cnt FROM gold.lakehouse.supplier_cnt_by_part)
EXCEPT
(SELECT p.brand, p.type, p.size, count(DISTINCT ps.suppkey)
 FROM tpch.sf1.partsupp ps JOIN tpch.sf1.part p ON p.partkey = ps.partkey
 WHERE p.brand <> 'Brand#45' AND p.type NOT LIKE 'MEDIUM POLISHED%'
   AND p.size IN (49,14,23,45,19,3,36,9)
   AND ps.suppkey NOT IN (SELECT suppkey FROM tpch.sf1.supplier WHERE comment LIKE '%Customer%Complaints%')
 GROUP BY p.brand, p.type, p.size);

SELECT * FROM gold.lakehouse.supplier_cnt_by_part
ORDER BY supplier_cnt DESC, brand, type, size LIMIT 10;
