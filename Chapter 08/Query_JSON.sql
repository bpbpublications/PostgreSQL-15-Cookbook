CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  details JSONB
);

INSERT INTO employees (name, address, details)
VALUES ('Homper Simpson', '111 St', '{"department": "IT", "salary": 50000}');
INSERT INTO employees (name, address, details)
VALUES ('Charlie Brown', '112 St', '{"department": "HR", &quot;salary": 60000}');

SELECT name, details->>'department' as department FROM employees;

# Execute select query on employees table
SELECT name, details->>'department' as department
FROM employees
WHERE details->>'department' = 'IT';

# Execute update query on employees table
UPDATE employees
SET details = jsonb_set(details, '{employees,0,phone}', '"000-111-1234"')
WHERE id = 1;

# Execute update query on employees table
UPDATE employees
SET details = jsonb_set(details, '{employees,1,email}', null)
WHERE id = 1;

