import psycopg2

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    host="192.168.187.134",
    database="mydb",
    user="myusr",
    password="mypassword"
)
print(" ## Connected to PostgreSQL database! MYDB ## ")
print()

# Create a cursor object to interact with the database
cur = conn.cursor()
print(" ## Select dataset from sales table! ## ")
print("----------------------------------------------")

# Execute a SQL query
cur.execute("SELECT * FROM sales")

# Fetch the results of the query
rows = cur.fetchall()

# Print the results
for row in rows:
    print(row)

# Close the cursor and database connection
cur.close()
conn.close()