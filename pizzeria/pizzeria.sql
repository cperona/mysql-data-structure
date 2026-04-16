CREATE DATABASE IF NOT EXISTS pizzeria;

USE pizzeria;

CREATE TABLE province (
  Province_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE locality (
  Locality_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  Province_ID INTEGER NOT NULL,

  CONSTRAINT fk_Locality_Province FOREIGN KEY (Province_ID) REFERENCES province(Province_ID)
);

CREATE TABLE client (
  Client_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  surname TEXT NOT NULL,
  street TEXT NOT NULL,
  street_number TEXT NOT NULL,
  floor TEXT,
  door TEXT,
  postal_code TEXT NOT NULL,
  phone_num TEXT,
  Locality_ID INTEGER NOT NULL,

  CONSTRAINT fk_Client_Locality FOREIGN KEY (Locality_ID) REFERENCES locality(Locality_ID)
);

CREATE TABLE store (
  Store_ID INTEGER PRIMARY KEY,
  street TEXT NOT NULL,
  street_number TEXT NOT NULL,
  postal_code TEXT NOT NULL,
  Locality_ID INTEGER NOT NULL,

  CONSTRAINT fk_Store_Locality FOREIGN KEY (Locality_ID) REFERENCES locality(Locality_ID)
);

CREATE TABLE employee (
  Employee_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  surname TEXT NOT NULL,
  nif TEXT NOT NULL UNIQUE,
  phone_num TEXT,
  -- 'cook' or 'delivery'
  role TEXT NOT NULL CHECK (role IN ('cook', 'delivery')),
  Store_ID INTEGER NOT NULL,

  CONSTRAINT fk_Employee_Store FOREIGN KEY (Store_ID) REFERENCES store(Store_ID)
);

CREATE TABLE category (
  Category_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE product_item (
  Item_ID INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  image TEXT,
  price DECIMAL NOT NULL
);

CREATE TABLE pizza (
  Pizza_ID INTEGER PRIMARY KEY,
  Category_ID INTEGER NOT NULL,

  CONSTRAINT fk_Pizza_Item FOREIGN KEY (Pizza_ID) REFERENCES product_item(Item_ID),
  CONSTRAINT fk_Pizza_Category FOREIGN KEY (Category_ID) REFERENCES category(Category_ID)
);

CREATE TABLE burger (
  Burger_ID INTEGER PRIMARY KEY,

  CONSTRAINT fk_Burger_Item FOREIGN KEY (Burger_ID) REFERENCES product_item(Item_ID)
);

CREATE TABLE drink (
  Drink_ID INTEGER PRIMARY KEY,

  CONSTRAINT fk_Drink_Item FOREIGN KEY (Drink_ID) REFERENCES product_item(Item_ID)
);

CREATE TABLE customer_order (
  Order_ID INTEGER PRIMARY KEY,
  order_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivery BOOLEAN NOT NULL,
  total_price DECIMAL NOT NULL,
  Client_ID INTEGER NOT NULL,
  Store_ID INTEGER NOT NULL,
  Delivery_Employee_ID INTEGER,

  CONSTRAINT fk_Order_Client FOREIGN KEY (Client_ID) REFERENCES client(Client_ID),
  CONSTRAINT fk_Order_Store FOREIGN KEY (Store_ID) REFERENCES store(Store_ID),
  CONSTRAINT fk_Order_Delivery FOREIGN KEY (Delivery_Employee_ID) REFERENCES employee(Employee_ID)
);

CREATE TABLE order_line (
  Order_ID INTEGER NOT NULL,
  Item_ID INTEGER NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  unit_price DECIMAL NOT NULL,

  PRIMARY KEY (Order_ID, Item_ID),

  CONSTRAINT fk_Line_Order FOREIGN KEY (Order_ID) REFERENCES customer_order(Order_ID),
  CONSTRAINT fk_Line_Item FOREIGN KEY (Item_ID) REFERENCES product_item(Item_ID)
);

-- Insert sample data:

INSERT INTO province (Province_ID, name) VALUES
(1, 'Barcelona'), (2, 'Girona'), (3, 'Tarragona');

INSERT INTO locality (Locality_ID, name, Province_ID) VALUES
(1, 'Barcelona', 1), (2, 'Hospitalet de Llobregat', 1),
(3, 'Girona', 2),    (4, 'Tarragona', 3);

INSERT INTO client (Client_ID, name, surname, street, street_number, floor, door, postal_code, phone_num, Locality_ID) VALUES
(1, 'John',   'Doe',    'Carrer Major',        '1',  NULL, NULL, '08001', '600111222', 1),
(2, 'Jane',   'Smith',  'Carrer Gran',         '23', NULL, NULL, '08902', '600333444', 2),
(3, 'Carlos', 'Lopez',  'Avinguda Diagonal',   '45', NULL, NULL, '08019', '600555666', 1),
(4, 'Maria',  'Garcia', 'Carrer Nou',          '10', NULL, NULL, '17001', '600777888', 3);

INSERT INTO store (Store_ID, street, street_number, postal_code, Locality_ID) VALUES
(1, 'Carrer Pizza',  '12', '08010', 1),
(2, 'Carrer Burger', '5',  '08902', 2),
(3, 'Carrer Italia', '8',  '17002', 3);

INSERT INTO employee (Employee_ID, name, surname, nif, phone_num, role, Store_ID) VALUES
(1, 'Albert', 'Martinez', '12345678A', '611111111', 'cook',     1),
(2, 'Laura',  'Perez',    '23456789B', '622222222', 'delivery', 1),
(3, 'David',  'Sanchez',  '34567890C', '633333333', 'cook',     2),
(4, 'Ana',    'Ruiz',     '45678901D', '644444444', 'delivery', 3);

INSERT INTO category (Category_ID, name) VALUES
(1, 'Classic'), (2, 'Special'), (3, 'Vegetarian');

INSERT INTO product_item (Item_ID, name, description, image, price) VALUES
(1, 'Margherita',     'Tomato, mozzarella, basil',    'img_margherita.jpg', 8.50),
(2, 'Pepperoni',      'Tomato, mozzarella, pepperoni','img_pepperoni.jpg',  9.50),
(3, 'Veggie',         'Vegetables and cheese',         'img_veggie.jpg',   10.00),
(4, 'Classic Burger', 'Beef, lettuce, tomato',         'img_burger1.jpg',   7.50),
(5, 'Cheese Burger',  'Beef with cheese',              'img_burger2.jpg',   8.00),
(6, 'Coca Cola',      'Soft drink',                    'img_coke.jpg',      2.50),
(7, 'Water',          'Mineral water',                 'img_water.jpg',     1.50),
(8, 'Beer',           'Local beer',                    'img_beer.jpg',      3.00);

INSERT INTO pizza   (Pizza_ID,  Category_ID) VALUES (1, 1), (2, 1), (3, 3);
INSERT INTO burger  (Burger_ID)              VALUES (4), (5);
INSERT INTO drink   (Drink_ID)               VALUES (6), (7), (8);

INSERT INTO customer_order (Order_ID, delivery, total_price, Client_ID, Store_ID, Delivery_Employee_ID) VALUES
(1, TRUE,  20.50, 1, 1, 2),
(2, FALSE, 15.00, 2, 2, NULL),
(3, TRUE,  12.00, 3, 1, 2),
(4, TRUE,  18.50, 4, 3, 4);

INSERT INTO order_line (Order_ID, Item_ID, quantity, unit_price) VALUES
(1, 1, 1, 8.50),  -- Margherita
(1, 6, 2, 2.50),  -- 2x Coca Cola
(2, 4, 1, 7.50),  -- Classic Burger
(2, 7, 1, 1.50),  -- Water
(3, 2, 1, 9.50),  -- Pepperoni
(4, 3, 1, 10.00), -- Veggie
(4, 8, 2, 3.00);  -- 2x Beer

-- Verify data
SELECT * FROM province;
SELECT * FROM locality;
SELECT * FROM client;
SELECT * FROM store;
SELECT * FROM employee;
SELECT * FROM category;
SELECT * FROM product_item;
SELECT * FROM pizza;
SELECT * FROM burger;
SELECT * FROM drink;
SELECT * FROM customer_order;
SELECT * FROM order_line;
