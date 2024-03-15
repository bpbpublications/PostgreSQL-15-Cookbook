select name, setting,unit from pg_settings where name in ('archive_mode', 'arc
hive_command', 'wal_keep_size', 'wal_level');