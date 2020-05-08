-- MAXDOP - maximal degree of parallelism 

-- wieviele CPUs dürfen maximal für eine Abfrage verwendet werden?

-- Object Explorer -> Server Rechtsklick -> Properties -> Advanced -> Parallelism

-- Daumen*Pi-Regel: nicht mehr als die Hälfte der verfügbaren CPUs 
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