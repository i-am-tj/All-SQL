-- Create the Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create the Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- Create the Author_Book table (junction table)
CREATE TABLE Author_Book (
    author_id INT,
    book_id INT,
    PRIMARY KEY (author_id, book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert dummy values into the Authors table
INSERT INTO Authors (author_id, name) VALUES
(1, 'J.K. Rowling'),
(2, 'George R.R. Martin'),
(3, 'J.R.R. Tolkien'),
(4, 'Agatha Christie'),
(5, 'Stephen King'),
(6, 'Isaac Asimov'),
(7, 'Arthur C. Clarke'),
(8, 'Philip K. Dick'),
(9, 'Frank Herbert'),
(10, 'H.G. Wells');

-- Insert dummy values into the Books table
INSERT INTO Books (book_id, title) VALUES
(1, 'Harry Potter and the Philosophers Stone'),
(2, 'Harry Potter and the Chamber of Secrets'),
(3, 'A Game of Thrones'),
(4, 'A Clash of Kings'),
(5, 'The Hobbit'),
(6, 'The Lord of the Rings'),
(7, 'Murder on the Orient Express'),
(8, 'The Shining'),
(9, 'It'),
(10, 'Foundation'),
(11, 'I, Robot'),
(12, '2001: A Space Odyssey'),
(13, 'Do Androids Dream of Electric Sheep?'),
(14, 'Dune'),
(15, 'The War of the Worlds'),
(16, 'The Time Machine'),
(17, 'The Invisible Man'),
(18, 'Childhoods End'),
(19, 'The Gods Themselves'),
(20, 'The Man in the High Castle'),
(21, 'The Moon is a Harsh Mistress'),
(22, 'Stranger in a Strange Land'),
(23, 'Fahrenheit 451'),
(24, 'Brave New World'),
(25, '1984');

-- Insert dummy values into the Author_Book table
INSERT INTO Author_Book (author_id, book_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(5, 8),
(5, 9),
(6, 10),
(6, 11),
(7, 12),
(8, 13),
(9, 14),
(10, 15),
(10, 16),
(10, 17),
(7, 18),
(6, 19),
(8, 20),
(6, 21),
(8, 22),
(9, 23),
(9, 24),
(10, 25);

-- Verify Authors table
SELECT * FROM Authors;

-- Verify Books table
SELECT * FROM Books;

-- Verify Author_Book table
SELECT * FROM Author_Book;

-- Get Author Name of all Book Titles Ordered By Title Names
SELECT title, name
FROM Books b
INNER JOIN Author_Book ab 
ON b.book_id = ab.book_id
INNER JOIN Authors a
ON ab.author_id = a.author_id
ORDER BY title;

-- Counting Books Written by Each Author
SELECT name, count(b.book_id) as book_count
FROM Books b
INNER JOIN Author_Book ab
ON b.book_id = ab.book_id
INNER JOIN Authors a
ON ab.author_id = a.author_id
GROUP BY name;