CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

CREATE TABLE province (
  Province_ID INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE locality (
  Locality_ID INTEGER PRIMARY KEY,
  name TEXT,
  Province_ID INTEGER NOT NULL,
  
  CONSTRAINT fk_Province_ID FOREIGN KEY (Province_ID) REFERENCES province(Province_ID)
);

CREATE TABLE client (
  Client_ID INTEGER PRIMARY KEY,
  name TEXT,
  surname TEXT,
  address TEXT,
  postal_code TEXT,
  phone_num TEXT,
  Client_Locality_ID INTEGER NOT NULL,
  
  CONSTRAINT fk_Client_Locality_ID FOREIGN KEY (Client_Locality_ID) REFERENCES locality(Locality_ID)
);

CREATE TABLE employee (
  Employee_ID INTEGER PRIMARY KEY,
  name TEXT,
  surname TEXT,
  nif TEXT,
  phone_num TEXT,
  cook_or_delivery BOOLEAN
);

CREATE TABLE store (
  Store_ID INTEGER PRIMARY KEY,
  address TEXT,
  postal_code TEXT,
  Employee_ID INTEGER,
  Locality_ID INTEGER,
  
  CONSTRAINT fk_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES employee(Employee_ID),
  CONSTRAINT fk_Locality_ID FOREIGN KEY (Locality_ID) REFERENCES locality(Locality_ID)
);

CREATE TABLE _order (
  Order_ID INTEGER PRIMARY KEY,
  date_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- FALSE will be shown as 0, TRUE as 1
  delivery_or_in_store BOOLEAN,
  total_price DECIMAL,
  
  Client_ID INTEGER NOT NULL,
  Store_ID INTEGER NOT NULL,
  
  CONSTRAINT fk_Client_ID FOREIGN KEY (Client_ID) REFERENCES client(Client_ID),
  CONSTRAINT fk_Store_ID FOREIGN KEY (Store_ID) REFERENCES store(Store_ID)
);

CREATE TABLE category (
  Category_ID INTEGER PRIMARY KEY,
  name TEXT
);

CREATE TABLE pizza (
  Pizza_ID INTEGER PRIMARY KEY,
  name TEXT,
  description TEXT,
  image TEXT,
  price DECIMAL,
  Category_ID INTEGER,
  
  CONSTRAINT fk_Category_ID FOREIGN KEY (Category_ID) REFERENCES category(Category_ID) 
);

CREATE TABLE burguer (
  Burguer_ID INTEGER PRIMARY KEY,
  name TEXT,
  description TEXT,
  image TEXT,
  price DECIMAL
);

CREATE TABLE drink (
  Drink_ID INTEGER PRIMARY KEY,
  name TEXT,
  description TEXT,
  image TEXT,
  price DECIMAL
);

CREATE TABLE product (
  Product_ID INTEGER PRIMARY KEY,
  
  Pizza_ID INTEGER,
  Burguer_ID INTEGER,
  Drink_ID INTEGER,
  
  CONSTRAINT fk_Pizza_ID FOREIGN KEY (Pizza_ID) REFERENCES pizza(Pizza_ID),
  CONSTRAINT fk_Burguer_ID FOREIGN KEY (Burguer_ID) REFERENCES burguer(Burguer_ID),
  CONSTRAINT fk_Drink_ID FOREIGN KEY (Drink_ID) REFERENCES drink(Drink_ID)
);

-- bridge table
CREATE TABLE order_procuct (
  Order_ID INTEGER,
  Product_ID INTEGER,
  PRIMARY KEY (Order_ID, Product_ID),
  
  CONSTRAINT fk_Order_ID FOREIGN KEY (Order_ID) REFERENCES _order(Order_ID),
  CONSTRAINT fk_Product_ID FOREIGN KEY (Product_ID) REFERENCES product(Product_ID)
);

-- inserts with sample data

INSERT INTO province (Province_ID, name) VALUES
(1, 'Barcelona'),
(2, 'Girona'),
(3, 'Tarragona');

INSERT INTO locality (Locality_ID, name, Province_ID) VALUES
(1, 'Barcelona', 1),
(2, 'Hospitalet de Llobregat', 1),
(3, 'Girona', 2),
(4, 'Tarragona', 3);

INSERT INTO client (Client_ID, name, surname, address, postal_code, phone_num, Client_Locality_ID) VALUES
(1, 'John', 'Doe', 'Carrer Major 1', '08001', '600111222', 1),
(2, 'Jane', 'Smith', 'Carrer Gran 23', '08902', '600333444', 2),
(3, 'Carlos', 'Lopez', 'Avinguda Diagonal 45', '08019', '600555666', 1),
(4, 'Maria', 'Garcia', 'Carrer Nou 10', '17001', '600777888', 3);

INSERT INTO employee (Employee_ID, name, surname, nif, phone_num, cook_or_delivery) VALUES
(1, 'Albert', 'Martinez', '12345678A', '611111111', TRUE),
(2, 'Laura', 'Perez', '23456789B', '622222222', FALSE),
(3, 'David', 'Sanchez', '34567890C', '633333333', TRUE),
(4, 'Ana', 'Ruiz', '45678901D', '644444444', FALSE);

INSERT INTO store (Store_ID, address, postal_code, Employee_ID, Locality_ID) VALUES
(1, 'Carrer Pizza 12', '08010', 1, 1),
(2, 'Carrer Burger 5', '08902', 2, 2),
(3, 'Carrer Italia 8', '17002', 3, 3);

INSERT INTO category (Category_ID, name) VALUES
(1, 'Classic'),
(2, 'Special'),
(3, 'Vegetarian');

INSERT INTO pizza (Pizza_ID, name, description, image, price, Category_ID) VALUES
(1, 'Margherita', 'Tomato, mozzarella, basil', 'img_margherita.jpg', 8.50, 1),
(2, 'Pepperoni', 'Tomato, mozzarella, pepperoni', 'img_pepperoni.jpg', 9.50, 1),
(3, 'Veggie', 'Vegetables and cheese', 'img_veggie.jpg', 10.00, 3);

INSERT INTO burguer (Burguer_ID, name, description, image, price) VALUES
(1, 'Classic Burger', 'Beef, lettuce, tomato', 'img_burger1.jpg', 7.50),
(2, 'Cheese Burger', 'Beef with cheese', 'img_burger2.jpg', 8.00);

INSERT INTO drink (Drink_ID, name, description, image, price) VALUES
(1, 'Coca Cola', 'Soft drink', 'img_coke.jpg', 2.50),
(2, 'Water', 'Mineral water', 'img_water.jpg', 1.50),
(3, 'Beer', 'Local beer', 'img_beer.jpg', 3.00);

INSERT INTO product (Product_ID, Pizza_ID, Burguer_ID, Drink_ID) VALUES
(1, 1, NULL, NULL), -- Margherita
(2, 2, NULL, NULL), -- Pepperoni
(3, 3, NULL, NULL), -- Veggie
(4, NULL, 1, NULL), -- Classic Burger
(5, NULL, 2, NULL), -- Cheese Burger
(6, NULL, NULL, 1), -- Coca Cola
(7, NULL, NULL, 2), -- Water
(8, NULL, NULL, 3); -- Beer

INSERT INTO _order (Order_ID, delivery_or_in_store, total_price, Client_ID, Store_ID) VALUES
(1, TRUE, 20.50, 1, 1),
(2, FALSE, 15.00, 2, 2),
(3, TRUE, 12.00, 3, 1),
(4, TRUE, 18.50, 4, 3);

INSERT INTO order_procuct (Order_ID, Product_ID) VALUES
(1, 1), -- Margherita
(1, 6), -- Coca Cola

(2, 4), -- Classic Burger
(2, 7), -- Water

(3, 2), -- Pepperoni

(4, 3), -- Veggie
(4, 8); -- Beer

SELECT * FROM _order;
SELECT * FROM burguer;
SELECT * FROM category;
SELECT * FROM client;
SELECT * FROM drink;
SELECT * FROM employee;
SELECT * FROM locality;
SELECT * FROM order_procuct;
SELECT * FROM pizza;
SELECT * FROM product;
SELECT * FROM province;
SELECT * FROM store;
