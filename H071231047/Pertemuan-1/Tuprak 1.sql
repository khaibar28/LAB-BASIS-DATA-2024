CREATE DATABASE library;
USE library;

-- nomor 1
CREATE TABLE authors (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn CHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);

-- nomor 2
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- nomor 3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE;

-- nomor 4
DESCRIBE authors;
DESCRIBE books;

-- nomor 5
CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT,
	borrow_date DATE NOT NULL,
	return_date DATE,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id)
);

ALTER TABLE books
	ADD published_year YEAR NOT NULL,
	ADD genre VARCHAR(50) NOT NULL,
	ADD copies_available INT NOT NULL,
	MODIFY title VARCHAR(150) NOT NULL,
	MODIFY isbn CHAR(13) UNIQUE NOT NULL;
	
ALTER TABLE books
	MODIFY author_id INT NOT NULL;
	
ALTER TABLE authors
	MODIFY nationality VARCHAR(50) NOT NULL;

DESCRIBE members;
DESCRIBE borrowings;
DESCRIBE books;
DESCRIBE authors;