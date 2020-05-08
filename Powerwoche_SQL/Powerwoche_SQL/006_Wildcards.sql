-- Wildcards

/*
	% ..... steht für beliebig viele unbekannte Zeichen (0 - ?)
	[]..... steht für genau EIN unbekanntes Zeichen aus einem bestimmten Wertebereich
	_ ..... steht für genau EIN unbekanntes Zeichen
	^ ..... NICHT
	| ..... ODER (innerhalb der eckigen Klammern)
*/

-- alle, die mit ALF beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'



-- ALF
-- ALFXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- ALFX

-- alle, die mit MI enden
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'

-- irgendwo im Namen muss Kiste vorkommen
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kiste%'


-- alle Kunden, deren Firmenname mit D beginnt
SELECT *
FROM Customers
WHERE CompanyName LIKE 'D%'

-- mit D enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%D'


-- die ein D enthalten
SELECT *
FROM Customers
WHERE CompanyName LIKE '%D%'

-- eckige Klammern bisher bei [Order Details]
-- hier andere Verwendung:

-- Wertebereiche mit []

-- alle Kunden, die mit a, b oder c beginnen
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' OR CompanyName LIKE 'b%' OR CompanyName LIKE 'c%'

-- oder kürzer:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[abc]%'


-- oder Wertebereich:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%'


-- UNTERSCHIED!!
-- alle, die mit abc beginnen:
-- wenn wir alle suchen, die mit abc beginnen, dann so:
-- [] steht für genau 1 Zeichen aus den in der eckigen Klammer angegebenen
SELECT *
FROM Customers
WHERE CustomerID LIKE 'abc%'
-- (gibt keinen)


-- geht auch mit Sonderzeichen, die in SQL eine andere Bedeutung haben
-- würden wir einen suchen, der ein %-Zeichen im Namen hat, dann müssten wir das gesuchte %-Zeichen in eckige Klammern setzen:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%'

-- andere Schreibweise für Suche nach Sonderzeichen: ESCAPE
SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!'



-- alle mit Hochkomma im Namen:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%' -- ACHTUNG: '', nicht ' (Ausnahme)



-- alle Kunden, die mit a beginnen und mit e enden
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%' AND CompanyName LIKE '%e'

-- oder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%e'


-- ********************* NOT *************************
-- die, die NICHT mit a-c beginnen
SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%'

-- idealerweise positiv formulieren:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-z]%'



-- *************** irgendein unbekanntes Zeichen suchen mit _ ***********************
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-472_'




-- **************************** Übungen **************************
-- Gib alle Produkte aus, deren Name mit „coffee“ endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'



-- Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'

-- Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'


-- alle, die ein d im Namen haben und mit e enden
SELECT *
FROM Products
WHERE ProductName LIKE '%d%e'



-- alle Kunden, die mit a beginnen, irgendwo im Namen ein f haben und aus Deutschland sind
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%f%' AND Country = 'Germany'



-- alle Bestellungen, die von den Angestellten 1, 3, 5 bearbeitet worden sind, von Kunden, die mit r beginnen, und wo Frachtkosten größer als 100 sind
SELECT *
FROM Orders
WHERE CustomerID LIKE 'r%' AND Freight > 100 AND EmployeeID IN(1, 3, 5)


-- alle Kunden, die mit a oder c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'

-- alle, die mit a, b oder c beginnen und mit e, f oder g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '[abc]%[efg]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%[e-g]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[abc]%' AND CustomerID LIKE '%[efg]'


-- alle, die mit a-c oder e-g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[abcefg]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c | e-g]'


-- Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-d|m-o]'

-- oder:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d|m-o]'


-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt.
-- Ordne das Ergebnis absteigend vom höchsten zum niedrigsten Stückpreis.
SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitsInStock > 10 AND UnitPrice < 100
ORDER BY UnitPrice DESC


-- unsere CustomerID besteht aus 5 Buchstaben
-- angenommen, es ist ein Fehler passiert
-- ALFK8 ... wie finde ich die falschen Einträge?

-- wie würde ich die richtigen Einträge finden?
-- also alle die, wo die CustomerID tatsächlich aus 5 Buchstaben
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-z][a-z][a-z][a-z][a-z]'
-- oder:
SELECT *
FROM Customers
WHERE CustomerID LIKE REPLICATE('[a-z]', 5)

-- wie finde ich die falschen Einträge:
SELECT *
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'


/*
	-- vierstelliger PIN-Code
	SELECT *
	FROM Tabelle
	WHERE Pin NOT LIKE '[0-9][0-9][0-9][0-9]'

*/


-- alle Kunden, die mit d, e oder f beginnen, der letzte Buchstabe ist ein L und der DRITTLETZTE ist ein d
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

/*
	mögliche Ergebnisse:
	ddxl
	edel
	fxxxxxxxxxxxxxxxxdxl
	fidel

	Ernst Handel  -- aus Northwind DB
	e........d.l


*/

