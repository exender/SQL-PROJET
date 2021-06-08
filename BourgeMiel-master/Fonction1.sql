GO
	USE BourgeMiel
GO

CREATE OR ALTER FUNCTION DamageCalc (@armor INT, @damage INT)
RETURNS INT AS
BEGIN
    RETURN @damage - (@armor/100);
END;