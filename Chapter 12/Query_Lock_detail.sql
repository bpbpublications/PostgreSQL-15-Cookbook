SELECT pid,
       MODE,
       locktype,
       relation::regclass,
       page,
       tuple
FROM pg_locks
WHERE pid in ('508499',
              '508335');