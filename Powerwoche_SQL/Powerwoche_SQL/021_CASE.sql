-- CASE

SELECT OrderID, Quantity,
		CASE
			WHEN Quantity > 10 THEN 'größer 10'
			WHEN Quantity = 10 THEN 'genau 10'

			ELSE 'unbekannt'
		END
FROM [Order Details]


-- Übung:
-- Customers
-- wenn EU Mitglied, dann 'EU'
-- wenn kein EU Mitglied, dann 'nicht EU'
-- wenn UK, dann 'Brexit'
-- wenn nicht bekannt, 'Keine Ahnung'

SELECT	  CustomerID, CompanyName, Country,
	CASE
		WHEN Country IN('Germany', 'Spain', 'France') THEN 'EU'
		WHEN Country = 'UK' THEN 'Brexit'
		ELSE 'Keine Ahnung'
	END AS [Case]
FROM Customers
ORDER BY [Case]