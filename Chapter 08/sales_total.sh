#!/bin/bash
psql -U postgres -d mydb -
c "SELECT SUM(amount) FROM sales WHERE product_name = 'Product A';" > sales_total.
txt
cat sales_total.txt | awk '{print $1}'
psql -U postgres -d mydb -c "\q"