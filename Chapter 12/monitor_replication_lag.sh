#!/bin/bash
# Get replication lag in bytes
psql -U your_username -d your_database -c &quot;SELECT
  pg_is_in_recovery() AS is_slave,
  pg_last_wal_receive_lsn() AS receive_lsn,
  pg_last_wal_replay_lsn() AS replay_lsn,
  pg_last_wal_receive_lsn() = pg_last_wal_replay_lsn() AS is_synced,
  EXTRACT(EPOCH FROM now()) -
 EXTRACT(EPOCH FROM pg_last_xact_replay_timestamp()) AS replication_lag_sec
onds,
  pg_wal_lsn_diff(pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn()) AS replicat
ion_lag_bytes
FROM
  pg_stat_replication;&quot; &gt;&gt; /path/to/replication_lag.log