#!/bin/bash

# Get table sizes in MB
psql -U your_username -d your_database -
c &quot;SELECT schemaname, tablename, pg_size_pretty(pg_total_relation_size(
schemaname || &#39;.&#39; || tablename)) AS size FROM pg_tables ORDER BY pg_tot
al_relation_size(schemaname || &#39;.&#39; || tablename) DESC;&quot; &gt;&gt; /path/to/tab
le_sizes.log