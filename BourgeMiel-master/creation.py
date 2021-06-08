import math
from os import stat
from faker import Faker
from math import floor
import random
import time

nbrMonstre = 1
nbrItem = 1
nbrPlayer = 1
levelItems = []


def generate_data(table, *args):
    return f"INSERT INTO {table} VALUES ({', '.join([str(arg) for arg in args])})"


def stringify(text):
    return f"'{text}'"


def getRarityLevel(rarity):
    if rarity == "Commun":
        return random.randint(1, 20)
    elif rarity == "Rare":
        return random.randint(10, 40)
    elif rarity == "Epique":
        return random.randint(20, 60)
    elif rarity == "Légendaire":
        return random.randint(30, 80)
    elif rarity == "Unique":
        return random.randint(40, 100)


biomes = [
    "Alps",
    "Arctic",
    "Badlands",
    "Bamboo Forest",
    "Bayou",
    "Birch Forest",
    "Bog",
    "Boneyard",
    "Boreal Forest",
    "Brushland",
    "Canyon",
    "Chaparral",
    "Cherry Blossom Grove",
    "Coniferous Forest",
    "Corrupted Sands",
    "Crag",
    "Dead Forest",
    "Deadlands",
    "Dead Swamp",
    "Deciduous Forest",
    "Dunes",
    "Fen",
    "Field",
    "Frost Forest",
    "Fungi Forest",
    "Flower Island",
    "Glacier",
    "Grassland",
    "Gravel Beach",
    "Grove",
    "Heathland",
    "Highland",
    "Hot Springs",
    "Icy Hills",
    "Jade Cliffs",
    "Lush Desert",
    "Lush Swamp",
    "Mangrove",
    "Maple Woods",
    "Marsh",
    "Meadow",
    "Mesa",
    "Moor",
    "Mountain",
    "Mystic Grove",
    "Oasis",
    "Ominous Woods",
    "Orchard",
    "Origin Island",
    "Outback",
    "Pasture",
    "Phantasmagoric Inferno",
    "Polar",
    "Prairie",
    "Promised Land",
    "Quagmire",
    "Rainforest",
    "Redwood Forest",
    "Sacred Springs",
    "Savanna",
    "Scrubland",
    "Seasonal Forest",
    "Shrubland",
    "Shield",
    "Sludgepit",
    "Snowy Coniferous Forest",
    "Snowy Dead Forest",
    "Spruce Woods",
    "Steppe",
    "Temperate Rainforest",
    "Thicket",
    "Timber",
    "Tropical Rainforest",
    "Tropics",
    "Tundra",
    "Undergarden",
    "Volcanic Island",
    "Wasteland",
    "Wetland",
    "Woodland",
]
zones = [
    "Le Repaire du Lion de Spectre",
    "Camp Clemency",
    "Mont Tragédie",
    "Les Bois de la Terreur",
    "Les Bois de Serpent",
    "Forêt de la Bousier",
    "Saut de Manteau du Roi",
    "Le Canyon Vide",
    "Les Abysses d-Aigle",
    "Le Repaire du Lion Étrange",
    "Les Tunnels du Moine Mythique",
    "Camp Synthesis",
    "Camp Zeal",
    "Le Temple d-oagi",
    "Les Terres d-Étoiles",
    "Bois de l-Angoulliers",
    "Les Pâturages du Saule Blanc",
    "Camp Venom",
    "Les Volcans Rouges",
    "Les Monts Monstres",
    "Le Pic de la Dillon",
    "Le Sanctuaire du Toubéliard",
    "Les Grottes du Narrac",
    "Les Cavités de la Marigueux",
    "Le Creux Pétilant",
    "Les Gouffres de Lumière",
    "Le Dédale du Loup Inconnu",
    "Les Cryptes Hurlantes",
    "Le Donjon d-Arrogance",
    "Camp Umbrage",
    "Camp Misfortune",
    "Camp Thunderclap",
    "La Forêt Brillante",
    "Les Donjons d-Arrogance",
    "Le Dédale de Pénombre",
    "Camp Pedestal",
    "Le Panthéon de giclous",
    "Les Pâturages aux Grenouilles Pacifiques",
    "Le Champ aux Aigles des Neiges",
    "Les Terres des Chevaux Sauvages",
    "Les Oubliettes de la Montagne de Feu",
    "Le Labyrinthe Flottant",
    "Les Catacombes du Dragon Occulte",
    "Les Cavernes de l-Empereur Argenté",
    "Le Labyrinthe du Gobelin Argenté",
    "Camp Pedestal",
    "Le Monastère du Solstice",
    "Forêt de la Vingueux",
    "Le Fjord du Montaulimar",
    "Le Mur de Gregnan",
    "Les Rochers Érodés",
    "La Vallée aux Chauve-Souris Alpines",
    "Les Plaines Luxuriantes",
    "Les Sanctuaires Ardents",
    "Le Verger de la Crique",
    "Les Prairies de la Soilun",
    "Cascades Croissantes",
    "La Catacombe de la Légion Disparue",
    "Les Donjons Éteints",
    "Camp Brown Bear",
    "Mont Tempête",
    "La Falaise Nébuleuse",
    "Le Mur Cassé",
    "Les Canyons Macabres",
    "Les Cavernes du Cologueux",
    "La Grotte Dense",
    "Les Tunnels de Cauchemar",
    "Camp Resistance",
    "Camp Liberty",
    "Les Collines Rocheuses",
    "Le Champ de Panier de Myrtilles",
    "Le Pré de la Cascade",
    "Cascade du Mauyonne",
    "Les Cavernes des Mammouths",
    "Les Abris de Sauppe",
    "Les Donjons de Diamant",
    "La Caverne Pourrie",
    "Le Donjon Éternel",
    "La Catacombe de Culte Caché",
    "La Cave du Cavalier Baissé",
    "Camp Sanctuary",
    "Camp Despair",
    "La Cathédrale de Tradition",
    "Le Terrier de l-Occulte Fou",
    "Camp Prohibition",
    "Grande Cascade de Rubis",
    "Forêt de la Coltoise",
    "Forêt de Montautou",
    "Cascades du Dragon",
    "Pertes de Branche Unique",
    "Forêt du Bourault",
    "Camp Apathy",
    "Camp Snowflake",
    "Le Mont Majestueux",
    "Les Pitons de la Montlimar",
    "Le Domaine Fantaisie",
    "Les Jardins Émeraudes",
    "La Savane d-Orlogne",
    "Les Caves d-Oracle de Deuil",
    "Les Tunnels Ondulants",
    "Les Cryptes Éternelles",
    "Camp Alpha",
    "Le Temple d-Honneur",
    "La Forêt d-Onyx",
    "Les Bois de Saules",
    "Les Bois des Chagrins",
    "Les Donjons Étroits",
    "Le Tunnel Stérile",
    "Camp Wild Card",
    "Camp Phoenix",
    "Le Sommet de l-Orlet",
    "Les Cavités du Pumart",
    "Les Sanctuaires des Gociennes",
]
monstres = [
    "Dragon",
    "Diablotin",
    "Dryade",
    "Ent",
    "Fée",
    "Sirène",
    "Lamia",
    "Nain",
    "Goule",
    "Gnome",
    "Gobelin",
    "Golem",
    "Harpie",
    "Troll",
    "Ogre",
    "Slime",
    "Loup",
    "Orque",
    "Valkyrie",
    "Loup_Garou",
    "Démons",
    "Elf",
    "Squelette",
    "Licorne",
    "Basilic",
    "Bouftou",
    "Anges",
    "Bandits",
    "Centaure",
    "Griffon",
    "Minotaure",
    "Yéti",
    "Géant",
]
rarities = ["Commun", "Rare", "Epique", "Légendaire", "Unique"]
items = [
    "Pain",
    "Pomme",
    "Potion de soin",
    "Potion de mana",
    "Ortie",
    "Blé",
    "Orge",
    "Avoine",
    "Champignon",
    "Frène",
    "Chène",
    "Orme",
    "Fer",
    "Charbon",
    "Or",
    "Rubis",
    "Diamant",
    "Saphir",
    "Emeraude",
    "Goujon",
    "Crevette",
    "Anguille",
    "Carpe",
    "Moule",
    "Viande de Lapin",
    "Viande de Mouton",
    "Morceau de Slime",
    "Ecaille de dragon",
    "Griffe de dragon",
    "Cerveau de zombie",
    "Paires d-ailes de fée",
    "Oeil de cyclope",
    "Plume de phoenix",
    "Téton de sirène",
    "Bouclier",
    "Epée à une main",
    "Epée à deux main",
    "Lance",
    "Arc",
    "Tromblon",
    "Hache à une main",
    "Hache à deux main",
    "Flêche",
    "Arbalète",
    "Baguette Magique",
    "Bâton Magique",
    "String d-Orc",
    "Casque",
    "Plastron",
    "Gants",
    "Jambières",
    "Bottes",
    "Amulette",
    "Gantelets",
    "Anneau",
]

fake = Faker(["fr_FR"])
start = time.time()
with open("Inserts.sql", "w", encoding="utf-8") as scriptBdd:
    scriptBdd.write("GO\nUSE BourgeMiel\nGO")
    scriptBdd.write("\n")
    id = 1
    for _, rarity in enumerate(rarities):
        scriptBdd.write(generate_data("Rarities", stringify(rarity)))
        scriptBdd.write("\n")
        for _, item in enumerate(items):
            level = getRarityLevel(rarity)
            scriptBdd.write(
                generate_data(
                    "Items",
                    stringify(item),
                    level,
                    id,
                    math.floor(
                        (getRarityLevel(rarity) * (3 / ((len(rarities) + 1) - id)))
                    )
                    + (2 * level),
                    math.floor(
                        (getRarityLevel(rarity) * (3 / ((len(rarities) + 1) - id)))
                    )
                    + (2 * level),
                    math.floor(
                        (getRarityLevel(rarity) * (3 / ((len(rarities) + 1) - id)))
                    )
                    + (2 * level),
                )
            )
            levelItems.append(level)
            scriptBdd.write("\n")
            nbrItem += 1
        id += 1
    scriptBdd.write("\n")

    for _, biome in enumerate(biomes):
        scriptBdd.write(generate_data("Biomes", stringify(biome)))
        scriptBdd.write("\n")
    scriptBdd.write("\n")

    id = 1
    for _, zone in enumerate(zones):
        level = random.randint(1, 100)
        scriptBdd.write(
            generate_data(
                "Zones",
                stringify(zone),
                level,
                random.random() * 1000,
                random.randint(1, len(biomes)),
            )
        )
        scriptBdd.write("\n")
        for _ in range(random.randint(5, 20)):
            monstreLevel = level + random.randint(-5, 5)
            if monstreLevel < 1:
                monstreLevel = 1
            scriptBdd.write(
                generate_data(
                    "Monsters",
                    stringify(random.choice(monstres)),
                    monstreLevel,
                    id,
                    random.randint(1, 100) + 15 * monstreLevel,
                    random.randint(1, 100) + 15 * monstreLevel,
                    random.randint(1, 100) + 15 * monstreLevel,
                )
            )
            scriptBdd.write("\n")
            itemList = []
            for _ in range(random.randint(0, 15)):
                itemId = random.randint(1, nbrItem - 1) * 10
                while itemId in itemList:
                    itemId = random.randint(1, nbrItem - 1) * 10
                itemList.append(itemId)
                scriptBdd.write(generate_data("Drops", itemId, nbrMonstre))
                scriptBdd.write("\n")
            nbrMonstre += 1
        id += 1
    scriptBdd.write("\n")

    for _ in range(500):
        name = fake.name().split(" ")
        pseudo = name[0][0] + name[1][1:]
        level = random.randint(1, 100)
        scriptBdd.write(
            generate_data(
                "Players",
                stringify(pseudo),
                level,
                random.randint(1, 250) + 20 * level,
                random.randint(1, 250) + 20 * level,
                random.randint(1, 250) + 20 * level,
            )
        )
        scriptBdd.write("\n")
        itemList = []

        for _ in range(random.randint(1, 8)):
            itemId = random.randint(1, nbrItem - 1) * 10
            counter = 0
            while itemId in itemList or levelItems[itemId // 10 - 1] > level:
                itemId = random.randint(1, nbrItem - 1) * 10
                counter += 1
                if counter > 25:
                    break
            if counter > 25:
                break
            itemList.append(itemId)
            scriptBdd.write(generate_data("Equipments", itemId, nbrPlayer))
            scriptBdd.write("\n")
        nbrPlayer += 1
print(time.time() - start)
