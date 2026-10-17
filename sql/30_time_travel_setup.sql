-- Сценарий: кто-то по ошибке удалил часть Silver. Потом восстанавливаем из снапшота.
SELECT count(*) AS rows_before FROM silver.lakehouse.part_supplier;

-- Все снапшоты. Запомни snapshot_id самого свежего (до удаления) — он нужен для восстановления.
SELECT snapshot_id, operation, committed_at
FROM silver.lakehouse."part_supplier$snapshots" ORDER BY committed_at;

-- "Авария"
DELETE FROM silver.lakehouse.part_supplier WHERE brand = 'Brand#11';
SELECT count(*) AS rows_after_delete FROM silver.lakehouse.part_supplier;

SELECT snapshot_id, operation, committed_at
FROM silver.lakehouse."part_supplier$snapshots" ORDER BY committed_at;
