CREATE DATABASE lab4;

CREATE TABLE Warehouses (
    code        INTEGER PRIMARY KEY,
    location    VARCHAR(255),
    capacity    INTEGER
);

CREATE TABLE Packs (
    code        CHAR(4),
    contents    VARCHAR(255),
    value       REAL,
    warehouses  INTEGER REFERENCES Warehouses(code)
);


INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);


-- 4
SELECT * FROM Warehouses;

-- 5
SELECT * FROM Packs WHERE value > 150;

-- 6
SELECT DISTINCT contents FROM Packs;

-- 7
SELECT warehouses, COUNT(*) AS boxes FROM Packs GROUP BY warehouses;

-- 8
SELECT warehouses, COUNT(*) AS boxes FROM Packs GROUP BY warehouses HAVING COUNT(*) > 2;

-- 9
INSERT INTO Warehouses (code, location, capacity) VALUES (6, 'New-York', 3);

-- 10
INSERT INTO Packs (code, contents, value, warehouses) VALUES ('H5RT', 'Papers', 200, 6);

-- 11
SELECT * FROM Packs;

UPDATE Packs SET
value = value * .85
WHERE value = (
    SELECT value FROM Packs
    ORDER BY value DESC
    LIMIT 1 OFFSET 2
    )
RETURNING *;



-- 12
DELETE FROM Packs
WHERE value < 150
RETURNING *;


-- 13
DELETE FROM Packs
WHERE warehouses = (SELECT code FROM Warehouses WHERE location = 'New-York')
RETURNING *;


--
-- DROP TABLE Warehouses CASCADE;
-- DROP TABLE PACKS;
-- DROP DATABASE lab4;