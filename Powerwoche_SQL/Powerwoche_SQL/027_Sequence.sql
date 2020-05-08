-- Sequence
-- für ganz alte SQL Serverversionen nicht geeignet, geht ab SQL Server 2012

-- bei identity konnten wir auch angeben wo wir starten und wieviel jeweils hochgezählt wird 
-- identity(10000, 5)
-- wir starten bei 10000 zu zählen und zählen jeweils um 5 hoch



CREATE SEQUENCE my_sq
START WITH 1
INCREMENT BY 1


CREATE SEQUENCE my_sq1
START WITH 1
INCREMENT BY 1



-- aufrufen mit NEXT VALUE FOR
-- nächste ID automatisch erstellen mit DEFAULT:
CREATE TABLE SeqTest (
						ID int PRIMARY KEY DEFAULT (NEXT VALUE FOR my_sq),
						TestName varchar(30),
						TestNumber int
					 )

INSERT INTO SeqTest (TestName, TestNumber)
VALUES ('James', 4567),
		('Mike', 9876543)

SELECT *
FROM SeqTest


-- oder einzeln einfügen möglich:
CREATE TABLE SeqTest1 (
						ID int PRIMARY KEY,
						TestName varchar(30),
						TestNumber int
					 )

INSERT INTO SeqTest1 (ID, TestName, TestNumber)
VALUES  (NEXT VALUE FOR my_sq1, 'Leo', 987654),
		(NEXT VALUE FOR my_sq1, 'Hans', 9765),
		(NEXT VALUE FOR my_sq1, 'Birgit', 12354),
		(NEXT VALUE FOR my_sq1, 'Tina', 7654554)


SELECT *
FROM SeqTest1

-- SELECT NEXT VALUE FOR my_sq1