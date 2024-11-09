CREATE DATABASE lab7;


--  TABLES
CREATE TABLE products
(
    product_id     SERIAL PRIMARY KEY,
    product_name   VARCHAR(100),
    price          NUMERIC(10, 2),
    stock_quantity INT
);



CREATE TABLE customers
(
    customer_id  SERIAL PRIMARY KEY,
    first_name   VARCHAR(50),
    last_name    VARCHAR(50),
    email        VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);



CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT ,
    email VARCHAR(50),
    order_total NUMERIC(10, 2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Таблица order_items с внешними ключами на orders и products
CREATE TABLE order_items
(
    order_item_id     SERIAL PRIMARY KEY,
    order_id          INT,
    product_id        INT,
    quantity          INT,
    price_at_purchase NUMERIC(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);



INSERT INTO customers (first_name, last_name, email, phone_number)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890'),
       ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210');



INSERT INTO products (product_name, price, stock_quantity)
VALUES ('Laptop', 1200.00, 50),
       ('Smartphone', 800.00, 150);



INSERT INTO orders (customer_id, email, order_total)
VALUES (1, 'test@gmail.com', 1200.00),
       (2, 'qwerty@gmail.com', 1600.00);



INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
VALUES (1, 1, 1, 1200.00),
       (2, 2, 2, 800.00);



-- TASKS

-- 1
CREATE INDEX search_product_name ON products USING hash (product_name);
DROP INDEX search_product_name;

SElECT * FROM products WHERE product_name = 'Laptop';


-- 2
CREATE INDEX customer_name ON customers (first_name, last_name);
DROP INDEX customer_name;

explain analyse
SELECT * FROM customers WHERE first_name = 'John' AND last_name
= 'Doe';


-- 3
CREATE UNIQUE INDEX sample_values ON orders (order_total);
DROP INDEX sample_values;

explain analyse
SELECT * FROM orders WHERE order_total BETWEEN 1000 AND
2000;


-- 4
CREATE INDEX order_emails ON orders (LOWER(email));
DROP INDEX order_emails;

explain analyse
SELECT * FROM customers WHERE LOWER(email) = 'test@gmail.com';


-- 5
CREATE INDEX o ON orders (order_total);
DROP INDEX o;

explain analyse
SELECT * FROM orders o JOIN order_items oi ON o.order_id =
oi.order_id WHERE o.order_total > 500 AND oi.quantity < 2;















CREATE INDEX customers_names ON customers (first_name, last_name);
DROP INDEX customers_names;

explain analyse
SELECT * FROM customers WHERE first_name = 'John' and last_name = 'Doe';