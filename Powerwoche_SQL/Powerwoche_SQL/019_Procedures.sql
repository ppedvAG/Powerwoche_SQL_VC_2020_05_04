-- Prozeduren
-- procedures


CREATE PROC Demo19
AS
SELECT TOP 1 * FROM Orders ORDER BY Freight
SELECT TOP 1 * FROM Orders ORDER BY Freight DESC
SELECT Country FROM Customers WHERE Region IS NOT NULL


-- aufrufen mit EXEC (execute - ausführen)
EXEC Demo19


CREATE PROC p_Customers_Cities @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City


EXEC p_Customers_Cities @City = 'Graz'


CREATE PROC p_Customers_City_Country @City varchar(30), @Country varchar(30)
AS
SELECT * FROM Customers WHERE City = @City AND Country = @Country


EXEC p_Customers_City_Country @City = 'Berlin', @Country = 'Germany'
