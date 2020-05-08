-- CAST, CONVERT und FORMAT - in welchem Format wollen wir etwas darstellen und in welchem Datentyp?


-- ****************************** CAST *************************************
-- Umwandeln von Datentypen

-- funktioniert:
SELECT '123' + 2


-- funktioniert nicht:
SELECT '123.3' + 2
-- Conversion failed when converting the varchar value '123.3' to data type int.


/*
	implizite und explizite Konvertierung in der Microsoft-Dokumentation:
	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/


-- wir können aber explizit konvertieren (einen Datentyp in einen anderen umwandeln)
SELECT CAST('123.3' AS float) + 2


-- geht auch mit Datum, nur mit CAST alleine haben wir aber keinen Einfluss auf das Format
SELECT CAST(SYSDATETIME() AS varchar)


-- Vorsicht mit Anzahl der Zeichen
SELECT CAST(SYSDATETIME() AS varchar(3)) -- macht keinen Sinn (202)

-- Vorsicht auch:
SELECT CAST('2020-05-10' AS date) -- Achtung: was als Tag oder Monat interpretiert wird, ist systemabhängig!!


-- mit DB:
SELECT HireDate
FROM Employees

-- nur mit CAST kein Einfluss auf Format!
SELECT CAST(HireDate AS varchar)
FROM Employees



-- ************************ CONVERT ************************************
-- auch mit CONVERT wird ein Datentyp in einen anderen konvertiert (wie der Name schon sagt), aber hier haben wir noch mehr Möglichkeiten
-- Style-Parameter (optional)

-- Syntax:
-- SELECT CONVERT(data_type[(length)], expression[, style])
-- zuerst in welchen Datentyp soll konvertiert werden
-- WAS soll konvertiert werden
-- optional: Style-Parameter (in welchem Format soll das Datum ausgegeben werden)

SELECT CONVERT(float, '123.3') + 2

-- funktioniert auch mit Datum
SELECT CONVERT(varchar, SYSDATETIME())


SELECT CONVERT(varchar(3), SYSDATETIME()) -- auch wieder mit Länge aufpassen - sinnlos!


-- für Datum gibt es den Style-Parameter:

SELECT CONVERT(varchar, SYSDATETIME(), 104)


/*
	Date und Time Styles in der Microsoft-Dokumentation:
	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/

SELECT    CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB


-- mit Information aus der Datenbank:
SELECT    CONVERT(varchar, HireDate, 104) AS DE
		, CONVERT(varchar, HireDate, 101) AS US
		, CONVERT(varchar, HireDate, 103) AS GB
FROM Employees



-- *********************** FORMAT *************************************
-- Ausgabe-Datentyp ist nvarchar

SELECT FORMAT(1234567890, '###-###/##-##')

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###')

-- geht auch mit Datum:
SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- VORSICHT: 05.54.2020 - mm kleingeschrieben wird als Minute interpretiert!!
-- damit das funktioniert, MM großschreiben!
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy')

-- bei Format funktioniert das NICHT:
SELECT FORMAT('2020-05-05', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.


-- mit Info aus DB:
SELECT FORMAT(HireDate, 'dd.MM.yyyy') AS HireDate
FROM Employees


-- mit Culture-Parameter:
SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-us') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-gb') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden


/*
	Microsoft-Dokumentation Supported Culture Codes:
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes

*/

SELECT	  FORMAT(HireDate, 'd', 'de-de') AS DE
		, FORMAT(HireDate, 'd', 'en-us') AS US
		, FORMAT(HireDate, 'd', 'en-gb') AS GB
		, FORMAT(HireDate, 'd', 'sv') AS Schweden
FROM Employees

-- das kleine 'd' bedeutet Datum in Zahlen
-- großes 'D' bedeutet Tag und Monat ausgeschrieben (wie regional üblich)


SELECT	  FORMAT(HireDate, 'D', 'de-de') AS DE
		, FORMAT(HireDate, 'D', 'en-us') AS US
		, FORMAT(HireDate, 'D', 'en-gb') AS GB
		, FORMAT(HireDate, 'D', 'sv') AS Schweden
FROM Employees

-- Gib die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.
SELECT RequiredDate
	 , ShippedDate
	 , DATEDIFF(dd, RequiredDate, ShippedDate) AS Diff
FROM Orders


-- Gib die Bestellnummer,
--     den Wunschtermin,
--      das Lieferdatum und
--     die Lieferverzögerung aus.
--Ergebnisse von Bestellungen, die noch nicht geliefert wurden, sollen nicht ausgegeben werden.
--Ordne das Ergebnis absteigend von der größten zur kleinsten Lieferverzögerung.

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Diff
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Diff DESC


-- Gib die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.
SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ', ', LastName) AS Name
		, FORMAT(BirthDate, 'dd.MM.yyyy') AS BirthDate
		, HomePhone
FROM Employees

-- oder:
SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS Name
		, FORMAT(BirthDate, 'd', 'de-de') AS BirthDate
		, HomePhone
FROM Employees

-- oder:
SELECT	  EmployeeID
		, TitleOfCourtesy
		, CONCAT(FirstName, ' ', LastName) AS Name
		, CONVERT(varchar, BirthDate, 104) AS BirthDate
		, HomePhone
FROM Employees

