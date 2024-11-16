-- 1
CREATE DATABASE library_db;

-- 2

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    city VARCHAR(50),
    membership_level INT,
    librarian_id INT
);

INSERT INTO members VALUES
(1001, 'John Doe', 'New York', 1, 2001),
(1002, 'Alice Johnson', 'California', 2, 2002),
(1003, 'Bob Smith', 'London', 1, 2003),
(1004, 'Sara Green', 'Paris', 3, 2004),
(1005, 'David Brown', 'New York', 1, 2001),
(1006, 'Emma White', 'Berlin', 2, 2005),
(1007, 'Olivia Black', 'Rome', 3, 2006);

CREATE TABLE borrowings (
    borrowing_id INT PRIMARY KEY,
    borrow_date DATE,
    return_date DATE,
    member_id INT,
    librarian_id INT,
    book_id INT
);

INSERT INTO borrowings VALUES
(30001, '2023-01-05', '2023-01-10', 1002, 2002, 5001),
(30002, '2022-07-10', '2022-07-17', 1003, 2003, 5002),
(30003, '2021-05-12', '2021-05-20', 1001, 2001, 5003),
(30004, '2020-04-08', '2020-04-15', 1006, 2005, 5004),
(30005, '2024-02-20', '2024-02-22', 1007, 2006, 5005),
(30006, '2023-06-02', '2023-06-12', 1005, 2001, 5001);


CREATE TABLE librarians (
    librarian_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);

INSERT INTO librarians VALUES
(2001, 'Michael Green', 'New York', 0.15),
(2002, 'Anna Blue', 'California', 0.13),
(2003, 'Chris Red', 'London', 0.12),
(2004, 'Emma Yellow', 'Paris', 0.14),
(2005, 'David Purple', 'Berlin', 0.12),
(2006, 'Laura Orange', 'Rome', 0.13);

INSERT INTO librarians VALUES (2007, 'John Doe', 'Rome', 0.13);


-- 3
CREATE VIEW librarians_in_ny AS
SELECT * FROM librarians
WHERE city = 'New York';

SELECT * FROM librarians_in_ny;


-- 4
CREATE VIEW borrowing_details AS
SELECT b.borrowing_id, b.borrow_date, b.return_date,
       m.member_name AS member, l.name AS librarian
FROM borrowings b
JOIN members m ON b.member_id = m.member_id
JOIN librarians l ON b.librarian_id = l.librarian_id;

CREATE ROLE library_user;

GRANT SELECT ON borrowing_details TO library_user;


-- 5
CREATE VIEW top_members AS
SELECT * FROM members
WHERE membership_level = (SELECT MAX(membership_level) FROM members);

GRANT SELECT ON top_members TO library_user;

SELECT * FROM top_members;

-- 6
CREATE VIEW librarian_count_by_city AS
SELECT city, COUNT(*) AS librarian_count
FROM librarians
GROUP BY city;

SELECT * FROM librarian_count_by_city;


-- 7
CREATE VIEW busy_librarians AS
SELECT l.librarian_id, l.name, l.city, COUNT(DISTINCT m.member_id) AS unique_members
FROM librarians l
JOIN members m ON l.librarian_id = m.librarian_id
GROUP BY l.librarian_id, l.name, l.city
HAVING COUNT(DISTINCT m.member_id) > 1;

SELECT * FROM busy_librarians;

-- 8
CREATE ROLE intern;
GRANT library_user TO intern;
