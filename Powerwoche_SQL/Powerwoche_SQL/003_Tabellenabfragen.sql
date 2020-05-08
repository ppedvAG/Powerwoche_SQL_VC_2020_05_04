-- einfache Tabellenabfragen
-- SELECT auf Tabellen
-- immer überprüfen, welche Datenbank verwendet wird!

USE Northwind

-- * bedeutet: alle Spalten dieser Tabelle
-- sollte normalerweise NICHT verwendet werden! Jede gewünschte Spalte einzeln hinschreiben, auch wenn alle Spalten einer Tabelle ausgegeben werden sollen
-- Theoretisch können jederzeit Spalten zu einer Tabelle hinzukommen, mit Informationen, die nicht angezeigt werden sollen oder auf die wir keinen Zugriff haben
SELECT *
FROM Customers


SELECT CompanyName
FROM Customers


SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers



-- Spaltenüberschrift
SELECT	  CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefonnummer
FROM Customers


SELECT	  CompanyName AS Firmenname
		, ContactName AS Kontaktperson
		, Phone AS Telefonnummer
		, 100 AS Zahl
		, 'Testtext' AS Text
FROM Customers


-- von Bestellungen (Orders): Bestellnummer, welcher Kunde hat bestellt (CustomerID), welcher Angestellte hat verkauft (EmployeeID), in welches Land ist geliefert worden?
-- nachschauen im Datenbankdiagramm

USE Northwind

SELECT	  OrderID AS Bestellnummer
		, CustomerID AS Kundennummer
		, EmployeeID AS Angestellter
		, ShipCountry AS Land
FROM Orders


-- Gib die ProduktID, den Produktnamen und den Stückpreis aus.
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products


-- Annahme: Freight = netto
-- Gib die Nettofrachtkosten, Bruttofrachtkosten und die Mehrwertsteuer aus (Berechnung).

SELECT	  Freight -- AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders

