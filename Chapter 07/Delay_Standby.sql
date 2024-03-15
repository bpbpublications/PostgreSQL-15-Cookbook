# WAL configuration on primary server
wal_level = replica
max_wal_senders = 10
archive_mode = on
archive_command = 'cp %p /path/to/archive/%f'



# Start postgresql cluster service
systemctl start postgresql-15.service

# Create a backup of the standby server
pg_basebackup -h <primary_serv_ip> -U replicapg -p 5432 -D /PG_DATAPATH/ -Fp -Xs -P -R

# Configuration on postgresql.conf file
recovery_min_apply_delay = '5min'

# Configuration on postgresql.conf file
recovery_min_apply_delay = '5min'

# Start postgresql cluster service
systemctl start postgresql-15.service


# Verify the current LSN from Primary server
SELECT pg_current_wal_lsn();

# Verify the LAST Receive and Replay LSN from Delay Standby server
select now(), pg_is_in_recovery(),pg_is_wal_replay_paused(), pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn();

# Verify LSN difference
 SELECT pg_wal_lsn_diff('0/3B000000', '0/3909E3A0');

