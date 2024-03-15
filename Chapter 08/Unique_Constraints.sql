# Create reservations table
CREATE TABLE reservations (
  reservation_id SERIAL PRIMARY KEY,
  guest_name TEXT NOT NULL,
  guest_email TEXT NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  room_number INTEGER NOT NULL
);

# Add constraint on reservation table
ALTER TABLE reservations ADD CONSTRAINT unique_reservation_id UNIQUE (reservation_id);
ALTER TABLE reservations ADD CONSTRAINT unique_guest_email UNIQUE (guest_email);

# Insert data into the reservation table
INSERT INTO reservations (guest_name, guest_email, check_in_date, check_out_date, room_number) VALUES ('Bugs Bunny', 'bugsbunny@pgtest.com', '2023-06-20', '2023-06-23', 103);

