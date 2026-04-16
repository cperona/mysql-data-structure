-- create database
CREATE DATABASE IF NOT EXISTS optics_store;

-- show databases to check if it exists
SHOW DATABASES;

-- enter inside the db
USE optics_store;

CREATE TABLE SUPPLIER (
  Supplier_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  street TEXT NOT NULL,
  street_number TEXT NOT NULL,
  floor TEXT,
  door TEXT,
  city TEXT NOT NULL,
  postal_code TEXT NOT NULL,
  country TEXT NOT NULL,
  phone_num TEXT NOT NULL,
  fax TEXT NOT NULL,
  nif TEXT NOT NULL UNIQUE
);

CREATE TABLE BRAND (
  Brand_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  Supplier_ID INTEGER NOT NULL,

  CONSTRAINT fk_Brand_Supplier FOREIGN KEY (Supplier_ID) REFERENCES SUPPLIER(Supplier_ID)
);

CREATE TABLE CLIENT (
  Client_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  street TEXT NOT NULL,
  street_number TEXT NOT NULL,
  floor TEXT,
  door TEXT,
  city TEXT NOT NULL,
  postal_code TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  registration_date DATE DEFAULT (CURRENT_DATE),
  -- Client that made the recommendation (NULL if it was not recommended)
  Referred_By_Client_ID INTEGER,

  CONSTRAINT fk_Client_ReferredBy FOREIGN KEY (Referred_By_Client_ID) REFERENCES CLIENT(Client_ID)
);

CREATE TABLE EMPLOYEE (
  Employee_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  surname TEXT NOT NULL
);

CREATE TABLE SET_OF_GLASSES (
  Set_Of_Glasses_ID INTEGER PRIMARY KEY,
  Brand_ID INTEGER NOT NULL,
  frame_type TEXT,
  frame_color TEXT,
  -- Right eye
  left_diopters DECIMAL,
  left_glass_color TEXT,
  -- Left eye
  right_diopters DECIMAL,
  right_glass_color TEXT,
  price DECIMAL,

  CONSTRAINT fk_Glasses_Brand FOREIGN KEY (Brand_ID) REFERENCES BRAND(Brand_ID)
);

CREATE TABLE SALE (
  Sale_ID INTEGER  PRIMARY KEY,
  sale_date DATE DEFAULT (CURRENT_DATE),
  sale_price DECIMAL NOT NULL,
  Client_ID INTEGER NOT NULL,
  Employee_ID INTEGER NOT NULL,
  Set_Of_Glasses_ID INTEGER NOT NULL,

  CONSTRAINT fk_Sale_Client FOREIGN KEY (Client_ID) REFERENCES CLIENT(Client_ID),
  CONSTRAINT fk_Sale_Employee FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID),
  CONSTRAINT fk_Sale_Glasses FOREIGN KEY (Set_Of_Glasses_ID) REFERENCES SET_OF_GLASSES(Set_Of_Glasses_ID)
);

-- Insert sample data

INSERT INTO SUPPLIER (Supplier_ID, name, street, street_number, floor, door, city, postal_code, country, phone_num, fax, nif)
VALUES
  (1, 'Supplier1', 'Carrer Invent', '34', NULL, NULL, 'Barcelona', '08001', 'Spain', '654345689', '8769048', '34896532H'),
  (2, 'Supplier2', 'Carrer Invent', '345', '2', 'A', 'Barcelona', '08002', 'Spain', '654288943', '2348965',  '34896529Z');

INSERT INTO BRAND (Brand_ID, name, Supplier_ID)
VALUES
  (1, 'Eyesore', 1),
  (2, 'Eye5',    1),
  (3, 'VistaClear', 2);

INSERT INTO CLIENT (Client_ID, name, street, street_number, floor, door, city, postal_code, phone, email, Referred_By_Client_ID)
VALUES
  (1, 'Sergi', 'Carrer Invent', '2',  NULL, NULL, 'Barcelona', '08010', '654907621', 'ser@gmoil.com', NULL),
  -- Dani was recommended by Sergi
  (2, 'Dani',  'Carrer Invent', '4',  NULL, NULL, 'Barcelona', '08011', '634789843', 'dan@gmoil.com', 1);

INSERT INTO EMPLOYEE (Employee_ID, name, surname)
VALUES
  (1, 'Laura', 'Martínez');

INSERT INTO SET_OF_GLASSES (Set_Of_Glasses_ID, Brand_ID, frame_type, frame_color, left_diopters, left_glass_color, right_diopters, right_glass_color, price)
VALUES
  (1, 1, 'plastic frame',   'grey',  1.25, 'transparent', 1.50, 'transparent', 59.99),
  (2, 2, 'metallic frame',  'black', 2.25, 'transparent', 2.00, 'transparent', 64.99);

INSERT INTO SALE (Sale_ID, sale_date, sale_price, Client_ID, Employee_ID, Set_Of_Glasses_ID)
VALUES
  (1, '2025-01-10', 59.99, 1, 1, 1),
  (2, '2025-01-15', 64.99, 2, 1, 2);

-- Verify data

-- 1. show tables
SHOW TABLES;

-- 2. describe tables
DESCRIBE CLIENT;
DESCRIBE SUPPLIER;
DESCRIBE EMPLOYEE;
DESCRIBE SET_OF_GLASSES;
DESCRIBE TRANSACTION;

-- 3. selects
SELECT * FROM SUPPLIER;
SELECT * FROM BRAND;
SELECT * FROM CLIENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM SET_OF_GLASSES;
SELECT * FROM SALE;
