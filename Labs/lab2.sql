CREATE DATABASE lab_2;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    department_id INTEGER,
    salary INTEGER
);


INSERT INTO employees VALUES
('Erasyl', 'Kokenov', 10, 250000);

INSERT INTO employees
(employee_id, first_name, last_name)
VALUES (2, 'Rick', 'Astley');


INSERT INTO employees
(department_id)
VALUES (NULL);


INSERT INTO employees (first_name, last_name, department_id, salary) VALUES
('Erasyl', 'Kokenov', 10, 250000),
('Erasyl', 'Kokenov', 10, 250000),
('Erasyl', 'Kokenov', 10, 250000),
('Erasyl', 'Kokenov', 10, 250000),
('Erasyl', 'Kokenov', 10, 250000);


ALTER TABLE employees
ALTER COLUMN first_name SET DEFAULT 'John';


INSERT INTO employees (last_name, department_id, salary) VALUES
('Kokenov', 10, 250000);


ALTER TABLE employees
ALTER COLUMN first_name SET DEFAULT 'Richard',
ALTER COLUMN last_name SET DEFAULT 'Hendricks',
ALTER COLUMN department_id SET DEFAULT 10,
ALTER COLUMN salary SET DEFAULT 1000;


INSERT INTO employees DEFAULT VALUES;


CREATE TABLE employees_archive (LIKE employees INCLUDING ALL);


INSERT INTO employees_archive SELECT * FROM employees;

UPDATE employees
SET department_id = 1
WHERE department_id == NULL;


UPDATE employees
SET salary = salary * 1.15
RETURNING first_name, last_name, salary AS "Updated Salary";


DELETE FROM employees
WHERE salary < 50000;



DELETE FROM employees_archive
WHERE employee_id IN (SELECT employee_id FROM employees)
RETURNING *;


DELETE FROM employees
RETURNING *;


