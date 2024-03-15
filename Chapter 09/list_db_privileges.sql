# List database privileges
SELECT 
    datname AS database_name,
    pg_roles.rolname AS owner,
    datacl AS privileges
FROM 
    pg_database
JOIN 
    pg_roles ON pg_database.datdba = pg_roles.oid;