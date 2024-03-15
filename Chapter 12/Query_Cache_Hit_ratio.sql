# Monitor Cache Hit Ratio
SELECT
pg_stat_statements.queryid,
pg_stat_statements.query,
pg_stat_statements.calls,
pg_stat_statements.blk_read_time,
pg_stat_statements.blk_write_time,
pg_stat_statements.shared_blks_hit,
pg_stat_statements.shared_blks_read,
pg_stat_statements.shared_blks_written,
(pg_stat_statements.shared_blks_hit * 100) /
NULLIF(pg_stat_statements.shared_blks_read + pg_stat_statements.sha
red_blks_hit, 0) as cache_hit_ratio
FROM pg_stat_statements;