
CREATE DATABASE lab1;

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    first_name VARCHAR(60),
    last_name VARCHAR(60),
    email VARCHAR(100),
    date DATE
);

ALTER TABLE clients
ADD COLUMN status INT CHECK (status = 1 OR status = 0);

ALTER TABLE clients DROP CONSTRAINT clients_status_check,
ALTER COLUMN status TYPE boolean USING CASE WHEN status = 0 then FALSE WHEN status = 1 then TRUE
else FALSE END;
-- ALTER COLUMN status TYPE boolean;

ALTER TABLE clients
ALTER COLUMN status SET DEFAULT TRUE;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_name VARCHAR(100),
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);



INSERT INTO clients ("first_name", "last_name", "email", "date") VALUES ('Ktotk', 'Kokenov', 'era@gmail.com', '5.12.2011');

SELECT * FROM clients;
        

DROP TABLE clients;

DROP DATABASE lab1;

DROP TABLE orders;
