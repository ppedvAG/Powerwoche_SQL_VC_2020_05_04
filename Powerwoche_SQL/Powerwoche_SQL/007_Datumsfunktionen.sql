-- Datumsfunktionen

-- datetime, datetime2, date, time


/*
	Datumsintervalle:
		year, yyyy, yy = Jahr
		quarter, qq, q = Quartal
		month, MM, M = Monat
		week, ww, wk = Woche
		day, dd, d = Tag
		hour, hh = Stunde
		minute, mi, n = Minute
		second, ss, s = Sekunde
		millisecond, ms = Millisekunde
		nanosecond, ns = Nanosekunde

		weekday, dw, w = (dw wie day of the week), Wochentag
		dayofyear, dy, y = Jahrestag

*/

-- ************************ Datum abfragen ****************************
-- auf 3-4 ms genau; datetime; 8 byte
SELECT GETDATE()

-- auf mehrere ns genau; datetime2; 6-8 byte
SELECT SYSDATETIME()


-- *************************** DATEADD ***************************
-- Datumsberechnungen: etwas zum Datum hinzuzählen/wegrechnen

SELECT DATEADD(hh, 10, '2020-05-05') -- 2020-05-05 10:00:00.000
-- wenn Uhrzeit nicht angegeben wird, gehen wir von 0:00 Uhr aus!

SELECT DATEADD(hh, 10, '05.07.2020')
-- Vorsicht mit Datumsformat! 
-- Was ist Tag, was ist Monat? Systemabhängig!

-- Stunden, Minuten (ms, ns) können optional angegeben werden
SELECT DATEADD(hh, 10, '2020-05-05 13:43:25')


-- mit aktuellem Datum
SELECT DATEADD(hh, 10, SYSDATETIME())
SELECT DATEADD(hh, 10, GETDATE())

-- negative Vorzeichen sind erlaubt, wir können so auch ein bestimmtes Intervall abziehen
SELECT DATEADD(hh, -10, SYSDATETIME())


-- *********************** DATEDIFF ***************************************
-- Differenz zwischen zwei Daten bilden

-- wie lange bis zum nächsten Feiertag?
SELECT DATEDIFF(dd, '2020-05-05', '2020-05-21') -- 16 Tage
SELECT DATEDIFF(dd, '2020-05-21', '2020-05-05') -- -16 Tage (negatives Vorzeichen)

-- auch hier können wir mit dem aktuellen Datum arbeiten
SELECT DATEDIFF(dd, SYSDATETIME(), '2020-05-21')


-- ********************** DATEPART ********************************
-- Datumsteil ausgeben

SELECT DATEPART(dd, '2020-05-05')
SELECT DATEPART(yyyy, '2020-05-05')
SELECT DATEPART(yyyy, SYSDATETIME())



-- *************************** DATENAME *******************************
-- bei Datename machen nur zwei Intervalle Sinn: dw (Wochentag) und month

SELECT DATENAME(dd, '2020-05-05') -- 5


SELECT DATENAME(dw, '2020-05-05') -- Tuesday

SELECT DATENAME(MM, '2020-05-05') -- May


-- Übungen
-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, '2020-05-05')
SELECT DATEADD(dd, 38, SYSDATETIME())
SELECT DATEADD(dd, 38, GETDATE())


-- Welcher Wochentag war Dein Geburtstag?
SELECT DATENAME(dw, '1996-08-29') -- Thursday

-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yyyy, '2020-05-05', '1977-05-25') -- -43 (negatives Vorzeichen)
SELECT DATEDIFF(yyyy, '1977-05-25', '2020-05-05') -- 43

SELECT DATEDIFF(yyyy, '1977-05-25', SYSDATETIME())
-- was als Start- oder Enddatum verwendet wird, wirkt sich darauf aus, ob wir ein negatives Vorzeichen zurückbekommen. Abhängig von der Fragestellung, ob das Sinn macht!


-- In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?
SELECT DATEPART(qq, '2020-10-26') -- 4
-- SELECT DATENAME(qq, '2020-10-26') -- 4



--Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an
-- Tag	 Monat	 Jahr
--  22	  04	 1981
SELECT    DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr


SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr


-- ************************* DAY, MONTH, YEAR *****************************
-- gleiches Ergebnis wie mit DATEPART dd, MM oder yyyy
-- Tag/Monat/Jahr als Integerwert
SELECT DAY('1981-04-22')
SELECT MONTH('1981-04-22')
SELECT YEAR('1981-04-22')



-- in Kombination mit der DB:
SELECT HireDate
FROM Employees

SELECT YEAR(HireDate) AS Einstellungsjahr
FROM Employees











