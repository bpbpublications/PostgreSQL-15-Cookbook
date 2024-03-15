# Fetch Object-Level Privileges (Functions, Procedures, etc.):
SELECT 
    specific_name,
    grantee,

    privilege_type
FROM 
    information_schema.routine_privileges;