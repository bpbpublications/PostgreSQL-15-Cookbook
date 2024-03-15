# Verify the status of replication cluster on primary node
repmgr -f /etc/repmgr/15/repmgr.conf cluster show

# Verify the status of replication cluster on primary node
repmgr -f /etc/repmgr/15/repmgr.conf node check --archive-ready

# Execute dry-run switchover on standby node
repmgr -f /etc/repmgr/15/repmgr.conf standby switchover --dry-run

# Execute switchover on standby node
repmgr -f /etc/repmgr/15/repmgr.conf standby switchover

# New Primary node status
/usr/pgsql-15/bin/repmgr -f /etc/repmgr/15/repmgr.conf node status


