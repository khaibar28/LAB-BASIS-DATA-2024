-- No. 1
CREATE DATABASE library;
USE library;

CREATE TABLE authors(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(13),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- No. 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- No. 3
ALTER TABLE books
ADD CONSTRAINT isbn UNIQUE (isbn);
-- MODIFY COLUMN isbn VARCHAR(13) NOT NULL UNIQUE;

-- No. 4
SHOW TABLES;
DESCRIBE authors;
DESCRIBE books;

-- No. 5
-- Ubah nationality menjadi not null pada table authors
ALTER TABLE authors
MODIFY COLUMN nationality VARCHAR(50) NOT NULL;

-- Ubah title menjadi varchar(150) dan isbn & author_id menjadi not null,
-- serta menambahkan beberapa item pada table books
ALTER TABLE books
MODIFY COLUMN title VARCHAR(150) NOT NULL,
MODIFY COLUMN isbn CHAR(13) NOT NULL UNIQUE,
MODIFY COLUMN author_id INT NOT NULL;

ADD published_year year NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL;

-- Membuat table borrowings
CREATE TABLE borrowings (
	id INT AUTO_INCREMENT PRIMARY KEY,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	FOREIGN KEY (book_id) REFERENCES books(id),
	borrow_date DATE NOT NULL,
	return_date DATE
);

-- Membuat table members
CREATE TABLE members (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE KEY,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membershio_type VARCHAR(50) NOT NULL
);

-- Membatasi member_id menjadi foreign key dengan referensi members(id) pada table borrowings
ALTER TABLE borrowings
ADD CONSTRAINT FOREIGN KEY (member_id) REFERENCES members(id);

USE library;
SHOW TABLES;

DESCRIBE authors;
DESCRIBE books;
DESCRIBE borrowings;
DESCRIBE members;

