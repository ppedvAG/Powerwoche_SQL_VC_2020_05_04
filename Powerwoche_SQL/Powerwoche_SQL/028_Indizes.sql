-- Indices, Indizes, Indexe
-- indexes


-- clustered index
-- nonclustered index
	-- zusammengesetzter Index (multicolumn index)
	-- Index mit eingeschlossenen Spalten (index with included columns)
	-- abdeckender Index (covering index)
	-- eindeutiger Index (unique index)
	-- gefilterter Index (filtered index)

-- columnstore Index 


CREATE CLUSTERED INDEX IX_Customers_CustomerID
ON Customers (CustomerID)


CREATE NONCLUSTERED INDEX IX_Name
ON Tabelle (Spalte)

-- NONCLUSTERED könnten wir auch weglassen; wenn nicht spezifisch angegeben, wird automatisch ein nonclustered Index erstellt

CREATE INDEX IX_Name
ON Tabelle (Spalte)


-- Zusammengesetzter Index (multicolumn index)
CREATE NONCLUSTERED INDEX IX_Country_City
ON Customers (Country, City)
-- wir können bis zu 16 Spalten in einem multicolumn index verwenden
-- Sinn?


-- Index mit eingeschlossenen Spalten (index with included columns)
CREATE UNIQUE INDEX IX_CID_CName_Contact
ON Customers(CustomerID)
INCLUDE (CompanyName, ContactName)


-- wenn alle Spalten, die in einer Abfrage vorkommen, auch von dem Index erfasst werden, spricht man auch von einem covering index (abdeckender Index)

-- wenn eine Spalte vorkommt, die eindeutig ist, spricht man auch von einem unique index (eindeutiger Index)



-- filtered index (gefilterter Index)
CREATE NONCLUSTERED INDEX IX_Customers_Germany
ON Customers (CustomerID)
WHERE Country = 'Germany'


SELECT firstname
FROM Helden
WHERE age IS NOT NULL


--ALTER TABLE Helden
--ALTER COLUMN firstname varchar(30) NOT NULL

--ALTER TABLE Helden
--ADD CONSTRAINT PK_Helden_firstname PRIMARY KEY (firstname)


SELECT * FROM sys.dm_db_index_usage_stats




