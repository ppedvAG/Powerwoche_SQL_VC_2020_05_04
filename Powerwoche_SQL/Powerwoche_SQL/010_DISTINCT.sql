-- DISTINCT

-- was sind denn alle L�nder, in die geliefert wird?
SELECT Country
FROM Customers
-- Ergebnis: L�nder von allen Kunden, also auch doppelte, wenn mehr als 1 Kunde in einem Land


-- L�sung:
SELECT DISTINCT Country
FROM Customers



-- mehrere Spalten m�glich?
SELECT DISTINCT Country, CustomerID
FROM Customers
-- in dem Fall bringt es nichts, denn DISTINCT bezieht sich auf ALLE Spalten im SELECT
-- die CustomerID ist bereits eindeutig, es gibt keine doppelten CustomerIDs, somit werden auch wieder Countries mehrfach angezeigt


SELECT DISTINCT Country, City
FROM Customers
ORDER BY City


SELECT DISTINCT Country, Region
FROM Customers


-- Liste von allen St�dten, in denen wir Kunden haben?
SELECT DISTINCT City
FROM Customers

-- Liste von allen L�ndern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- UK, USA

-- �berpr�fen, ob das stimmen kann:
SELECT Country
FROM Employees
ORDER BY Country





SELECT DISTINCT Country
FROM Customers

-- damit bekommen wir so viele L�nder, wie es Kunden gibt!
SELECT COUNT(DISTINCT Country)
FROM Customers

-- damit bekommen wir die Anzahl der (unterschiedlichen) L�nder
SELECT COUNT(DISTINCT Country)
FROM Customers

-- wieviele Eintr�ge gibt es in der Tabelle? (in diesem Fall: wie viele Kunden haben wir?)
SELECT COUNT(*)
FROM Customers