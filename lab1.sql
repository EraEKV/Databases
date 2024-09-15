DROP TABLE IF EXISTS products;

CREATE TABLE products (
    user_name VARCHAR(50),
    product_name VARCHAR(50)
);


INSERT INTO products (user_name, product_name) VALUES ('ERASYL', 'KOKENOV');

SELECT * FROM products;
