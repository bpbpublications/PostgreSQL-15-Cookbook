# Primary configuration 
wal_level = logical
max_wal_senders = 10
listen_addresses = 'Primary_IP'

# Create replication user 
CREATE USER repuser WITH REPLICATION PASSWORD 'Replication@123';

# Create replication user 
pg_basebackup -h primary_ip -U replication_user -D /path/to/backup -Fp -Xs -P -v -R

# Create replication user 
Restore_command = 'cp /pg_archive/%f %p'
primary_conninfo  = 'host=primary_ip port=pg_port user=replication_user password=password'

