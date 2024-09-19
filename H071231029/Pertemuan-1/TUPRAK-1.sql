## MUH FAJRIN SUHAR 
## H071231029


## NO 1
CREATE DATABASE library;


USE library;


CREATE TABLE authors(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
)


CREATE TABLE books(
	id INT PRIMARY KEY AUTO_INCREMENT,
	isbn VARCHAR(13),
	tittle VARCHAR(100) NOT NULL,
	author_id INT, 
	FOREIGN KEY (author_id) REFERENCES authors(id)
)





SHOW DATABASES;



## NO 2
ALTER TABLE authors
ADD nationality VARCHAR(50);


## NO 3
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE; 



# NO 4
SHOW TABLES;

DESC authors;
DESC books;



## NO 5
ALTER TABLE books
MODIFY COLUMN tittle VARCHAR(150) NOT NULL,
MODIFY COLUMN isbn VARCHAR(13) NOT NULL,
MODIFY COLUMN author_id INT NOT NULL,
ADD published_year YEAR NOT NULL,
ADD genre VARCHAR(50) NOT NULL,
ADD copies_available INT NOT NULL


ALTER TABLE authors 
MODIFY nationality VARCHAR(50) NOT NULL




CREATE TABLE members(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
phone_number CHAR(10),
join_date DATE NOT NULL,
membership_type VARCHAR(50) NOT NULL 

)


CREATE TABLE borrowings (

id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT NOT NULL,
book_id INT NOT NULL,
borrow_date DATE NOT NULL,
return_date DATE,
FOREIGN KEY(member_id) REFERENCES members(id),
FOREIGN KEY(book_id) REFERENCES books(id)

)



DESC members;
DESC borrowings;

ALTER TABLE authors
MODIFY nationality VARCHAR(50) NOT NULL DEFAULT "negara  




