-- ER - Diagramm 
-- Unterschiedliche Notationen (Chen, Min-Max, Kr�henfu�,...)

-- Normalformen
-- 1. NF: "atomar" (nur 1 Eintrag pro Feld)
-- 2. NF: 1. NF muss erf�llt sein und alle m�ssen von 1 Schl�ssel abh�nging sein
-- 3. NF: 1. und 2. NF m�ssen erf�llt sein und es d�rfen keine transitiven Abh�ngigkeiten bestehen (Nicht-Schl�sselfelder d�rfen nicht voneinander abh�ngig sein)
-- NF wollen Redundanz vermeiden
-- Performance? Wir k�nnen die NF auch brechen, wir m�ssen sie nicht zwingend einhalten.






-- CREATE, INSERT, UPDATE, DELETE, (DROP)
-- Erstellen von Tabellen und Ver�ndern von Werten

CREATE DATABASE Test

-- Achtung: DROP bedeutet, die gesamte DB inklusive Inhalt ist unwiederbringlich gel�scht!!!
-- DROP DATABASE Test


-- Tabellen erstellen
-- CREATE TABLE tablename (columnname datatype)

CREATE TABLE Produkte
					(
						ProduktID smallint identity(10000, 1), -- identity macht auch NOT NULL UNIQUE
						ProduktName varchar(50) NOT NULL,
						Preis money,
--						...,
--						...
					)


-- DROP TABLE Produkte
-- Achtung: komplette Tabelle ist inklusive Inhalt weg

INSERT INTO Produkte (ProduktName, Preis)
VALUES('Spaghetti', 1.99)


INSERT INTO Produkte (Preis, ProduktName)
VALUES	 (1.89, 'Penne'), 
		 (4.99, 'Tiramisu'),
		 (5.49, 'Profiterols')

SELECT *
FROM Produkte


-- Werte ver�ndern mit UPDATE
-- immer mit WHERE einschr�nken! Sonst wird der Preis bei ALLEN gesetzt!!
-- idealerweise immer etwas nehmen, womit das gew�nschte Produkt eindeutig identifiziert werden kann (ID)
UPDATE Produkte
SET Preis = 1.79
WHERE ProduktID = 10001


-- DROP = komplette Tabelle inklusive Inhalt unwiederbringlich gel�scht
-- DELETE FROM tablename = Inhalt der Tabelle l�schen, aber Tabelle selbst ist noch da
-- DELETE immer mit WHERE einschr�nken!!! sonst ist zwar die Tabelle noch da, aber der komplette Inhalt weg
DELETE FROM Produkte
WHERE ProduktID = 10004


SELECT *
FROM Produkte



-- Tabelle ver�ndern mit ALTER
ALTER TABLE Produkte
ALTER COLUMN ProduktName nvarchar(50)



-- neue Spalte hinzuf�gen
ALTER TABLE Produkte
ADD Email nvarchar(30)


-- ups, Fehler, falsche Tabelle, Email soll nat�rlich nicht in die Produkte
ALTER TABLE Produkte
DROP COLUMN Email
-- auch das l�scht wieder die gesamte Spalte samt Inhalt!

SELECT *
FROM Produkte


-- Datenbankerstellung
-- Schl�ssel (Keys)
-- Primary Key (Hauptschl�ssel)
-- Foreign Key (Fremdschl�ssel)


-- Primary Key
-- von dem sind alle anderen in der Tabelle abh�ngig
-- UNIQUE (eindeutig)
-- NOT NULL


-- Foreign Key
-- Schnittstelle zu anderen Tabellen


CREATE TABLE Orders (
						OrderID int identity PRIMARY KEY,
						CustomerID int,
						OrderDate date,
						ShipVia int
--						....,
--						.....
					)

-- mit IDENTITY wird eine ID generiert, dadurch ist die OrderID automatisch auch UNIQUE NOT NULL



-- Schl�ssel �ber Key-Constraint hinzuf�gen
-- PK normalerweise direkt beim Erstellen der Tabelle
-- KANN aber auch nachtr�glich eingef�gt werden
--ALTER TABLE Customers
--ALTER COLUMN CustomerID int not null

ALTER TABLE Customers
ADD CONSTRAINT PK_Customers PRIMARY KEY (CustomerID)


-- Verkn�pfungen zwischen den Tabellen herstellen mit FOREIGN KEY Constraint
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)



CREATE TABLE Shippers (
						ShipperID int identity PRIMARY KEY,
						CompanyName varchar(30),
						Phone varchar(30)
-- andere M�glichkeit:	CONSTRAINT PK_Shippers PRIMARY KEY (ShipperID)
					  )


ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID)


-- unterschiedliche Varianten, wie ein Foreign Key definiert werden kann:

-- Variante 1:
CREATE TABLE Orders (
						OrderID int identity PRIMARY KEY,
						CustomerID int FOREIGN KEY REFERENCES Customers(CustomerID),
						OrderDate date,
						ShipVia int FOREIGN KEY REFERENCES Shippers(ShipperID)
--						....,
--						.....
					)
-- wir k�nnen einen FOREIGN KEY direkt beim Erstellen der Tabelle setzen, aber:
-- VORSICHT: Reihenfolge!! Wenn es die Tabellen noch nicht gibt, auf die ich referenzieren m�chte -> Fehlermeldung
-- Shippers und Customers m�ssen schon erstellt sein


-- Variante 2:
CREATE TABLE Orders (
						OrderID int identity PRIMARY KEY,
						CustomerID int,
						OrderDate date,
						ShipVia int
--						....,
--						.....
						CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

						CONSTRAINT FK_Orders_Shippers FOREIGN KEY (ShipVia) REFERENCES Shippers(ShipperID)
					)
-- wir k�nnen CONSTRAINTS auch innerhalb des CREATE erstellen, gleiches Problem wie bei Variante 1: die Tabellen, auf die referenziert werden soll, m�ssen schon davor erstellt worden sein


-- Variante 3 (Leo's preference :) )
-- nachtr�glich Constraint erstellen, wenn es alle Tabellen schon gibt
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
