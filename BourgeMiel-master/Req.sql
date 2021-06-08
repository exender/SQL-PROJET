GO
	USE BourgeMiel
GO

-- 1 Level up d'un joueur (avec un avant apr�s le level up)
DECLARE @ID INT;
SET @ID = 45;

SELECT CONCAT('Joueur num�ro ', @ID, ', qui se nomme : ', p.PlayerName, ', et est niveau : ' , p.PlayerLevel) AS 'Joueurs qui va gagner un niveau' FROM Players p WHERE PlayerId = @ID

UPDATE Players SET
PlayerLevel = PlayerLevel + 1
WHERE PlayerId = @ID AND PlayerLevel != 100

SELECT CONCAT('Joueur num�ro ', @ID, ', qui se nomme : ', p.PlayerName, ', et est niveau : ' , p.PlayerLevel) AS 'Joueurs qui vient de gagner un niveau' FROM Players p WHERE PlayerId = @ID

-- 2 Les 10 monstres les plus forts
SELECT TOP(10) m.MonsterName AS 'Nom du monstre', m.MonsterLevel AS 'Niveau du monstre'
FROM Monsters m
ORDER BY MonsterLevel DESC

-- 3 Les monstres qui drop des items rare, et qui sont natif au zone 'camp' qui font partie des biomes 'land'

SELECT m.MonsterName AS 'Nom du monstre', i.ItemName AS "Nom de l'item que le monstre drop", 
REPLACE(i.RaritityId, i.RaritityId, r.RaritityName) AS 'Raret�', 
CONCAT('Zone : ', z.ZoneName, ' | Biome : ', b.BiomeName) AS 'Zone et biome' 
FROM Monsters m
INNER JOIN Zones z
ON m.ZoneId = z.ZoneId
INNER JOIN Biomes b
ON z.BiomeId = b.BiomeId
INNER JOIN Drops d
ON m.MonsterId= d.MonsterId
INNER JOIN Items i
ON d.ItemId = i.ItemId
INNER JOIN Rarities r
ON i.RaritityId = r.RaritityId
WHERE UPPER(z.ZoneName) LIKE '%CAMP%' 
AND UPPER(b.BiomeName) LIKE '%LAND%' 
AND i.RaritityId >= (SELECT r.RaritityId FROM Rarities r WHERE r.RaritityId = 2)
ORDER BY m.MonsterName ASC

-- 4 tous les item avec ' de ' dans leur nom, leur num�ro d'item et leur raret�

SELECT i.ItemName AS "Nom de l'item", SUM(i.ItemId)/10 AS "Num�ro de l'item", REPLACE(i.RaritityId, i.RaritityId, r.RaritityName) AS 'Raret�'
FROM Items i
LEFT JOIN Rarities r
ON i.RaritityId = r.RaritityId
WHERE UPPER(i.ItemName) LIKE '% DE %'
GROUP BY i.ItemId, i.ItemName, i.RaritityId, r.RaritityName
ORDER BY "Raret�" DESC

-- 5 am�lioration des stat de 3% des monstre de niveau sup�rieur � 100 (des boss ou mosntre �lite)

DECLARE @BUFF FLOAT;
SET @BUFF = 1.03;

SELECT m.MonsterName AS 'Nom du monstre', m.MonsterHealth AS 'Vie avant buff', CONVERT(INT, (m.MonsterHealth*@BUFF)) AS 'Vie Apr�s Buff', 
m.MonsterArmor AS 'Armure avant buff', CONVERT(INT, (m.MonsterArmor*@BUFF)) AS 'Armure Apr�s Buff', 
m.MonsterDamage AS 'D�g�ts avant buff',CONVERT(INT, (m.MonsterDamage*@BUFF)) AS 'D�g�ts Apr�s Buff'
FROM Monsters m
WHERE m.MonsterLevel > 100
GROUP BY m.MonsterName, m.MonsterHealth, m.MonsterArmor, m.MonsterDamage
ORDER BY m.MonsterHealth, m.MonsterArmor, m.MonsterDamage  DESC

-- 6 récupération de tout les items d'un joueur

SET @ID = 8

SELECT p.PlayerName, p.PlayerLevel, i.ItemName, i.ItemLevel, r.RaritityName, i.ItemHealthStat, i.ItemArmorStat, i.ItemDamageStat FROM Equipments as e
INNER JOIN Items as i ON i.ItemId = e.ItemId
INNER JOIN Rarities as r ON r.RaritityId = i.RaritityId
INNER JOIN Players as p ON p.PlayerId = e.PlayerId
WHERE e.PlayerId = @ID