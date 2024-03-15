SELECT pg_stat_activity.pid, pg_stat_activity.query_start, pg_stat_activity.query 
FROM pg_stat_activity WHERE pg_stat_activity.state = &#39;active&#39;