# Create customer table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);
# Create reservation table
CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    room_number INTEGER NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    customer_id INTEGER NOT NULL,
    CONSTRAINT FK_Rsv_Dpt FOREIGN KEY (customer_id) REFERENCES customers(customer_
id)
);

# Insert data into the reservation table
INSERT INTO 
  reservations (room_number, check_in_date, check_out_date, customer_id)
  VALUES (101, '2023-05-01', '2023-05-03', 1);

# Insert data into the reservation table with existing Customer ID
INSERT INTO 
  reservations (room_number, check_in_date, check_out_date, customer_id)
  VALUES (101, '2023-05-01', '2023-05-03', 1);