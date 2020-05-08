-- Transaktion
-- transaction

SELECT *
FROM Helden


BEGIN TRAN

UPDATE Helden
SET firstname = 'Minnie'
-- ups, Fehler --> ROLLBACK, dann ist noch nix passiert
ROLLBACK TRAN



BEGIN TRAN

UPDATE Helden
SET firstname = 'Minnie'
WHERE lastname = 'Mouse'

COMMIT TRAN
-- in dem Moment, wo wir ein Commit gemacht haben ist es fix und kann nicht mehr mit Rollback rückgängig gemacht werden



BEGIN TRAN

UPDATE Helden
SET age = 500
WHERE firstname = 'Fuchur'

-- ROLLBACK TRAN
COMMIT TRAN



