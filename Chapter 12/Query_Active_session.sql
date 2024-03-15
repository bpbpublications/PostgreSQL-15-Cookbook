SELECT pid,
       datid,
       usename,
       application_name,
       backend_start,
       backend_type,
       state,

    query
FROM pg_stat_activity
WHERE state = 'active';