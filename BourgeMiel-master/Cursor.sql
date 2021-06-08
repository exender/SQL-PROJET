GO
	USE BourgeMiel
GO

DECLARE @zname VARCHAR(50)
DECLARE @bname VARCHAR(50)
DECLARE @zlevel VARCHAR(50)

DECLARE ForestBiomes CURSOR FOR 
SELECT z.ZoneName, b.BiomeName, z.ZoneLevel
FROM Zones z 
INNER JOIN Biomes b ON z.BiomeId = b.BiomeId 
WHERE UPPER(b.BiomeName) LIKE '%FOREST%' 
ORDER BY z.ZoneLevel DESC

OPEN ForestBiomes
FETCH ForestBiomes INTO @zname, @bname, @zlevel

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Biome : ' + @bname + ', Zones : ' + @zname + ', Niveau de la zone : ' + @zlevel
    FETCH NEXT FROM ForestBiomes INTO @zname, @bname, @zlevel
END
CLOSE ForestBiomes
DEALLOCATE ForestBiomes