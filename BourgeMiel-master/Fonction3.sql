GO
    USE BourgeMiel
GO

CREATE OR ALTER FUNCTION PlayerHealth(@PlayerID INT)
RETURNS INT
AS
BEGIN
	DECLARE @Health INT

	SELECT @Health = p.PlayerHealth + SUM(i.ItemHealthStat) FROM Players as p
	INNER JOIN Equipments as e ON e.PlayerId = p.PlayerId
	INNER JOIN Items as i ON i.ItemId = e.ItemId
	WHERE p.PlayerId = @PlayerID
	GROUP BY p.PlayerHealth, p.PlayerArmor, p.PlayerDamage

    RETURN @Health;
END;

GO
    USE BourgeMiel
GO

CREATE OR ALTER FUNCTION PlayerArmor(@PlayerID INT)
RETURNS INT
AS
BEGIN
	DECLARE @Armor INT

	SELECT @Armor = p.PlayerArmor + SUM(i.ItemArmorStat) FROM Players as p
	INNER JOIN Equipments as e ON e.PlayerId = p.PlayerId
	INNER JOIN Items as i ON i.ItemId = e.ItemId
	WHERE p.PlayerId = @PlayerID
	GROUP BY p.PlayerArmor

    RETURN @Armor;
END;

GO
    USE BourgeMiel
GO

CREATE OR ALTER FUNCTION PlayerAttack(@PlayerID INT)
RETURNS INT
AS
BEGIN
	DECLARE @Attack INT

	SELECT @Attack = p.PlayerDamage + SUM(i.ItemDamageStat) FROM Players as p
	INNER JOIN Equipments as e ON e.PlayerId = p.PlayerId
	INNER JOIN Items as i ON i.ItemId = e.ItemId
	WHERE p.PlayerId = @PlayerID
	GROUP BY p.PlayerDamage

    RETURN @Attack;
END;