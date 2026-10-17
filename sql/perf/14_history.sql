SELECT state, substr(query, 1, 70) AS q, date_diff('millisecond', created, "end") AS ms
FROM system.runtime.queries
ORDER BY created DESC
LIMIT 30;
