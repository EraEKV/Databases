CREATE DATABASE library_db;


CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    city VARCHAR(50),
    membership_level INT,
    librarian_id INT,
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);


CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(3, 2)
);


CREATE TABLE borrowings (
    borrowing_id INT PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INT,
    librarian_id INT,
    book_id INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id)
);


INSERT INTO librarians (librarian_id, name, city, commission) VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);


INSERT INTO members (member_id, member_name, city, membership_level, librarian_id) VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);


INSERT INTO borrowings (borrowing_id, borrow_date, return_date, member_id, librarian_id, book_id) VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-19', 1001, 2001, 5003),
(30004, '2022-04-08', '2022-04-15', 1004, 2004, 5004),
(30005, '2023-03-20', '2023-06-30', 1006, 2005, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);




-- 3
SELECT COUNT(*) as total_borrowings FROM borrowings
WHERE borrow_date >= '2020-01-01' AND borrow_date <= '2024-12-28';


-- 4
SELECT AVG(membership_level) FROM members;


-- 5
SELECT COUNT(*) FROM members WHERE city = 'New York';


-- 6
SELECT * FROM borrowings ORDER BY borrow_date;
SELECT MIN(borrow_date) FROM borrowings;


-- 7
SELECT member_name, city FROM members WHERE member_name LIKE '%n';


-- 8
SELECT * FROM borrowings
RIGHT JOIN librarians l on borrowings.librarian_id = l.librarian_id
WHERE l.city = 'Paris'
AND borrowings.borrow_date BETWEEN '2021-01-01' AND '2023-01-01';


-- 9
SELECT * FROM borrowings WHERE borrow_date > '2023-01-01';


-- 10
SELECT member_id, COUNT(*) as total_books FROM borrowings GROUP BY member_id;


-- 11
SELECT * FROM members WHERE membership_level = 3;


-- 12
SELECT * FROM librarians WHERE commission = (SELECT MAX(commission) FROM librarians);
