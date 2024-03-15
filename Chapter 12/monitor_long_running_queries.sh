#!/bin/bash
# Set the threshold for long-running queries in seconds
THRESHOLD=60
# Log queries exceeding the threshold
psql -U your_username -d your_database -
c &quot;SELECT * FROM pg_stat_activity WHERE state = &#39;active&#39; AND now() -
 pg_stat_activity.query_start &gt;= interval &#39;$THRESHOLD seconds&#39;;&quot; &gt;&gt; /pat
h/to/long_running_queries.log