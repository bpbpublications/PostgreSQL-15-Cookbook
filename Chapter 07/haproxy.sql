# Verify the status of replication
select pid,usename,application_name,state,sync_state,sent_lsn,reply_time FROM pg_stat_replication;

# Verify the status of replication
select pg_last_wal_receive_lsn;

# Install HAProxy package on a dedicated proxy node
yum install haproxy -y

# Update the configuration in /etc/haproxy/haproxy.cfg file
global
    log 127.0.0.1 local2
    chroot /var/lib/haproxy
    pidfile /var/run/haproxy.pid
    maxconn 1000
    user haproxy
    group haproxy
    daemon
defaults

    mode  tcp
    log  global
    retries 3
    timeout connect 10s
    timeout client 1m
    timeout server 1m
    timeout check 10s
listen stats
    mode tcp
    bind *:5000
    stats enable
    stats uri /
listen postgresql_primary
    bind *:5432
    mode tcp
    option tcp-check
    default_backend postgresql_secondary
listen postgresql_secondary
    bind *:5432
    mode tcp
    balance roundrobin
    default-server inter 3s fall 3 rise 2 on-marked-down shutdown-sessions  
    server pg_pri 192.168.187.133:5432 check
    server pg_sec 192.168.187.134:5432 check


# Restart haproxy service
systemctl restart haproxy



