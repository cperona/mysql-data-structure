# MySQL Data Structure

## Exercise 1

An optical shop called “Cul d'Ampolla” wants to computerize the management of its customers and glasses sales.

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
