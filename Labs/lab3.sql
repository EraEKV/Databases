CREATE DATABASE lab3;


-- 2. Create table for Students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- 3. Create table for Courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE,
    course_name VARCHAR(100),
    credits INT
);

-- 4. Create table for Registration (link between students and courses)
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    registration_date DATE,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 5. Insert sample data into students table
INSERT INTO students (first_name, last_name, date_of_birth, email, city) VALUES
('Alice', 'Johnson', '2001-05-14', 'alice.johnson@example.com', 'Almaty'),
('Bob', 'Smith', '2000-09-20', 'bob.smith@example.com', 'New York'),
('Cathy', 'Williams', '2002-01-10', 'cathy.williams@example.com', 'Almaty'),
('Terry', 'Williams', '2001-01-10', 'terry.williams@example.com', 'Almaty'),
('David', 'Brown', '1999-03-22', 'david.brown@example.com', 'Los Angeles');
-- DROP TABLE students CASCADE;
-- 6. Insert sample data into courses table
INSERT INTO courses (course_code, course_name, credits) VALUES
('CS101', 'Introduction to Computer Science', 4),
('MATH201', 'Calculus I', 3),
('PHYS301', 'General Physics', 3),
('HIST101', 'World History', 2);

-- 7. Insert sample data into registration table
INSERT INTO registration (student_id, course_id, registration_date, grade) VALUES
(1, 1, '2023-09-01', NULL),  -- Alice registered for CS101
(2, 2, '2023-09-01', NULL),  -- Bob registered for MATH201
(3, 3, '2023-09-01', NULL),  -- Cathy registered for PHYS301
(4, 1, '2023-09-01', NULL),  -- David registered for CS101
(1, 4, '2023-09-01', NULL);  -- Alice registered for HIST101
SELECT * FROM registration;


-- 3
SELECT last_name FROM students;

-- 4
SELECT * FROM students;
SELECT DISTINCT last_name FROM students;

-- 5
SELECT * FROM students WHERE last_name = 'Johnson';

-- 6
SELECT * FROM students WHERE last_name = 'Johnson' OR last_name = 'Smith';

-- 7
SELECT * FROM students WHERE student_id IN (SELECT student_id FROM registration WHERE course_id = 1);

SELECT * FROM students
WHERE student_id IN (SELECT student_id FROM registration
WHERE registration.course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101'));

-- 8
SELECT * FROM students WHERE student_id IN (SELECT registration.student_id FROM registration WHERE course_id = 2 OR course_id = 3);

-- 9
SELECT sum(credits) FROM courses;

-- 10
SELECT course_id, COUNT(*) AS number_of_students
FROM registration
GROUP BY course_id;

-- 11
SELECT course_id FROM registration
GROUP BY course_id HAVING COUNT(*) > 2;

-- 12
SELECT course_name FROM courses
WHERE credits = (SELECT MAX(credits) FROM courses
                 WHERE credits < (SELECT MAX(credits) FROM courses));

-- 13
SELECT first_name, last_name FROM students
WHERE student_id IN (SELECT student_id FROM registration
                            WHERE course_id = (SELECT course_id FROM courses WHERE credits = (SELECT MIN(credits) FROM courses)));

-- 14
SELECT first_name, last_name FROM students
WHERE city = 'Almaty';

-- 15
SELECT * FROM courses WHERE credits > 1
ORDER BY credits, course_id DESC;

-- 16
UPDATE courses
SET credits = credits - 1
WHERE credits = (SELECT MIN(credits) FROM courses)
RETURNING *;

-- 17
UPDATE registration
SET course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
WHERE course_id = (SELECT course_id FROM courses WHERE course_code = 'MATH201')
RETURNING *;

-- 18
DELETE FROM registration
WHERE course_id = 1;

DELETE FROM students
USING registration
WHERE students.student_id = registration.student_id AND registration.course_id = (SELECT course_id FROM courses WHERE course_code = 'CS101')
RETURNING *;

-- 19
DELETE FROM students
RETURNING *;

-- DROP TABLE students CASCADE;
-- DROP TABLE courses CASCADE;
-- DROP TABLE registration CASCADE;
--
-- DROP DATABASE lab3;