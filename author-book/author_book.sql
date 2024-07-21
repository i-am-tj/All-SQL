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
(10, 25),
(1, 3),
(2, 6),
(3, 8),
(4, 1),
(5, 7),
(6, 12),
(7, 10);

-- Verify Authors table
SELECT * FROM Authors;

-- Verify Books table
SELECT * FROM Books;

-- Verify Author_Book table
SELECT * FROM Author_Book;

-- 1. Find the total number of books written by each author. (Display author_id and count)
SELECT author_id, COUNT(book_id)
FROM Author_Book
GROUP BY author_id;

-- 1. Find the total number of books written by each author. (Display author_name and count)
SELECT a.name, COUNT(ab.book_id)
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY a.author_id;

-- 2. List all authors who have written more than three books.
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY a.author_id
HAVING COUNT(ab.book_id) > 3;

-- 3. Find all books that have multiple authors.
SELECT b.title
FROM Books b
INNER JOIN Author_Book ab
ON b.book_id = ab.book_id
GROUP BY ab.book_id
HAVING COUNT(ab.author_id) > 1;

-- 4. List all authors who have collaborated with another author on a book.
SELECT DISTINCT a.name
FROM Authors a
INNER JOIN Author_Book ab1
ON a.author_id = ab1.author_id
INNER JOIN Author_Book ab2
ON ab1.book_id = ab2.book_id
AND ab1.author_id <> ab2.author_id;

-- 5. Find the most prolific author (the author who has written the most books).
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY ab.author_id
ORDER BY COUNT(ab.book_id) DESC
LIMIT 1;

-- Interview Question
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