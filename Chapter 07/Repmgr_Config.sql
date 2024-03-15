# WAL configuration on primary server
wal_level = replica
max_wal_senders = 10
archive_mode = on
archive_command = 'cp %p /path/to/archive/%f'
hot_standby = on

# repmgr library configuration on primary server
shared_preload_libraries = 'repmgr'

# Configure pg_hba.conf for repmgr
host    repmgr          repmgr          192.168.187.134/32      trust
host    repmgr          repmgr          192.168.187.133/32      trust

# Start postgresql cluster service
systemctl start postgresql-15.service

# Install repmgr on primary and standby node
yum localinstall -y
repmgr_15-5.3.3-1.rhel9.x86_64.rpm 
repmgr_15-devel-5.3.3-1.rhel9.x86_64.rpm 
repmgr_15-llvmjit-5.3.3-1.rhel9.x86_64.rpm

# Create user for repmgr with replication privileges
CREATE USER repmgr WITH REPLICATION SUPERUSER PASSWORD 'Repmgr123';
# Create database for repmgr 
CREATE DATABASE repmgr owner repmgr;
# Set the search path to repmgr
ALTER USER repmgr SET search_path TO repmgr, "$user", public;

# Repmgr configuration on primary node
node_id=1
node_name='node_master'
conninfo='host=192.168.17.134 dbname=repmgr port=5432 user=repmgr password=Repmgr123 connect_timeout=2'
data_directory='/var/lib/pgsql/15/data'
log_file='/var/lib/pgsql/15/data/log/repmgr.log'

# Register primary node
/usr/pgsql-15/bin/repmgr -f /etc/repmgr/15/repmgr.conf primary register

# Verify the registered node
SELECT node_id, node_name, type, conninfo, repluser, config_file  FROM repmgr.nodes;

# Repmgr configuration on standby node
node_id=2
node_name='node_slave'
conninfo='host=192.168.17.133 dbname=repmgr port=5432 user=repmgr password=password connect_timeout=2'
data_directory='/var/lib/pgsql/15/data'
log_file='/var/lib/pgsql/15/data/log/repmgr.log'

# Execute dry-run on the standby node
/usr/pgsql-15/bin/repmgr -h 192.168.187.134 -U repmgr -d repmgr -f /etc/repmgr/15/repmgr.conf -D /var/lib/pgsql/15/data standby clone --dry-run

# Execute without dry-run on the standby node
/usr/pgsql-15/bin/repmgr -h 192.168.187.134 -U repmgr -d repmgr -f /etc/repmgr/15/repmgr.conf -D /var/lib/pgsql/15/data standby clone

# Register Standby node
/usr/pgsql-15/bin/repmgr -f /etc/repmgr/15/repmgr.conf standby register

# Verify the registered node
SELECT node_id, node_name, type, conninfo, repluser, config_file  FROM repmgr.nodes;

# start the repmgrd daemon on primary and Standby node
/usr/pgsql-15/bin/repmgrd -f /etc/repmgr/15/repmgr.conf

# Create sample database and table on primary node for replication test
psql -h <primary_node_ip> -U postgres
CREATE DATABASE replica_db;
\c replica_db
CREATE TABLE replicat_table (id serial primary key, name varchar(50));
INSERT INTO replica_table (name) VALUES ('test');


# verify replica_db database and replica_table table on the standby node
psql -h <standby_node_ip> -U postgres
\c replica_db
SELECT * FROM replica_table;

