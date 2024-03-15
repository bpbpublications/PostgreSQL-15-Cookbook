# Create a partition table 
CREATE TABLE trips (
    trip_id int,
    rider_id int,
    driver_id int,
    trip_date date,
    pickup_location text,
    dropoff_location text,
    fare numeric
) PARTITION BY RANGE (trip_date);


# Create a partition table
CREATE TABLE trips_2020_01_01 PARTITION OF trips FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');
CREATE TABLE trips_2020_02_01 PARTITION OF trips FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');
CREATE TABLE trips_2020_03_01 PARTITION OF trips FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

# Create an index on the trip_date column
CREATE INDEX trips_2020_trip_date_idx ON trips (trip_date);


# Create a partition table 
SELECT SUM(fare) FROM trips WHERE trip_date = '2020-01-01';

