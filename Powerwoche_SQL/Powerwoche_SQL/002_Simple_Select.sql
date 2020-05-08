-- Einfache Abfragen

/*
	Text, Zahlen, Berechnungen im SELECT
*/

-- Groß-/Kleinschreibung eigentlich egal, SQL ist nicht case-sensitiv; trotzdem sollte innerhalb eines Projektes einheitlich alles groß oder klein geschrieben werden
select 100


SELECT 100;
GO -- Batch Delimiter

SELECT 'Testtext'

-- ganze Zeile markieren: SHIFT (Umschalt) + Ende/Pos1/Pfeil rauf/Pfeil runter

SELECT 100*3

SELECT '100*3' -- unter Hochkommata = Text!


SELECT 100, 'Testtext', 'noch mehr Text'


-- FORMAT?
SELECT	  100,
		  'Testtext',
--		  'noch mehr Text'

-- bisschen schöner:
SELECT	  100			-- dieser Fehler bezieht sich noch auf das Komma oben!
		, 'Testtext'
--		, 'noch mehr Text'


-- Spaltenüberschrift
-- ALIAS
-- SELECT Auswahl AS (als) Spaltenüberschriftname

SELECT 'Leo' AS Kunde


-- Übung:

SELECT	  100 AS Zahl
		, 'Donaudampfschifffahrtsgesellschaft' AS Text
		, 100*2 AS Rechnung

