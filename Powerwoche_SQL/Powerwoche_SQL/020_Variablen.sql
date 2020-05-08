-- Variablen

/*
	-- lokale Variablen
	-- @varname
	-- Zugriff nur in der Session, in der sie erstellt wurde


	-- globale Variablen
	-- @@varname
	-- Zugriff von außerhalb der Session

	-- Lebenszeit: nur, solange der Batch läuft

	-- Variable deklarieren
	-- welchen Datentyp soll die Variable bekommen

	-- Syntax:
	DECLARE @varname AS Datentyp

*/


-- Bsp.:

-- deklarieren:
DECLARE @var1 AS int


-- Wert zuweisen:
SET @var1 = 100


SELECT @var1


DECLARE @myDate datetime2 = SYSDATETIME()
SELECT FORMAT(@myDate, 'd', 'de-de')


-- VORSICHT: 
DECLARE @myDate1 datetime2 = '2020-05-07'
SELECT FORMAT(@myDate1, 'd', 'de-de')
-- was ist Tag, was Monat ist systemabhängig


DECLARE @freight AS money = 50

SELECT *
FROM Orders
WHERE Freight > @freight