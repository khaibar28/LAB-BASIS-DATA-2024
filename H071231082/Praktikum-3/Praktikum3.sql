-- Praktikum 3 H071231082

use library;

-- 1
insert into authors (name, nationality) values 
("Tere Liye", "Indonesia"), ("J.K. Rowling", "British"), ("Andrea Hinata", "");

insert into books (isbn, title, author_id, publsihed_year, genre, copies_available) values 
(7040289780375, "Ayah", 3, 2015, "Fiction", 15),
(9780375704025, "Bumi", 1, 2014, "Fantasy", 5),
(8310371703024, "Bulan", 1, 2015, "Fantasy", 3),
(9780747532699, "Harry Potter and the Philosopher's Stone", 2, 1997, "", 10),
(7210301703022, "The Running Grave", 2, 2016, "Fiction", 11);

insert into members (first_name, last_name, email, phone_number, join_date, membership_type) values 
("John", "Doe", "John.doe@example.com", null, "2023-04-29", ""),
("Alice", "Johnson", "alice.johnson@example.com", 1231231231, "2023-05-01", "Standar"),
("Bob", "Williams", "bob.williams@example.com", 3213214321, "2023-06-20", "Premium");

insert into borrowings (member_id, book_id, borrow_date, return_date) values 
(1, 4, "2023-07-10", "2023-07-25"),
(2, 1, "2023-08-01", null),
(3, 5, "2023-09-06", "2023-09-09"),
(3, 3, "2023-09-08", null),
(2, 2, "2023-09-10", null);

-- 2
insert into borrowings (member_id, book_id, borrow_date, return_date) values 
(1, 4, "2023-07-10", "2023-07-25"),
(2, 1, "2023-08-01", null),
(3, 5, "2023-09-06", "2023-09-09"),
(3, 3, "2023-09-08", null),
(2, 2, "2023-09-10", null);

-- 3
update books
set copies_available = copies_available - 1
where id in (1, 2, 3); 

update members
set membership_type = "standar"
where id in (2, 3); 

update members
set membership_type = ""
where id in (1); 
