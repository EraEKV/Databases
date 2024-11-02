

CREATE DATABASE lab6;

-- 2
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    course_code VARCHAR(10),
    credits INTEGER
);

CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    major VARCHAR(50),
    year_enrolled INTEGER
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students,
    course_id INTEGER REFERENCES courses,
    professor_id INTEGER REFERENCES professors,
    enrollment_date DATE
);



-- Insert test data into courses table
INSERT INTO courses (course_name, course_code, credits) VALUES
('Introduction to Computer Science', 'CS101', 4),
('Data Structures', 'CS102', 3),
('Algorithms', 'CS103', 4),
('Database Systems', 'CS104', 3),
('Operating Systems', 'CS105', 4),
('Discrete Mathematics', 'MATH101', 3),
('Linear Algebra', 'MATH102', 4),
('Calculus I', 'MATH103', 3),
('Calculus II', 'MATH104', 3),
('Physics I', 'PHYS101', 4);

-- Insert test data into professors table
INSERT INTO professors (first_name, last_name, department) VALUES
('Alice', 'Smith', 'Computer Science'),
('Bob', 'Johnson', 'Mathematics'),
('Charlie', 'Brown', 'Computer Science'),
('Diana', 'White', 'Physics'),
('Edward', 'Williams', 'Mathematics'),
('Fiona', 'Taylor', 'Computer Science'),
('George', 'Clark', 'Physics'),
('Hannah', 'Lewis', 'Mathematics');

-- Insert test data into students table
INSERT INTO students (first_name, last_name, major, year_enrolled) VALUES
('John', 'Doe', 'Computer Science', 2021),
('Jane', 'Roe', 'Mathematics', 2022),
('Michael', 'Smith', 'Physics', 2020),
('Emily', 'Davis', 'Computer Science', 2021),
('Daniel', 'Miller', 'Mathematics', 2019),
('Sophia', 'Wilson', 'Computer Science', 2023),
('James', 'Martinez', 'Mathematics', 2020),
('Olivia', 'Anderson', 'Physics', 2021),
('William', 'Thomas', 'Computer Science', 2020),
('Emma', 'Taylor', 'Mathematics', 2021),
('Alexander', 'Moore', 'Physics', 2022),
('Isabella', 'Jackson', 'Computer Science', 2021),
('Benjamin', 'Harris', 'Mathematics', 2022),
('Charlotte', 'Thompson', 'Physics', 2020),
('Mason', 'Garcia', 'Mathematics', 2023),
('Ava', 'Martinez', 'Computer Science', 2019);

-- Insert test data into enrollments table
INSERT INTO enrollments (student_id, course_id, professor_id, enrollment_date) VALUES
(1, 1, 1, '2023-01-15'),
(2, 6, 2, '2023-01-17'),
(3, 10, 4, '2022-08-20'),
(4, 2, 3, '2023-02-05'),
(5, 6, 5, '2021-09-10'),
(6, 1, 1, '2023-03-12'),
(7, 9, 8, '2021-11-05'),
(8, 10, 4, '2022-10-30'),
(9, 3, 1, '2020-05-20'),
(10, 6, 2, '2023-01-25'),
(11, 4, 3, '2023-04-14'),
(12, 5, 1, '2023-05-16'),
(13, 3, 6, '2022-02-18'),
(14, 8, 7, '2021-07-01'),
(15, 2, 3, '2023-06-10'),
(16, 5, 6, '2020-03-22'),
(1, 4, 1, '2021-09-19'),
(2, 3, 6, '2022-11-11'),
(3, 7, 2, '2020-01-10'),
(4, 8, 5, '2021-12-12'),
(5, 5, 7, '2021-04-24'),
(6, 10, 8, '2023-07-07'),
(7, 2, 4, '2020-06-15'),
(8, 1, 3, '2022-08-28'),
(9, 6, 2, '2021-10-19'),
(10, 3, 5, '2022-09-01');





-- 3
SELECT s.first_name, s.last_name, c.course_name, p.last_name
FROM enrollments
JOIN courses c on enrollments.course_id = c.course_id
JOIN professors p on enrollments.professor_id = p.professor_id
JOIN students s on enrollments.student_id = s.student_id;


-- 4
SELECT s.first_name, s.last_name, c.course_name, c.credits
FROM enrollments
JOIN students s ON enrollments.student_id = s.student_id
JOIN courses c ON enrollments.course_id = c.course_id
WHERE c.credits > 3;


-- 5
SELECT c.course_name, COUNT(enrollments.student_id)
FROM enrollments
JOIN courses c on enrollments.course_id = c.course_id
GROUP BY c.course_name;


-- 6
SELECT p.first_name, p.last_name
FROM enrollments
JOIN professors p on enrollments.professor_id = p.professor_id;


-- 7
SELECT s.first_name, s.last_name FROM enrollments
JOIN courses c on enrollments.course_id = c.course_id
JOIN students s on enrollments.student_id = s.student_id
WHERE c.course_name = 'Introduction to Computer Science';


-- 8
SELECT c.course_name, p.last_name, c.credits
FROM enrollments
JOIN professors p on enrollments.professor_id = p.professor_id
JOIN courses c on enrollments.course_id = c.course_id
WHERE p.last_name LIKE 'S%';


-- 9
SELECT s.first_name, s.last_name, enrollment_date FROM enrollments
JOIN students s on enrollments.student_id = s.student_id
WHERE enrollment_date < '01-01-2022';


-- 10
SELECT c.course_name FROM enrollments
RIGHT JOIN courses c ON c.course_id = enrollments.course_id
WHERE enrollments.enrollment_id is NULL;




-- DROP TABLE enrollments;
-- DROP TABLE courses;
-- DROP TABLE students;
-- DROP TABLE professors;


-- DROP DATABASE lab6;













SELECT s.first_name, s.last_name, c.course_name
FROM enrollments
JOIN students s on enrollments.student_id = s.student_id
JOIN courses c on c.course_id = enrollments.course_id
WHERE course_name = 'Introduction to Computer Science';

