#!/bin/bash
# Set environment variables for PostgreSQL connection
export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
export PGPASSWORD=postgres
export PGDATABASE=postgres

# Define partitioning parameters
parent_table_name="orders"
partition_field_name="order_date"
partition_interval="monthly"
start_date=$(date +%Y-%m-%d)
end_date="$(date +%Y-%m-%d -d 'today + 20 months')"

# Create a partition for table orders
current_date="${start_date}"
while [[ "${current_date}" < "${end_date}" ]]; do
    partition_name="${parent_table_name}_p$(date +%Y_%m -
d "${current_date}")"
    partition_bound="'${current_date}'::date"
    next_month="$(date +%Y-%m -d "${current_date} + 1 month")"
psql -
c "CREATE TABLE ${partition_name} PARTITION OF ${parent_table_name} FOR VAL
UES FROM (${partition_bound}) TO ('${next_month}-01'::date - interval -
'1 day');" -q
    current_date="${next_month}-01"
done