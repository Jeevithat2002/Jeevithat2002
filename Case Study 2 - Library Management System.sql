-- Case Study 2: Library Management System

 #     Scenario:      
-- You are tasked with creating a database to manage a library's inventory, members, and borrowing records. 

--       Tasks:      
1.       Create the Database:      
   - Name the database `LibraryDB`.

2.       Create Tables:      
   -       Books Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `title`: VARCHAR(100), Not Null
     - `author`: VARCHAR(50), Not Null
     - `published_year`: YEAR, Not Null
     - `genre`: VARCHAR(30)
   -       Members Table:      
     - `id`: IN
T, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `membership_date`: DATE, Not Null
   -       Borrowing Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `book_id`: INT, Foreign
 Key References `Books(id)`
     - `member_id`: INT, Foreign Key References `Members(id)`
     - `borrow_date`: DATE, Not Null
     - `return_date`: DATE

3.       Insert Sample Data.      

4.       Queries:      
   - List all books.
   - List all members.Show borrowing records with member names and book titles.
   - Show borrowing records with member names and book titles.
   - Count the number of books borrowed by each member.


Solution:

create database LibraryDB;
use LibraryDB;

CREATE TABLE Books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year int NOT NULL,
    genre VARCHAR(30)
);

CREATE TABLE Members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    membership_date DATE NOT NULL
);

CREATE TABLE Borrowing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(id),
    FOREIGN KEY (member_id) REFERENCES Members(id)
);

INSERT INTO Books (title, author, published_year, genre)
VALUES 
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
('1984', 'George Orwell', 1949, 'Dystopian'),
('Moby Dick', 'Herman Melville', 1851, 'Adventure'),
('Pride and Prejudice', 'Jane Austen', 1813, 'Romance'),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Tragedy');

INSERT INTO Members (name, membership_date)
VALUES 
('Alice', '2022-01-10'),
('Bob', '2023-03-15'),
('Charlie', '2021-06-25'),
('Diana', '2024-07-01');


INSERT INTO Borrowing (book_id, member_id, borrow_date, return_date)
VALUES 
(1, 1, '2024-11-01', NULL),
(2, 2, '2024-11-05', '2024-11-12'),
(3, 3, '2024-10-20', NULL),
(4, 1, '2024-10-15', '2024-10-22');

SELECT * FROM Books;

SELECT * FROM Members;

SELECT 
    b.id AS BorrowingID,
    bk.title AS BookTitle,
    m.name AS MemberName,
    b.borrow_date AS BorrowDate,
    b.return_date AS ReturnDate
FROM Borrowing b
JOIN Books bk ON b.book_id = bk.id
JOIN Members m ON b.member_id = m.id;

SELECT 
    m.name AS MemberName,
    COUNT(b.id) AS BorrowedBooksCount
FROM Borrowing b
JOIN Members m ON b.member_id = m.id
GROUP BY m.name;

