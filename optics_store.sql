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

-- insert
INSERT INTO CLIENT(Client_ID, name, address, phone, email) VALUES(1, 'Sergi', 'Invent Street, num 2', '654907621', 'ser@gmoil.com');
INSERT INTO CLIENT(Client_ID, name, address, phone, email) VALUES(2, 'Dani', 'Invent Street, num 4', '634789843', 'dan@gmoil.com');

