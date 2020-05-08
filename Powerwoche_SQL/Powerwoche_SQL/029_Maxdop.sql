-- MAXDOP - maximal degree of parallelism 

-- wieviele CPUs d�rfen maximal f�r eine Abfrage verwendet werden?

-- Object Explorer -> Server Rechtsklick -> Properties -> Advanced -> Parallelism

-- Daumen*Pi-Regel: nicht mehr als die H�lfte der verf�gbaren CPUs 
-- (oder nicht mehr, als in einem Numa-node drin ist, wenn es mehrere gibt)

-- zum Testen:

set statistics io, time on


SELECT firstname
FROM Helden
WHERE age IS NOT NULL


SELECT CompanyName, SUM(UnitPrice*Quantity)
FROM ku4
WHERE CompanyName LIKE 'A%'
GROUP BY CompanyName