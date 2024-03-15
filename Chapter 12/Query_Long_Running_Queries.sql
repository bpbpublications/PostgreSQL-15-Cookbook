# Monitor Long running queries
WITH statements AS (
    SELECT
        pss.calls,
        pss.mean_exec_time / 1000 AS mean_exec_time_seconds,
        pss.query,
        pr.rolname,
        EXTRACT(EPOCH FROM now()) -
 EXTRACT(EPOCH FROM pg_stat_activity.query_start) AS duration_seconds
    FROM
        pg_stat_statements pss
        JOIN pg_roles pr ON pss.userid = pr.oid
        CROSS JOIN pg_stat_activity
    WHERE
        pr.rolname = current_user
        AND pg_stat_activity.state = &#39;active&#39;

        AND EXTRACT(EPOCH FROM now()) -
 EXTRACT(EPOCH FROM pg_stat_activity.query_start) &gt; 300 --
 300 seconds (5 minutes)
)
SELECT
    calls,
    mean_exec_time_seconds,
    query,
    duration_seconds
FROM
    statements
WHERE
    calls &gt; 500
    AND duration_seconds &gt; 0
ORDER BY
    mean_exec_time_seconds DESC
LIMIT 10;