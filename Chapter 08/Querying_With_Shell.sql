psql -U <username> -d <database_name> -c "<query>"

psql -U postgres -d mydb -c "SELECT SUM(amount) FROM sales WHERE product_name = 'Server_Hardware';"

psql -U postgres -d mydb -c "SELECT SUM(amount) FROM sales WHERE product_name = 'Server_hardware';" > sales_total.txt

cat sales_total.txt | awk '{print $1}'

psql -U <username> -d <database_name> -c '\q"

psql -U postgres -d mydb -c "\q"

