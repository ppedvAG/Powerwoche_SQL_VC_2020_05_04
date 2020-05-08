-- temporäre Tabellen
-- temporary tables


/*
	-- lokale temporäre Tabellen
	-- existieren nur in der aktuellen Session
	-- #tname


	-- globale temporäre Tabellen
	-- Zugriff auch von anderen Sessions aus
	-- ##tname

	-- hält nur so lange, wie Verbindung da ist
	-- kann auch gelöscht werden

*/


SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1

SELECT OrderID, OrderDate
INTO ##t2
FROM Orders

SELECT *
FROM ##t2