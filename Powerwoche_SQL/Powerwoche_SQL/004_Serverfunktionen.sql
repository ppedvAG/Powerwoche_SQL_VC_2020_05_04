-- häufig verwendete Serverfunktionen

-- ***************** TRIM, LEN, DATALENGTH *******************************

SELECT 'Test'

SELECT 'Test     '


SELECT LEN('Test') -- Anzahl der Zeichen (4)

SELECT LEN('Test     ') -- ignoriert Leerzeichen am Schluss

SELECT LEN('   Te st     ') -- Leerzeichen davor und dazwischen werden mitgezählt

SELECT DATALENGTH('Test') -- 4
SELECT DATALENGTH('Test     ') -- 9

SELECT LTRIM('     Test') -- lefttrim: entfernt Leerzeichen links
SELECT RTRIM('Test     ') -- righttrim: entfernt Leerzeichen rechts

SELECT DATALENGTH(RTRIM('Test     '))

SELECT TRIM('     Test     ') -- trim: entfernt Leerzeichen davor und danach


SELECT	  LEN(ContactName)
		, ContactName
FROM Customers


-- Übung:
SELECT TRIM('     Test     ')


SELECT DATALENGTH('     Test     ') AS Vorher
		, DATALENGTH(TRIM('     Test     ')) AS Nachher



-- ************************* REVERSE ************************************
-- Text in umgekehrter Reihenfolge anzeigen

SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so helle Hose nie mit Gurt?')


-- **************** LEFT, RIGHT, SUBSTRING ****************************
-- Zeichen ausschneiden

SELECT LEFT('Testtext', 4) -- schneidet 4 Zeichen links aus
SELECT RIGHT('Testtext', 4) -- schneidet 4 Zeichen rechts aus

SELECT SUBSTRING('Testtext', 4, 2)
-- ab welcher Stelle möchten wir ausschneiden (4)
-- wieviele Zeichen möchten wir ausschneiden (2)
-- Ergebnis: tt


-- ****************************** STUFF ********************************
-- Text einfügen/ersetzen

SELECT STUFF('Testtext', 5, 0, '_Hallo_')
-- wo soll etwas eingefügt werden? (Testtext)
-- beginnend bei welcher Stelle? (5)
-- wieviel soll weggelöscht werden (0)
-- was soll eingefügt werden? (_Hallo_)


--  ******************************** CONCAT ******************************
-- Strings zusammenfügen
SELECT CONCAT('Test', 'text')
SELECT CONCAT('abc', 'def', 'ghi', 'jkl', 'mno', 'pqr', 'stu', 'vwx', 'yz')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat

SELECT CONCAT('James', ' ', 'Bond') AS [vollständiger Name]

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees

SELECT ContactName
FROM Customers

-- Übung: Die letzten drei Stellen einer Telefonnummer sollen durch xxx ersetzt werden:

-- Möglichkeit 1
SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))

-- langsam:
SELECT REVERSE('1234567890') -- 0987654321

SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

SELECT REVERSE('xxx7654321')


SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))




-- Möglichkeit 2
SELECT LEFT('1234567890', 7) + 'xxx'

SELECT CONCAT(LEFT('1234567890', 7), 'xxx')
-- Vorsicht, geht nur bei gleicher Zeichenanzahl!

-- Möglichkeit 3
SELECT STUFF('1234567890', 8, 3, 'xxx')
-- Vorsicht, geht nur bei gleicher Zeichenanzahl!


-- Möglichkeit 4
SELECT LEFT('1234567890', LEN('1234567890')-3) + 'xxx'
SELECT CONCAT(LEFT('1234567890', LEN('1234567890')-3), 'xxx')


SELECT STUFF('1234567890', LEN('1234567890')-2, 3, 'xxx')


-- mit DB:
SELECT	  STUFF(Phone, LEN(Phone)-2, 3, 'xxx')
		, Phone
FROM Customers


SELECT    CONCAT(LEFT(Phone, LEN(Phone)-3), 'xxx')
		, Phone
FROM Customers


-- **************************** REPLICATE ****************************
-- Zeichen oder Zeichenfolgen mehrfach ausgeben
SELECT REPLICATE('x', 3) -- xxx
SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('abc', 3) -- abcabcabc



-- ********************* Groß- oder Kleinbuchstaben *************************
SELECT UPPER('test') -- TEST -- alles in Großbuchstaben
SELECT LOWER('TEST') -- test -- alles in Kleinbuchstaben

SELECT UPPER(LastName)
FROM Employees


-- **************************** REPLACE *************************************
-- bestimmte Zeichen ersetzen

SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), 'H', 'B')

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), 'H', 'B'), '!', '?')


-- *********************** CHARINDEX ********************************
-- an welcher Stelle befindet sich ein bestimmtes Zeichen?

SELECT CHARINDEX('a', 'Leo') -- 0 - wenn das Zeichen nicht vorkommt, dann 0

SELECT CHARINDEX('e', 'Leo') -- 2

-- Groß-/Kleinschreibung spielt beim Suchen keine Rolle
SELECT CHARINDEX('l', 'Leo') -- 1
SELECT CHARINDEX('L', 'Leo') -- 1

-- Leerzeichen suchen
SELECT CHARINDEX(' ', 'James Bond') -- 6

-- mit DB:
SELECT    ContactName
		, CHARINDEX(' ', ContactName)
FROM Customers


-- nach Zeichenfolgen suchen
SELECT CHARINDEX('schnecke', 'Zuckerschnecke')
-- gibt mir die Stelle aus, an der die gesuchte Zeichenfolge beginnt

-- man kann auch nach Sonderzeichen suchen
SELECT CHARINDEX('$', '450$')
SELECT CHARINDEX('%', '20%')


-- CHARINDEX gibt die 1. Stelle, wo das gesuchte Zeichen gefunden wird, aus
SELECT CHARINDEX(' ', 'Wolfgang Amadeus Mozart') -- 9


-- wie finde ich das letzte Leerzeichen?

-- langsam:
SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW

SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7

SELECT LEN('Wolfgang Amadeus Mozart') -- 23

-- 23-7= 16
-- 16 + 1 = Stelle, wo sich das letzte Leerzeichen befindet


SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW') + 1


SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart')) + 1 -- 17


-- geht das auch mit anderen Namen?
SELECT LEN('Johann Sebastian Bach') - CHARINDEX(' ', REVERSE('Johann Sebastian Bach')) + 1 -- 17

SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel')) + 1 -- 16


SELECT    LEN(CompanyName) - CHARINDEX(' ', REVERSE(CompanyName)) + 1 AS LastSpace
		, CompanyName
FROM Customers



-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)

-- Möglichkeit 1
SELECT STUFF(Phone, 1, LEN(Phone)-3, REPLICATE('x', LEN(Phone)-3))
FROM Customers

-- langsam:
-- wo wollen wir einfügen? (Phone)
-- beginnend bei welcher Stelle? (1)
-- wieviel wollen wir weglöschen? (LEN(Phone)-3) -- somit gehts auch für unterschiedliche Längen
-- und was wollen wir stattdessen einsetzen? ( REPLICATE('x',LEN(Phone)-3) )

-- Möglichkeit 2
-- langsam:
-- wie bekomme ich die letzten 3 Stellen?
SELECT RIGHT(Phone, 3)
FROM Customers

SELECT SUBSTRING(Phone, LEN(Phone)-2 , 3)
FROM Customers
-- der 2. Parameter ist die STELLE, von der ausgehend wir Zeichen ausschneiden
-- zur Erinnerung:
SELECT SUBSTRING('1234567890', LEN('1234567890')-2, 3) -- 890


SELECT REPLICATE('x', ?) -- wie oft brauche ich das x?
SELECT REPLICATE('x', LEN(Phone)-3)
FROM Customers

-- zusammenfügen:
SELECT	  Phone
		, CONCAT(REPLICATE('x', LEN(Phone)-3), SUBSTRING(Phone, LEN(Phone)-2 , 3))
FROM Customers



