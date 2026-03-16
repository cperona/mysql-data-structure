-- create database
CREATE DATABASE IF NOT EXISTS optics_store;

-- show databases to check if it exists
SHOW DATABASES;

-- enter inside the db
USE optics_store;

-- create tables
CREATE TABLE CLIENT (
  Client_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  phone TEXT,
  email TEXT NOT NULL,
  -- DEFAULT (CURRENT_DATE) fills the date automatically by default on insert
  registration_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE SUPPLIER (
  Supplier_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  phone_num TEXT NOT NULL,
  fax TEXT NOT NULL,
  nif TEXT NOT NULL
);

CREATE TABLE EMPLOYEE (
  Employee_ID INTEGER PRIMARY KEY
);

CREATE TABLE SET_OF_GLASSES (
  Set_Of_Glasses_ID INTEGER PRIMARY KEY,
  brand TEXT,
  diopters DECIMAL,
  frame_type TEXT,
  frame_color TEXT,
  glass_color TEXT,
  price DECIMAL,
  Supplier_Of_Glasses_ID INTEGER NOT NULL,
  
  CONSTRAINT fk_Supplier_ID FOREIGN KEY (Supplier_Of_Glasses_ID) REFERENCES SUPPLIER(Supplier_ID)
);

CREATE TABLE TRANSACTION (
  Transaction_ID INTEGER PRIMARY KEY,
  Client_Purchased_ID INTEGER NOT NULL,
  Client_Recommended_ID INTEGER,
  Employee_Purchased_From_ID INTEGER NOT NULL,
  Set_Of_Glasses_Purchased_ID INTEGER NOT NULL,
  
  CONSTRAINT fk_Client_Purchased_ID FOREIGN KEY (Client_Purchased_ID) REFERENCES CLIENT(Client_ID),
  
  CONSTRAINT fk_ClientRecommended_ID FOREIGN KEY (Client_Recommended_ID) REFERENCES CLIENT(Client_ID),

  CONSTRAINT fk_Employee_Purchased_From_ID FOREIGN KEY (Employee_Purchased_From_ID) REFERENCES EMPLOYEE(Employee_ID),
  
  CONSTRAINT fk_Set_Of_Glasses_Purchased_ID FOREIGN KEY (Set_Of_Glasses_Purchased_ID) REFERENCES SET_OF_GLASSES(Set_Of_Glasses_ID)
);

-- show tables
SHOW TABLES;

-- describe tables
DESCRIBE CLIENT;
DESCRIBE SUPPLIER;
DESCRIBE EMPLOYEE;
DESCRIBE SET_OF_GLASSES;
DESCRIBE TRANSACTION;

-- insert
INSERT INTO CLIENT(Client_ID, name, address, phone, email) VALUES(1, 'Sergi', 'Invent Street, num 2', '654907621', 'ser@gmoil.com');

INSERT INTO CLIENT(Client_ID, name, address, phone, email) VALUES(2, 'Dani', 'Invent Street, num 4', '634789843', 'dan@gmoil.com');

INSERT INTO SUPPLIER(Supplier_ID, name, address, phone_num, fax, nif) VALUES(1, 'Supplier1', 'Invent Street 34', '654345689', '8769048', '34896532H');

INSERT INTO SUPPLIER(Supplier_ID, name, address, phone_num, fax, nif) VALUES(2, 'Supplier2', 'Invent Street 345', '654288943', '2348965', '34896529Z');

INSERT INTO EMPLOYEE(Employee_ID) VALUES(1);

INSERT INTO SET_OF_GLASSES(Set_Of_Glasses_ID, brand, diopters, frame_type, frame_color, glass_color, price, Supplier_Of_Glasses_ID) VALUES(1, 'Eyesore', 1.25, 'plastic frame', 'grey', 'transparent', 59.99, 1);

INSERT INTO SET_OF_GLASSES(Set_Of_Glasses_ID, brand, diopters, frame_type, frame_color, glass_color, price, Supplier_Of_Glasses_ID) VALUES(2, 'Eye5', 2.25, 'metallic frame', 'black', 'transparent', 64.99, 1);

INSERT INTO TRANSACTION(Transaction_ID, Client_Purchased_ID, Client_Recommended_ID, Employee_Purchased_From_ID, Set_Of_Glasses_Purchased_ID) VALUES(1, (SELECT Client_ID from CLIENT where name='Sergi'), (SELECT Client_ID from CLIENT where name='Dani'), 1, 1);

INSERT INTO TRANSACTION(Transaction_ID, Client_Purchased_ID, Client_Recommended_ID, Employee_Purchased_From_ID, Set_Of_Glasses_Purchased_ID) VALUES(2, (SELECT Client_ID from CLIENT where name='Dani'), (SELECT Client_ID from CLIENT where name='Sergi'), 1, 2);

-- select to check if the rows exists
SELECT * FROM CLIENT;
SELECT * FROM SUPPLIER;
SELECT * FROM EMPLOYEE;
SELECT * FROM SET_OF_GLASSES;
SELECT * FROM TRANSACTION;
