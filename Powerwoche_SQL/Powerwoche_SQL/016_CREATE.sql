-- CREATE



CREATE DATABASE Test


CREATE TABLE Customers (
							CustomerID int,
							CompanyName varchar(50),
							ContactName varchar(50),
							Phone varchar(50)
							-- ,...
						)

SELECT *
FROM Customers


INSERT INTO Customers
VALUES (1, 'Alfreds Futterkiste', 'Hugo Keller', '1234567890')



INSERT INTO Customers
VALUES  (2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', '0987654323456'),
		(3, 'Antonio Moreno Taquería', 'Antonio Moreno', '9876567'),
		(4, 'Around the Horn', 'Thomas Hardy', '8765434567'),
		(5, 'Berglunds snabbköp', 'Christina Berglund', '8765432456789')



SELECT *
FROM Customers