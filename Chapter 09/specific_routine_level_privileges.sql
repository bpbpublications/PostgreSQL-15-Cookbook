# Fetch specific routine Privileges 
SELECT 
    specific_name,
    grantee,
    privilege_type
FROM 
    information_schema.routine_privileges where specific_name='routine_name';