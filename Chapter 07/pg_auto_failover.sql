# WAL configuration on primary server
wal_level = replica
max_wal_senders = 10
archive_mode = on
archive_command = 'cp %p /path/to/archive/%f'

# Update the pg_hba.conf on primary server with standby server ip
host replication all standby_ip_address/32 md5

# Create replication user on primary server
CREATE USER replicapg REPLICATION LOGIN PASSWORD 'password';

# Create a backup of the standby server
pg_basebackup -h <primary_serv_ip> -U replicapg -p 5432 -D /PG_DATAPATH/ -Fp -Xs -P -R

# pg_auto_failover downloaded package
pg _auto_failover_15-2.0-1.rhel9.x86_64.rpm
pg_auto_failover_15-llvmjit-2.0-1.rhel9.x86_64.rpm

# Install pg_auto_failover package 
yum localinstall pg_auto_failover_15-llvmjit-2.0-1.rhel9.x86_64.rpm pg_auto_failover_15-2.0-1.rhel9.x86_64.rpm -y

# Verify the installed pg_auto_failover version
/usr/pgsql-15/bin/pg_autoctl --version

# Create a directory 
mkdir -p /var/lib/pgsql/15/data/auto_monitor

# Initialize pg_auto_failover 
/usr/pgsql-15/bin/pg_autoctl create monitor --hostname localhost --pgdata /var/lib/pgsql/15/data/auto_monitor --pgport 5888 --auth trust --no-ssl

# Start the pg_auto_failover service
/usr/pgsql-15/bin/pg_autoctl run &

# generate a connection string for the pg_auto_failover monitor
 /usr/pgsql-15/bin/pg_autoctl show uri

# Verify the node status
/usr/pgsql-15/bin/pg_autoctl show state --pgdata /var/lib/pgsql/15/data/

# Configure primary database 
/usr/pgsql-15/bin/pg_autoctl create postgres --hostname 192.168.187.134 --pgdata /var/lib/pgsql/15/data/auto_monitor –-pgport 5433 --auth trust --no-ssl --username postgres --dbname dbmon --monitor 'postgres://autoctl_node@192.168.187.134:5888/pg_auto_failover?sslmode=prefer'

# Configure primary database 
/usr/pgsql-15/bin/pg_autoctl create postgres --hostname 192.168.187.134 –-
pgport 5434 --pgdata /var/lib/pgsql/15/data/auto_monitor --auth trust --no-ssl--monitor 'postgres://autoctl_node@192.168.187.134:5888/pg_auto_failover?sslmode=prefer' –-run

# Verify the added node status
/usr/pgsql-15/bin/pg_autoctl show state --pgdata /var/lib/pgsql/15/data/

# Graceful switchover 
/usr/pgsql-15/bin/pg_autoctl perform switchover

# Verify the switchover status on the new primary node
/usr/pgsql-15/bin/pg_autoctl show state --pgdata /var/lib/pgsql/15/data/


