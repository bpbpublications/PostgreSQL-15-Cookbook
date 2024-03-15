# Check the replication status
SELECT pg_switch_wal();

# Check the replication status
SELECT pg_is_in_recovery();

# Promote the standby server to the primary server.
SELECT pg_promote();

