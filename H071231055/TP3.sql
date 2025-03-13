-- Tabel TP 1
CREATE DATABASE library;
USE library;

CREATE TABLE authors(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
nationality VARCHAR(50) NOT NULL
);

CREATE TABLE books(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(150) NOT NULL,
isbn VARCHAR(13) UNIQUE NOT NULL,
author_id INT NOT NULL,
FOREIGN KEY(author_id) REFERENCES authors(id),
published_year YEAR NOT NULL,
genre VARCHAR(50) NOT NULL,
copies_available INT NOT NULL
);

CREATE TABLE members(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone_number CHAR(10),
join_date DATE NOT NULL,
membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings(
id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT NOT NULL,
book_id INT,
borrow_date DATE NOT NULL,
return_date DATE,
FOREIGN KEY(member_id) REFERENCES members(id) ON DELETE CASCADE,
FOREIGN KEY(book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- Soal 1
INSERT INTO authors(name, nationality)
VALUES ('Tere Liye','Indonesian'),
('J.K. Rowling','British'),
('Andrea Hirata', NULL);

INSERT INTO authors 
VALUES (4, 'Action Kamen','Malaysian');

INSERT INTO books(isbn, title, author_id, published_year, genre, copies_available)
VALUES ('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5),
('8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3),
('9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, NULL, 10),
('7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

INSERT INTO members(first_name, last_name, email, phone_number, join_date, membership_type)
VALUES ('John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', NULL),
('Alice', 'Johnson', 'alice.johnson@example.com', '1231231231', '2023-05-01', 'Standar'),
('Bob', 'Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');

INSERT INTO borrowings(member_id, book_id, borrow_date, return_date)
VALUES (1, 4, '2023-07-10', '2023-07-25'),
(3, 1, '2023-08-01', NULL),
(2, 5, '2023-09-06', '2023-09-09'),
(2, 3, '2023-09-08', NULL),
(3, 2, '2023-09-10', NULL);

DELETE FROM members;
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;
DROP DATABASE library;

-- Soal 2
UPDATE books 
SET copies_available = copies_available - 1
WHERE id = 2 OR 4 OR 5;

SELECT * FROM books;

-- Soal 3
UPDATE members
SET membership_type = 'Standar'
WHERE membership_type = 'Premium';

DELETE FROM members 
WHERE membership_type = 'Standar';

SELECT * FROM members;
