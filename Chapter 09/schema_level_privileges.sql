# Fetch schema-level privileges 
SELECT 
    n.nspname AS schema_name,
    pg_roles.rolname AS owner,
    CASE 
        WHEN has_schema_privilege(n.nspname, 'USAGE') THEN 'USAGE'
        WHEN has_schema_privilege(n.nspname, 'CREATE') THEN 'CREATE'
        WHEN has_schema_privilege(n.nspname, 'CREATE TEMPORARY TABLE') THEN 'CREATE TEMPORARY TABLE'
        WHEN has_schema_privilege(n.nspname, 'CREATE ON SCHEMA') THEN 'CREATE ON SCHEMA'
        -- Add more WHEN clauses for other privileges as needed
        ELSE NULL
    END AS privileges,

    n.nspacl AS acl
FROM 
    pg_namespace n
JOIN 
    pg_roles ON n.nspowner = pg_roles.oid;