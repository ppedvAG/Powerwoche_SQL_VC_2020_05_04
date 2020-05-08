-- DISTINCT

-- was sind denn alle Länder, in die geliefert wird?
SELECT Country
FROM Customers
-- Ergebnis: Länder von allen Kunden, also auch doppelte, wenn mehr als 1 Kunde in einem Land


-- Lösung:
SELECT DISTINCT Country
FROM Customers



-- mehrere Spalten möglich?
SELECT DISTINCT Country, CustomerID
FROM Customers
-- in dem Fall bringt es nichts, denn DISTINCT bezieht sich auf ALLE Spalten im SELECT
-- die CustomerID ist bereits eindeutig, es gibt keine doppelten CustomerIDs, somit werden auch wieder Countries mehrfach angezeigt


SELECT DISTINCT Country, City
FROM Customers
ORDER BY City


SELECT DISTINCT Country, Region
FROM Customers


-- Liste von allen Städten, in denen wir Kunden haben?
SELECT DISTINCT City
FROM Customers

-- Liste von allen Ländern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- UK, USA

-- überprüfen, ob das stimmen kann:
SELECT Country
FROM Employees
ORDER BY Country





SELECT DISTINCT Country
FROM Customers

-- damit bekommen wir so viele Länder, wie es Kunden gibt!
SELECT COUNT(DISTINCT Country)
FROM Customers

-- damit bekommen wir die Anzahl der (unterschiedlichen) Länder
SELECT COUNT(DISTINCT Country)
FROM Customers

-- wieviele Einträge gibt es in der Tabelle? (in diesem Fall: wie viele Kunden haben wir?)
SELECT COUNT(*)
FROM Customers