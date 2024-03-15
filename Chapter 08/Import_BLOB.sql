# Create a table to store image data
CREATE TABLE images (
    image_id serial PRIMARY KEY,
    image_name text,
    image_data bytea
);

# Import an image file into the &quot;images&quot; table
INSERT INTO images (image_name, image_data) VALUES ('IMG_1495.png', pg_read_binary_file('/var/lib/pgsql/IMG_1495.png')::bytea);

# Retrieve and display a specific image by name
SELECT image_name, image_data FROM images WHERE image_name = 'IMG_1495.PNG';

