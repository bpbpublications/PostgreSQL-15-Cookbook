# Create regular table for FY 2021
create table sales_q1_2k21 ( like sales including all );
create table sales_q2_2k21 ( like sales including all );
create table sales_q3_2k21 ( like sales including all );

# Attach regular table to a partitioned table
ALTER TABLE SALES ATTACH PARTITION sales_q1_2k21 FOR VALUES FROM ('2021-01-01') TO ('2021-04-30');
ALTER TABLE SALES ATTACH PARTITION sales_q2_2k21 FOR VALUES FROM ('2021-05-01') TO ('2021-08-31');
ALTER TABLE SALES ATTACH PARTITION sales_q3_2k21 FOR VALUES FROM ('2021-09-01') TO ('2021-12-31');

# Verify the partitioned table
SELECT  
    p.relname AS partition_name,
    pg_get_expr(p.relpartbound, p.oid) AS partition_bound,
    pg_get_partkeydef(p.oid) AS partition_key
FROM
    pg_partition_tree('sales') AS t
    JOIN pg_class AS p ON p.oid = t.relid;

# Detach partition from partitioned table
ALTER TABLE sales DETACH PARTITION sales_q1_2k22;
ALTER TABLE sales DETACH PARTITION sales_q2_2k22;
ALTER TABLE sales DETACH PARTITION sales_q3_2k22;

# Verify the partitioned table
SELECT  
    p.relname AS partition_name,
    pg_get_expr(p.relpartbound, p.oid) AS partition_bound,
    pg_get_partkeydef(p.oid) AS partition_key
FROM
    pg_partition_tree('sales') AS t
    JOIN pg_class AS p ON p.oid = t.relid;

