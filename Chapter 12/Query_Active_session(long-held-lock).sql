SELECT pid,
       datid,
       usename,
       application_name,
       wait_event_type,
       wait_event,
       pg_blocking_pids(pid) AS blocker,
       backend_start,
       backend_type,
       query
FROM pg_stat_activity
WHERE wait_event IS NOT NULL
ORDER BY backend_start DESC;