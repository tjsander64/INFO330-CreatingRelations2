-- separate out split_abilities again, but clean up table a bit
CREATE TABLE IF NOT EXISTS abilities AS
	SELECT name, split_abilities as abilities 
	FROM raw_pokemon;

-- create flavortext table linking names to titles
Create TABLE IF NOT EXISTS epithets AS 
    SELECT DISTINCT name, classification
    FROM raw_pokemon;

-- create new table linking names to types to their resistances
CREATE TABLE IF NOT EXISTS resistances AS
    SELECT DISTINCT name, type1, type2, against_bug, against_dark, against_dragon, against_electric,
                 against_fairy, against_fight, against_fire, against_flying, against_ghost,
                 against_grass, against_ground, against_ice, against_normal,
                 against_poison, against_psychic, against_rock, against_steel,
                 against_water
    FROM raw_pokemon; 

-- create new table with various physical stats
CREATE TABLE IF NOT EXISTS phys_stats AS
    SELECT DISTINCT name, hp, attack, sp_attack, defense, sp_defense, speed,
                 height_m, weight_kg
    FROM raw_pokemon;


-- create subtable with all legendary pokemon
CREATE TABLE IF NOT EXISTS legendaries AS 
    SELECT DISTINCT name, pokedex_number, type1, type2, generation
    FROM raw_pokemon
    WHERE is_legendary = 1;

-- create table with misc pokemon care information
CREATE TABLE IF NOT EXISTS care_info AS 
    SELECT DISTINCT name, pokedex_number, base_egg_steps, base_happiness,
                    capture_rate, experience_growth, percentage_male
    FROM raw_pokemon;

-- create table linking name to pokemon ID's
CREATE TABLE IF NOT EXISTS pokedex_nums AS
    SELECT name, pokedex_number 
    FROM care_info;

-- remove redundant pokedex_number from care_info
CREATE TABLE IF NOT EXISTS caring_info AS
    SELECT name, base_egg_steps, base_happiness, capture_rate,
                experience_growth, percentage_male
    FROM care_info;

DROP TABLE care_info;

ALTER TABLE caring_info RENAME TO care_info;


-- I tried for like 2 hours to figure out adding actual fk constraints and table linkages, but kept hitting the "foreign key mismatch" error. 
-- The way I was trying to do it was by creating new tables with the same columns but also adding constraints, then copying the data over from 
-- the unconstrained tables - I'm wondering how you actually do it; ideally there'd be official constraints identifying, for example, care_info(name)
-- as a fk for pokedex_number(name), epithets(name), etc. 