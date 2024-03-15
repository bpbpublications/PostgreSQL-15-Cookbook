# Fetch specific table Privileges 
SELECT 
    table_name,
    grantee,
    privilege_type
FROM 
    information_schema.table_privileges where table_name='table_name';