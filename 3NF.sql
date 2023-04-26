-- below: splitting up resistances table into 2 tables, 1 linking pokemon to their
-- types, 1 linking type pairs to their resistances to each type

-- creating new table linking distinct type pairs to against_x values
CREATE TABLE IF NOT EXISTS types AS
    SELECT name, type1, type2 from resistances;

-- creating new table linking distinct type pairs to their type resistances
CREATE TABLE IF NOT EXISTS type_res AS
    SELECT DISTINCT type1, type2, against_bug, against_dark, against_dragon, against_electric,
                 against_fairy, against_fight, against_fire, against_flying, against_ghost,
                 against_grass, against_ground, against_ice, against_normal,
                 against_poison, against_psychic, against_rock, against_steel,
                 against_water
FROM resistances;

DROP TABLE resistances