#!/bin/bash
# Get the number of connections
psql -U your_username -d your_database -
c &quot;SELECT datname, numbackends FROM pg_stat_database;&quot; &gt;&gt; /path/to/conn
ection_count.log