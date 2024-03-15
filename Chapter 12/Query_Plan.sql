SELECT substring(query, 1, 60) AS query_text,
       total_exec_time,
       blk_read_time,
       blk_write_time
FROM pg_stat_statements
WHERE total_exec_time > 100

ORDER BY total_exec_time DESC;