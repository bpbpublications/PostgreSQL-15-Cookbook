# Check the Primary node health by executing on primary/standby node
/usr/pgsql-15/bin/repmgr -f /etc/repmgr/15/repmgr.conf node check

# Execute switchover on standby node
repmgr -f /etc/repmgr/15/repmgr.conf standby promote

