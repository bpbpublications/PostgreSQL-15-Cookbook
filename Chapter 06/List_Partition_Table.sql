# create a List partitioned table
CREATE TABLE seller (
  sale_id SERIAL,
  sale_date DATE NOT NULL,
  product_id TEXT NOT NULL,
  sale_amount NUMERIC(10, 2) NOT NULL,
  PRIMARY KEY (sale_id, product_id)
) PARTITION BY LIST (product_id);


# create a List partitioned table
CREATE TABLE seller_software PARTITION OF seller FOR VALUES IN ('PG_DB', 'IBM_DB2', 'DB_MYSQL', 'RHEL');
CREATE TABLE seller_hardware PARTITION OF seller FOR VALUES IN ('PSERIES', 'iSERIES');
CREATE TABLE seller_general PARTITION OF seller DEFAULT;


# Insert Data into partition table
INSERT INTO seller (sale_date, product_id, sale_amount) VALUES ('2023-01-01', 'PG_DB', 100.00);
INSERT INTO seller (sale_date, product_id, sale_amount) VALUES ('2023-01-02', 'iSERIES', 200.00);
INSERT INTO seller (sale_date, product_id, sale_amount) VALUES ('2023-01-03', 'Annual Maintenance', 400.00);

# Verify the partitioned table
SELECT  
    p.relname AS partition_name,
    pg_get_expr(p.relpartbound, p.oid) AS partition_bound,
    pg_get_partkeydef(p.oid) AS partition_key
FROM
    pg_partition_tree('seller') AS t
    JOIN pg_class AS p ON p.oid = t.relid;

# Select data from seller_software partition 

SELECT * FROM seller_software
WHERE sale_date BETWEEN '2023-01-01' AND '2023-03-01';

# Select data from seller_general partition 
SELECT * FROM seller_general
WHERE sale_date BETWEEN '2022-01-01' AND '2023-03-01';



