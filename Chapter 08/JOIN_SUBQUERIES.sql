# Create the authors table
CREATE TABLE authors (
    author_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);
# Create the books table
CREATE TABLE books (
    book_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    author_id INT REFERENCES authors(author_id)
);

# Insert  sample data
INSERT INTO authors (author_name) VALUES
    ('Tom A'),
    ('Jerry A'),
    ('Lego A');

INSERT INTO books (title, isbn, author_id) VALUES
    ('Mastery SQL', '000-123456', 1),
    ('Database Essentials', '000-987654', 2),
    ('PGs Mastery', '000-555555', 3);


SELECT books.title, authors.author_name
FROM books
JOIN authors ON books.author_id = authors.author_id;

SELECT books.title, authors.author_name
FROM books
LEFT JOIN authors ON books.author_id = authors.author_id;

SELECT author_name
FROM authors
WHERE author_id IN (
    SELECT author_id
    FROM books
    GROUP BY author_id
    HAVING COUNT(*) > 1
);

SELECT title
FROM books b
WHERE LENGTH(title) > (
    SELECT AVG(LENGTH(title))
    FROM books
);

