# Fetch Object-Level Privileges (Tables, Views, etc.)
SELECT 
    table_name,
    grantee,
    privilege_type
FROM 
    information_schema.table_privileges;