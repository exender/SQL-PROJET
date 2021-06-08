GO 
	USE BourgeMiel
GO

-- 1 level up
CREATE OR ALTER TRIGGER LevelUp
ON Players
AFTER UPDATE
AS
BEGIN
    UPDATE Players SET
        PlayerHealth = PlayerHealth + 20,
		PlayerArmor = PlayerArmor + 20,
		PlayerDamage = PlayerDamage +20
        WHERE PlayerLevel = (SELECT i.PlayerLevel FROM INSERTED i WHERE PlayerLevel < 100)
END

GO 
	USE BourgeMiel
GO

-- 2 Delete player equipment on delete
CREATE OR ALTER TRIGGER DeletePlayers
ON Players
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Equipments
	WHERE PlayerId IN (SELECT PlayerId FROM deleted)
	
	DELETE FROM Players
	WHERE PlayerId IN (SELECT PlayerId FROM deleted)
END

GO 
	USE BourgeMiel
GO

-- 3



GO 
	USE BourgeMiel
GO

-- 4