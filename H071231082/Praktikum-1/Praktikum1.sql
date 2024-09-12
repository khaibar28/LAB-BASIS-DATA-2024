create database library;

use library;

create table authors (
id int primary key auto_increment,
name varchar(100) not null
);

create table books (
id int primary key auto_increment,
isbn varchar(13),
title varchar(100) not null,
author_id int,
foreign key(author_id) references authors(id)
);

show tables;
describe authors;
describe books;

alter table authors
add nationality varchar(50);

alter table books
add constraint unique_isbn unique(isbn);

alter table books
drop foreign key books_ibfk_1;

alter table books
modify isbn char(13) not null,
modify author_id int not null,
modify title varchar(150),
add published_year year not null,
add genre varchar(50) not null,
add copies_available int not null;

alter table books
add constraint books_ibfk_1 foreign key (author_id) references authors(id);

alter table books
modify title varchar(150) not null;

create table members (
id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not null,
phone_number varchar(10),
join_date date,
membership_type varchar(50) not null
);

alter table members
modify join_date date not null;

describe members;

create table borrowings (
id int primary key auto_increment,
member_id int not null,
book_id int not null,
borrow_date date not null,
return_date date,
foreign key (member_id) references members(id),
foreign key (book_id) references books(id)
);

describe borrowings;





