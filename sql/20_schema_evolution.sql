-- Schema evolution на Silver: файлы данных не переписываются, меняются только метаданные.
SHOW COLUMNS FROM silver.lakehouse.part_supplier;

-- 1) ADD COLUMN: у старых строк новая колонка = NULL
ALTER TABLE silver.lakehouse.part_supplier ADD COLUMN loaded_at timestamp(6);
SELECT partkey, suppkey, loaded_at FROM silver.lakehouse.part_supplier LIMIT 3;

-- 2) RENAME COLUMN: размер -> part_size, старые файлы читаются (Iceberg ищет колонку по ID, не по имени)
ALTER TABLE silver.lakehouse.part_supplier RENAME COLUMN size TO part_size;
SELECT partkey, part_size FROM silver.lakehouse.part_supplier LIMIT 3;

-- 3) Возвращаем всё как было, чтобы Gold/запросы не сломались
ALTER TABLE silver.lakehouse.part_supplier RENAME COLUMN part_size TO size;
ALTER TABLE silver.lakehouse.part_supplier DROP COLUMN loaded_at;
SHOW COLUMNS FROM silver.lakehouse.part_supplier;
