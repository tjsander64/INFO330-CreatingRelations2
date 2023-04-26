.mode csv
.import pokemon.csv imported_pokemon_data

-- 1NF

-- creates temp table, w/ all abilities column values split apart
CREATE TABLE IF NOT EXISTS split_abilities AS
SELECT name, abilities,
    trim(abilities, '''[]''') AS abilities
FROM raw_pokemon,
    json_each('["' || replace(abilities, ',', '","') || '"]')
Where split_abilities<> '';
 

-- cleans up split_abilities values (trims brackets & single quotes)
UPDATE table split_abilities 
    set split_abilities = trim(split_abilities, '''[]''');

-- creates copy of original raw dataset w/ split abilities as new column
CREATE TABLE IF NOT EXISTS raw_pokemon_v2 AS
SELECT raw_pokemon.*, split_abilities.split_abilities
FROM raw_pokemon
JOIN split_abilities ON raw_pokemon.name = split_abilities.name;

-- delete separate split_abilities table
DROP TABLE split_abilities;

-- delete original raw dataset
DROP table raw_pokemon;

-- rename copy to original
ALTER TABLE raw_pokemon_v2 
RENAME TO raw_pokemon; 