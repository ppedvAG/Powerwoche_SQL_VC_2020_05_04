-- Aggregatfunktionen
-- aggregate functions

-- COUNT - z�hlen
-- AVG - average (Durchschnittswert)
-- SUM - Summe bilden
-- MIN, MAX


-- GROUP BY - gruppieren nach - z.B. Summe Pro ...


-- In wie vielen L�ndern haben wir Kunden?
SELECT Country
FROM Customers
-- so viele Ergebnisse, wie Kunden (bringt nix)

-- mit DISTINCT
SELECT DISTINCT Country
FROM Customers
-- damit bekommen wir so viele Eintr�ge, wie es unterschiedliche L�nder gibt

-- mit COUNT!
SELECT COUNT(Country)
FROM Customers
-- damit bekommen wir so viele, wie es Kunden gibt, weil bei jedem Kunden ein Country dabei steht


-- kombiniert mit DISTINCT:
SELECT COUNT(DISTINCT Country) AS L�nderanzahl
FROM Customers
-- damit bekommen wir jetzt die Anzahl der L�nder (unterschiedliche, keine doppelten mitgez�hlt; 21)


-- wenn es keine doppelten Eintr�ge gibt, z.B. bei einer ID, dann brauchen wir kein DISTINCT
SELECT COUNT(ProductID) AS [Anzahl Produkte]
FROM Products
-- 77

-- oder:
SELECT COUNT(*) AS [Anzahl Produkte]
FROM Products
-- 77


-- Durchschnittswert berechnen: AVG
SELECT AVG(UnitPrice) AS Durchschnittspreis
FROM Products
-- 28,8663



-- Summe bilden: SUM
SELECT SUM(Freight) AS [Summe aller Frachtkosten]
FROM Orders
-- 64942,69



-- kleinster/gr��ter Wert
SELECT MIN(UnitPrice) AS [kleinster St�ckpreis]
FROM Products

SELECT MAX(UnitPrice) AS [h�chster St�ckpreis]
FROM Products


-- *************************** GROUP BY ****************************
-- Summe PRO...? Summe Frachtkosten pro Kunde
SELECT    SUM(Freight) AS [Summe Frachtkosten/Kunde]
		, CustomerID
FROM Orders
-- WHERE YEAR(ShippedDate) = 1996
GROUP BY CustomerID -- Summe pro was? Pro Kunde
-- ORDER BY [Summe Frachtkosten/Kunde]


-- bringt nix!!
SELECT SUM(Freight)
		, Freight
		, CustomerID
		, OrderID
FROM Orders
GROUP BY CustomerID, OrderID, Freight
-- das sind wieder alle Bestellungen; die Summe Frachtkosten pro Bestellung sind wieder genau die Frachtkosten!


-- das geht:
SELECT SUM(Freight)
		, ShipCountry
		, ShipCity
FROM Orders
GROUP BY ShipCountry, ShipCity
-- Summe der Frachtkosten pro Stadt im jeweiligen Land


-- durchschnittliche Frachtkosten pro Fr�chter
SELECT    AVG(Freight) AS [Frachtkosten/Fr�chter]
		, ShipVia
FROM Orders
GROUP BY ShipVia

-- mit ORDER BY kombinieren
SELECT    AVG(Freight) AS [Frachtkosten/Fr�chter]
		, ShipVia
FROM Orders
GROUP BY ShipVia
ORDER BY AVG(Freight)


-- durchschnittlicher Preis der Waren
SELECT AVG(UnitPrice)
FROM Products


-- durchschnittlicher Preis pro ... z.B. Supplier
SELECT    AVG(UnitPrice) AS Durchschnittspreis
		, SupplierID
FROM Products
GROUP BY SupplierID


