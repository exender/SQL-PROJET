GO
    USE BourgeMiel
GO

CREATE OR ALTER PROCEDURE PlayerStats(@PlayerID INT)
AS
BEGIN
	DECLARE @Health INT, @Armor INT, @Attack INT

	SET @Health = dbo.PlayerHealth(@PlayerID)
	SET @Armor = dbo.PlayerArmor(@PlayerID)
	SET @Attack = dbo.PlayerAttack(@PlayerID)

	PRINT CONCAT('Health: ', @Health, ' / Armor: ', @Armor, ' / Attack: ', @Attack)
END;