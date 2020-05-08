-- Untergruppierungen
-- OVER PARTITION BY


-- Mittelwert der Frachtkosten
SELECT AVG(Freight) AS [mittlere Frachtkosten]
FROM Orders
-- 78,2442


-- Mittelwert pro... z.B. pro Frächter (ShipVia)
SELECT	  ShipVia
		, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY ShipVia


-- mit mehreren Spalten gehts auch, also z.B. mittlerer Frachtkostenwert pro Kunde und Frächter
SELECT	  CustomerID
		, ShipVia
		, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY CustomerID, ShipVia


-- irgendwo kommen wir an den Punkt, wo mehrere Spalten keinen Sinn mehr machen
-- z.B., wenn man die OrderID auch ausgeben möchte (eindeutig -> mittlere Frachtkosten pro OrderID sind wieder genau die Frachtkosten)
SELECT	  OrderID
		, CustomerID
		, ShipVia
		, AVG(Freight) AS AvgFreight
FROM Orders
GROUP BY OrderID, CustomerID, ShipVia
-- kein Mittelwert mehr!


-- mit OVER PARTITION BY können wir trotzdem den Mittelwert hinschreiben, dann steht er aber mehrfach da
-- mittleren Frachtkosten pro Frächter
SELECT	  OrderID
		, CustomerID
		, ShipVia
		, AVG(Freight)
			OVER(PARTITION BY ShipVia) AS [AVGFreight/Shipper]
FROM Orders

-- mittlere Frachtkosten pro Kunde und Frächter
SELECT	  OrderID
		, CustomerID
		, ShipVia
		, AVG(Freight)
			OVER(PARTITION BY CustomerID, ShipVia) AS [AVGFreight/Shipper]
FROM Orders

