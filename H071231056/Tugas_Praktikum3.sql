-- USE library2;
DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL
);

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    isbn CHAR(13) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    author_id INT,
    published_year YEAR NOT NULL,
    genre VARCHAR(50) NOT NULL,
    copies_available INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);


CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number CHAR(10),
    join_date DATE NOT NULL,
    membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

INSERT INTO authors (name, nationality) VALUES 
    ('Tere Liye', 'Indonesia'),
    ('J.K.Rowling', 'British'),
    ('Andrea Hirata', ''); 


SELECT * FROM authors;


-- perubahan pada tabel books

ALTER TABLE books
ADD COLUMN namaAuthor VARCHAR(100);

DESCRIBE books;


INSERT INTO books (isbn, title, author_id, published_year, genre, copies_available) VALUES
    ('7040289780375', 'Ayah', 3, 2015, 'Fiction', 15),
    ('9780375704025', 'Bumi', 1, 2014, 'Fantasy', 5),
    ('8310371703024', 'Bulan', 1, 2015, 'Fantasy', 3),
    ('9780747532699', 'Harry Potter and the Philosopher\'s Stone', 2, 1997, '', 10),
    ('7210301703022', 'The Running Grave', 2, 2016, 'Fiction', 11);

UPDATE books
SET namaAuthor = 
    (SELECT name FROM authors WHERE authors.id = books.author_id);

SELECT * FROM books;

-- perubahan pada tabel members

ALTER TABLE members
ADD full_name VARCHAR(100);

INSERT INTO members (first_name,last_name, email, phone_number, join_date, membership_type) VALUES
    ('John','Doe', 'john.doe@example.com', NULL, '2023-04-29', ''),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '1231231231', '2023-05-01', 'Standar'),
    ('Bob','Williams', 'bob.williams@example.com', '3213214321', '2023-06-20', 'Premium');


-- untuk latihan
INSERT INTO members (first_name,last_name, email, phone_number, join_date, membership_type) VALUES
    ('Pangeran','dan Ekyy', 'resky@example.com', '3213214321', '2023-06-20', 'Premium');
UPDATE members
SET full_name = CONCAT(first_name, ' ', last_name);

DESCRIBE members;
SELECT * FROM members;

-- lanjut pada tabel borrowings

ALTER TABLE borrowings
ADD member_name VARCHAR(100),
ADD book_title VARCHAR(100);

DESCRIBE borrowings;

INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) VALUES
    (1, 4, '2023-07-10', '2023-07-25'),
    (3, 1, '2023-08-01', NULL),          
    (2, 5, '2023-09-06', '2023-09-09'),  
    (2, 3, '2023-09-08', NULL),          
    (3, 2, '2023-09-10', NULL);          

-- untuk latihan
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date) VALUES       
    (4, 2, '2023-09-10', NULL); 
    
UPDATE borrowings
SET member_name = (SELECT full_name FROM members WHERE borrowings.member_id = members.id),
	 book_title =  (SELECT title FROM books WHERE borrowings.book_id = books.id);

SELECT * FROM borrowings;




-- nomor 2

-- menguangi jumlah buku (copies_available) sesuai dean jumlah buku yang hilang
-- jadi tabel books dan tabel borrowings yang kita akan perhatiin.

UPDATE books 
SET copies_available = copies_available - 1
WHERE id IN (
    SELECT book_id 
    FROM borrowings 
    WHERE return_date IS NULL
) 
AND copies_available > 0;

SELECT ISBN, title Title, namaAuthor AS 'Author Name', published_year AS 'Published Year', genre Gendre, copies_available AS 'Copies Available' FROM books;

-- nomor 3

-- nah sebelum kita menghapus isi tabel members terlebih dahulu kita modif ke cascade
-- dari soalnya kita dapat dua perintah, mengubah status dan menghapus member

-- 1. kita hapus dulu yang jika >= 2, membersip type premium

DELETE FROM members
WHERE id IN (
    SELECT member_id 
    FROM borrowings 
    WHERE return_date IS NULL
    GROUP BY member_id
    HAVING COUNT(*) >= 2
); 
-- ditabel ada baris si bob

SELECT full_name AS 'Full Name', email Email, phone_number AS 'Phone Number', join_date AS 'Join Date', membership_type AS 'Membership Type' FROM members;
SELECT member_name AS 'Member Name', book_title AS 'Book Title',borrow_date AS 'Borrow Date', return_date AS 'Return Date' FROM borrowings;


-- yang membersip type standar, mehilangkan 1 buku

DELETE FROM members
WHERE id IN (
    SELECT member_id 
    FROM borrowings 
    WHERE return_date IS NULL
    GROUP BY member_id
    HAVING COUNT(*) = 1
) 
AND membership_type = 'Standar'; -- alice
SELECT full_name AS 'Full Name', email Email, phone_number AS 'Phone Number', join_date AS 'Join Date', membership_type AS 'Membership Type' FROM members;
SELECT member_name AS 'Member Name', book_title AS 'Book Title',borrow_date AS 'Borrow Date', return_date AS 'Return Date' FROM borrowings;



-- ubah membersip type premium ke standar
UPDATE members
SET membership_type = 'Standar'
WHERE id IN (
    SELECT member_id 
    FROM borrowings 
    WHERE return_date IS NULL
    GROUP BY member_id
    HAVING COUNT(*) = 1
) 
AND membership_type = 'Premium'; -- nama kita sayang
-- lalu hapus yang null
DELETE FROM borrowings
WHERE return_date IS NULL;
SELECT full_name AS 'Full Name', email Email, phone_number AS 'Phone Number', join_date AS 'Join Date', membership_type AS 'Membership Type' FROM members;
SELECT member_name AS 'Member Name', book_title AS 'Book Title',borrow_date AS 'Borrow Date', return_date AS 'Return Date' FROM borrowings;



-- final
SELECT NAME AS 'Name', nationality Nationality FROM authors;
SELECT ISBN, title Title, namaAuthor AS 'Author Name', published_year AS 'Published Year', genre Gendre, copies_available AS 'Copies Available' FROM books;
SELECT full_name AS 'Full Name', email Email, phone_number AS 'Phone Number', join_date AS 'Join Date', membership_type AS 'Membership Type' FROM members;
SELECT member_name AS 'Member Name', book_title AS 'Book Title',borrow_date AS 'Borrow Date', return_date AS 'Return Date' FROM borrowings;
