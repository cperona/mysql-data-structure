# MySQL Data Structure

## Exercise 1 - Optics Store

An optical shop wants to computerize the management of its customers and glasses sales.

The system must store information about suppliers, including their name, address (street, number, floor, door, city, postal code, country), phone number, fax, and tax identification number (NIF).

The shop’s purchasing policy states that each glasses brand is bought from only one supplier, although a supplier may provide glasses from multiple brands.

For each pair of glasses, the system must record:

Brand

Prescription of each lens

Frame type (rimless, plastic, or metal)

Frame color

Lens color

Price

For customers, the system must store:

Name

Postal address

Phone number

Email

Registration date

The customer who recommended the shop (if applicable)

Finally, the system must also record which employee sold each pair of glasses.

### Exercise resolution

#### ER Diagram
The diagram is saved both on 'optics-store.drawio' and 'optics-store.png files'.

a client makes a Transaction --> 1:N

...

the Transaction is made by an Employee --> N:1

...

on the Transaction, an acqusition is made to a Set_Of_Glasses --> 1:N

...

a Set_Of_Glasses is from a Supplier --> N:1


#### MySQL Set up
- Create a docker-compose.yaml file with a mysql service
- Run the docker compose with: ```docker compose up -d```
- Attach to the mysql cli with: ```docker exec -it mysql-container mysql -u root -p```

#### Database creation
Create a .sql file that creates the database and fills some data: 'optics-store.sql'

## Exercise 2 - Pizzeria
You have been hired to design a website that allows customers to order food for home delivery online.

The database should store the following information:

Customers

Each customer has a unique identifier and the following data:

First name

Last name

Address

Postal code

City

Province

Phone number

Cities and provinces are stored in separate tables. A city belongs to only one province, while a province can contain many cities. Each city and province has a unique identifier and a name.

Orders

A customer can place many orders, but each order belongs to only one customer. Each order stores:

A unique identifier

Date and time

Whether the order is for home delivery or store pickup

The quantity of each type of product selected

The total price

An order can contain one or more products.

Products

Products can be:

Pizzas

Hamburgers

Drinks

Each product has:

A unique identifier

Name

Description

Image

Price

Pizza Categories

Pizzas belong to categories, which may change name during the year. A pizza can belong to only one category, but a category can include many pizzas. Each category stores a unique identifier and a name.

Stores

Each order is managed by one store, and a store can manage many orders. Each store has:

A unique identifier

Address

Postal code

City

Province

Employees

A store can have many employees, but each employee works in only one store. Each employee stores:

A unique identifier

First name

Last name

NIF (tax ID)

Phone number

Role (cook or delivery driver)

For home delivery orders, the database must also store which delivery driver delivered the order and the date and time of delivery.
