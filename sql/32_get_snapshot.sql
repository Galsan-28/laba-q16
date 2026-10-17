SELECT snapshot_id FROM silver.lakehouse."part_supplier$snapshots" ORDER BY committed_at DESC OFFSET 1 LIMIT 1;
