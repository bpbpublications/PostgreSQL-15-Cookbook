CREATE TABLE 
   string_data (
   id SERIAL PRIMARY KEY,
   string_value VARCHAR(20)
   );

INSERT INTO string_data (string_value) VALUES ('123'), ('456'), ('789');

SELECT pg_typeof(string_value) FROM string_data;

SELECT CAST(string_value AS numeric) FROM string_data;

# Execute select statement with CAST operator
SELECT id, CAST(string_value AS numeric) AS numeric_value FROM string_data;

