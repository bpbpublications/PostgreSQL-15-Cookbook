# create a range partitioned table
CREATE TABLE sales (
   sale_id SERIAL,
   sale_date DATE NOT NULL,
   sale_amount NUMERIC(10,2) NOT NULL,
   PRIMARY KEY (sale_id, sale_date)
) PARTITION BY RANGE (sale_date);

# create partition table
CREATE TABLE sales_q1_2k22 PARTITION OF sales FOR VALUES FROM ('2022-01-01') TO ('2022-04-30');
CREATE TABLE sales_q2_2k22 PARTITION OF sales FOR VALUES FROM ('2022-05-01') TO ('2022-08-31');
CREATE TABLE sales_q3_2k22 PARTITION OF sales FOR VALUES FROM ('2022-09-01') TO ('2022-12-31');
CREATE TABLE sales_q1_2k23 PARTITION OF sales FOR VALUES FROM ('2023-01-01') TO ('2023-04-30');

CREATE TABLE sales_q2_2k23 PARTITION OF sales FOR VALUES FROM ('2023-05-01') TO ('2023-08-31');
CREATE TABLE sales_q3_2k23 PARTITION OF sales FOR VALUES FROM ('2023-09-01') TO ('2023-12-31');

# Insert Data into partition table
INSERT INTO sales (sale_date, sale_amount) VALUES
   ('2022-01-12', 1000.00),
   ('2022-05-15', 2000.00),
   ('2022-09-19', 1000.00),
   ('2023-01-12', 1000.00),
   ('2023-05-15', 2000.00),
   ('2023-09-19', 1000.00);

# Verify the partitioned table
SELECT  
    p.relname AS partition_name,
    pg_get_expr(p.relpartbound, p.oid) AS partition_bound,
    pg_get_partkeydef(p.oid) AS partition_key
FROM
    pg_partition_tree('sales') AS t
    JOIN pg_class AS p ON p.oid = t.relid;

# Select data from specific partition 
SELECT * FROM sales_q2_2k22 WHERE sale_date BETWEEN '2022-04-01' AND '2022-08-31';

