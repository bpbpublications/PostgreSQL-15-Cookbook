# Analyze the WAL
pg_waldump -s 0/B2426758 -e 0/B5000110

# Update recovery timestamp on postgresql.conf file
recovery_target_time = '2023-04-02 20:36:00'

# Update recovery timestamp on postgresql.conf file
recovery_target_lsn = '0/B2426758'

# Start postgresql cluster service
systemctl start postgresql-15.service