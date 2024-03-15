import psycopg2
from io import BytesIO
from PIL import Image

# Connect to the PostgreSQL database
conn = psycopg2.connect("dbname=postgres user=postgres password=postgres host=192.168.187.134")
cur = conn.cursor()

# Retrieve the image data
cur.execute("SELECT image_data FROM images WHERE image_name = 'IMG_1495.png'")
image_data = cur.fetchone()[0]

# Close the database connection
cur.close()
conn.close()

# Display the image using Python's PIL library (Pillow)
image = Image.open(BytesIO(image_data))
image.show()