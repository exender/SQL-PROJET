-- On check si la database existe

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'BourgeMiel')
  BEGIN
    CREATE DATABASE "BourgeMiel"
    END

GO
	USE BourgeMiel
GO

BEGIN TRAN

-- On check si les tables existes d�j�

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Rarities' and xtype='U')
BEGIN
    CREATE TABLE "Rarities"
	(RaritityId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	RaritityName VARCHAR(50) NOT NULL)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Biomes' and xtype='U')
BEGIN
    CREATE TABLE "Biomes"
	(BiomeId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	BiomeName VARCHAR(50) NOT NULL)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Zones' and xtype='U')
BEGIN
    CREATE TABLE "Zones"
	(ZoneId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	ZoneName VARCHAR(50) NOT NULL,
	ZoneLevel INT NOT NULL,
	ZoneSize FLOAT NOT NULL,
	BiomeId INT NOT NULL,
	FOREIGN KEY(BiomeId) REFERENCES "Biomes"(BiomeId))
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Monsters' and xtype='U')
BEGIN
    CREATE TABLE "Monsters"
	(MonsterId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MonsterName VARCHAR(50) NOT NULL,
	MonsterLevel INT NOT NULL,
	ZoneId INT NOT NULL,
	FOREIGN KEY(ZoneId) REFERENCES "Zones"(ZoneId),
	MonsterHealth INT NOT NULL,
	MonsterDamage INT NOT NULL,
	MonsterArmor INT NOT NULL)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Players' and xtype='U')
BEGIN
    CREATE TABLE "Players"
	(PlayerId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PlayerName VARCHAR(50) NOT NULL,
	PlayerLevel INT NOT NULL,
	PlayerHealth INT NOT NULL,
	PlayerDamage INT NOT NULL,
	PlayerArmor INT NOT NULL)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Items' and xtype='U')
BEGIN
	CREATE TABLE "Items"
	(ItemId INT NOT NULL IDENTITY(10,10) PRIMARY KEY,
	ItemName VARCHAR(50) NOT NULL,
	ItemLevel INT NOT NULL,
	RaritityId INT NOT NULL,
	FOREIGN KEY(RaritityId) REFERENCES "Rarities"(RaritityId),
	ItemHealthStat INT NOT NULL,
	ItemDamageStat INT NOT NULL,
	ItemArmorStat INT NULL)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Drops' and xtype='U')
BEGIN
	CREATE TABLE "Drops"
	(DropId INT NOT NULL IDENTITY(10,10) PRIMARY KEY,
	ItemId INT NOT NULL,
	FOREIGN KEY(ItemId) REFERENCES "Items"(ItemId),
	MonsterId INT NOT NULL,
	FOREIGN KEY(MonsterId) REFERENCES "Monsters"(MonsterId))
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Equipments' and xtype='U')
BEGIN
	CREATE TABLE "Equipments"
	(EquipmentId INT NOT NULL IDENTITY(100,100) PRIMARY KEY,
	ItemId INT NOT NULL,
	FOREIGN KEY(ItemId) REFERENCES "Items"(ItemId),
	PlayerId INT NOT NULL,
	FOREIGN KEY(PlayerId) REFERENCES "Players"(PlayerId))
END

COMMIT TRAN