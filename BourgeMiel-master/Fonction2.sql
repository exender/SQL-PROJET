GO
	USE BourgeMiel
GO

CREATE OR ALTER FUNCTION FightPVP (@PlayerID1 INT, @PlayerID2 INT)
RETURNS INT
AS
BEGIN
	-- P1 Values
	DECLARE @P1Health INT, @P1Armor INT, @P1Attack INT, @Winner INT
	SET @P1Health = dbo.PlayerHealth(@PlayerID1)
	SET @P1Armor = dbo.PlayerArmor(@PlayerID1)
	SET @P1Attack = dbo.PlayerAttack(@PlayerID1)
	-- P2 Values
	DECLARE @P2Health INT, @P2Armor INT, @P2Attack INT
	SET @P2Health = dbo.PlayerHealth(@PlayerID2)
	SET @P2Armor = dbo.PlayerArmor(@PlayerID2)
	SET @P2Attack = dbo.PlayerAttack(@PlayerID2)

	WHILE (@P1Health > 0 AND @P2Health > 0)
	BEGIN
		SET @P1Health = @P1Health - dbo.DamageCalc(@P1Armor, @P2Attack)
		SET @P2Health = @P2Health - dbo.DamageCalc(@P2Armor, @P1Attack) 
	END

	IF @P1Health < 0 SET @Winner = @PlayerID2
	ELSE IF @P2Health < 0 SET @Winner = @PlayerID1
	
	RETURN @Winner
END;