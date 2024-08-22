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
(10, 'H.G. Wells'),
(11, 'Jeff Keller');

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
(25, '1984'),
(26, 'Atomic Habits');

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

-- 6. List the titles of books written by 'J.K. Rowling'.
SELECT b.title
FROM Books b
INNER JOIN Author_Book ab
ON b.book_id = ab.book_id
INNER JOIN Authors a
ON ab.author_id = a.author_id
WHERE a.name = 'J.K. Rowling';

-- 7. Find all authors who have written a book in the 'Harry Potter' series.
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
INNER JOIN Books b
ON ab.book_id = b.book_id
WHERE b.title LIKE 'Harry Potter%';

-- 8. List all books and their authors.
SELECT b.title, a.name
FROM Books b
INNER JOIN Author_Book ab
ON b.book_id = ab.book_id
INNER JOIN Authors a
ON ab.author_id = a.author_id;

-- 10. List all books that do not have an author in the database.
SELECT b.title
FROM Books b
LEFT JOIN Author_Book ab
ON b.book_id = ab.book_id
WHERE ab.author_id IS NULL;

-- 11. Find the number of unique authors who have written at least one book.
SELECT COUNT(DISTINCT author_id)
FROM Author_Book;

-- 12. List all authors who have never written a book.
SELECT a.name
FROM Authors a
LEFT JOIN Author_Book ab
ON a.author_id = ab.author_id
WHERE ab.author_id IS NULL;

-- 13. Find all authors who have written exactly two books.
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY a.author_id
HAVING COUNT(ab.book_id) = 2;

-- 15. Find the number of books written by each author, including those with no books.
SELECT a.name, COUNT(ab.book_id) as book_count
FROM Authors a
LEFT JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY a.author_id;

-- 16. List all authors and the titles of books they have written, even if they have written no books.
SELECT a.name, b.title
FROM Authors a
LEFT JOIN Author_Book ab
ON a.author_id = ab.author_id
LEFT JOIN Books b
ON ab.book_id = b.book_id;

-- 17. Find all authors who have written a book with 'World' in the title.
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
INNER JOIN Books b
ON ab.book_id = b.book_id
WHERE b.title LIKE '%World%';

-- 18. List all books written by multiple authors, and the names of those authors. (Partially correct answer)
SELECT b.title, a.name
FROM Books b
INNER JOIN Author_Book ab
ON b.book_id = ab.book_id
INNER JOIN Authors a
ON ab.author_id = a.author_id
GROUP BY b.book_id
HAVING COUNT(ab.author_id) > 1;

-- 19. Find all authors who have written more books than 'Stephen King'.
SELECT a.name
FROM Authors a
JOIN Author_Book ab ON a.author_id = ab.author_id
GROUP BY a.author_id
HAVING COUNT(ab.book_id) > (
    SELECT COUNT(*)
    FROM Author_Book ab2
    JOIN Authors a2 ON ab2.author_id = a2.author_id
    WHERE a2.name = 'Stephen King'
);

-- Interview Question --
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

-- Bonus Section --
-- Find all authors who have written a book with another author.
SELECT DISTINCT a1.name
FROM Authors a1
INNER JOIN Author_Book ab1
ON a1.author_id = ab1.author_id
INNER JOIN Author_Book ab2
ON ab1.book_id = ab2.book_id
AND ab1.author_id <> ab2.author_id;

-- List all authors who have written more books than the average number of books written by all authors.
SELECT a.name
FROM Authors a
INNER JOIN Author_Book ab
ON a.author_id = ab.author_id
GROUP BY a.author_id
HAVING COUNT(ab.book_id) > (
    SELECT AVG(book_count)
    FROM (
        SELECT COUNT(book_id) as book_count
        FROM Author_Book
        GROUP BY author_id
    ) AS subquery
);