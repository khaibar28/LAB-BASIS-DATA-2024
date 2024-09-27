-- No. 1
-- Authors
INSERT INTO authors (name, nationality) VALUES
	("Tere Liye", "Indonesian"),
	("J.K Rowling", "British"),
	("Andrea Hirata", "");

-- Books
INSERT INTO books (isbn, title, author_id, published_year, genre, copies_available) VALUES
	('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
	('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5),
	('8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3),
	('9780747532699', "Harry Potter and the Philosopher's Stone", 2, 1997, '', 10),
	('7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

-- Members
INSERT INTO members (first_name, last_name, email, phone_number, join_date, membership_type) VALUES
	('John', 'Doe', 'John.doe@example.com', NULL, '2023-04-29', ''),
	('Alice', 'Johnson', 'alice.johnson@example.com', 1231231231, '2023-05-01', 'Standard'),
	('Bob', 'Williams', 'bob.williams@example.com', 3213214321, '2023-06-20', 'Premium');

-- Borrowings
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) VALUES
	(1, 4, '2023-07-10', '2023-07-25'),
	(3, 1, '2023-08-01', NULL),
	(2, 5, '2023-09-06', '2023-09-09'),
	(2, 3, '2023-09-08', NULL),
	(3, 2, '2023-09-10', NULL);

-- No. 2
UPDATE books 
SET copies_available = copies_available - 1
WHERE id IN (SELECT book_id FROM borrowings WHERE return_date IS NULL);

-- No. 3
-- Untuk membership_type = premium
UPDATE members
SET membership_type = 'Standard'
WHERE membership_type = 'Premium' AND
	id IN (SELECT member_id FROM borrowings WHERE return_date IS NULL);

-- Untuk membership_type = standard
SHOW CREATE table borrowings; -- Mencari constraint_name

ALTER TABLE borrowings
DROP FOREIGN KEY borrowings_ibfk_2; -- Menghapus foreign key book_id menggunakan constraint_name-nya

-- Menambahkan ON DELETE CASCADE pada kolom borrowings.book_id agar data dari members dapat dihapus
ALTER TABLE borrowings 
ADD CONSTRAINT borrowings_bookId_cascade FOREIGN KEY (book_id) 
REFERENCES books (id) ON DELETE CASCADE;

DELETE FROM members 
WHERE membership_type = 'Standard' AND
	id IN (SELECT member_id FROM borrowings WHERE return_date IS NULL);

SELECT * FROM authors a ;
SELECT * FROM members m ;
SELECT * FROM books b ;
SELECT * FROM borrowings b ;

