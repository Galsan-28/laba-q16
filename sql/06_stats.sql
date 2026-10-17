-- Цифры для таблиц отчёта (раздел 4): строки и вес в МБ по каждой таблице.
SELECT 'bronze.part' AS tbl, (SELECT count(*) FROM bronze.lakehouse.part) AS row_cnt,
       round(sum(file_size_in_bytes)/1048576.0, 2) AS mb, count(*) AS files FROM bronze.lakehouse."part$files"
UNION ALL SELECT 'bronze.partsupp', (SELECT count(*) FROM bronze.lakehouse.partsupp),
       round(sum(file_size_in_bytes)/1048576.0, 2), count(*) FROM bronze.lakehouse."partsupp$files"
UNION ALL SELECT 'bronze.supplier', (SELECT count(*) FROM bronze.lakehouse.supplier),
       round(sum(file_size_in_bytes)/1048576.0, 2), count(*) FROM bronze.lakehouse."supplier$files"
UNION ALL SELECT 'silver.part_supplier', (SELECT count(*) FROM silver.lakehouse.part_supplier),
       round(sum(file_size_in_bytes)/1048576.0, 2), count(*) FROM silver.lakehouse."part_supplier$files"
UNION ALL SELECT 'gold.supplier_cnt_by_part', (SELECT count(*) FROM gold.lakehouse.supplier_cnt_by_part),
       round(sum(file_size_in_bytes)/1048576.0, 2), count(*) FROM gold.lakehouse."supplier_cnt_by_part$files";
