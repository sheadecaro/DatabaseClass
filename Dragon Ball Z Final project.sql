-- Race Table
CREATE TABLE Race (
    race_id SERIAL PRIMARY KEY,
    race_name TEXT NOT NULL UNIQUE
);

-- Inserting into Race
INSERT INTO Race (race_name) VALUES
('Saiyan'),
('Namekian'),
('Human'),
('Android'),
('Majin');

select *
from Race;

-- Planet Table
CREATE TABLE Planet (
    planet_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    galaxy TEXT
);

-- Inserting into Planet
INSERT INTO Planet (name, galaxy) VALUES
('Vegeta', 'Unknown'),
('Namek', 'Unknown'),
('Earth', 'Milky Way'),
('Other World', NULL),
('Cell Games Arena', 'Milky Way');

select *
from Planet;

-- Alignment Table
CREATE TABLE Alignment (
    alignment_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Inserting into Alignment
INSERT INTO Alignment (name) VALUES
('Good'),
('Evil'),
('Neutral');

Select *
from Alignment;

-- Character Table
CREATE TABLE Character (
    character_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    race_id INT REFERENCES Race(race_id),
    home_planet_id INT REFERENCES Planet(planet_id),
    alignment_id INT REFERENCES Alignment(alignment_id),
    date_of_birth DATE,
    is_alive BOOLEAN DEFAULT TRUE
);

-- Inserting into Character
INSERT INTO Character (name, race_id, home_planet_id, alignment_id, date_of_birth, is_alive) VALUES
('Goku', 1, 1, 1, '1984-05-09', TRUE),
('Vegeta', 1, 1, 2, '1984-04-02', TRUE),
('Piccolo', 2, 2, 1, '1984-05-09', TRUE),
('Gohan', 1, 3, 1, '1989-05-05', TRUE),
('Frieza', NULL, NULL, 2, NULL, FALSE),
('Cell', 4, NULL, 2, NULL, FALSE),
('Majin Buu', 5, NULL, 2, NULL, FALSE),
('Krillin', 3, 3, 1, NULL, TRUE),
('Bulma', 3, 3, 1, '1985-08-18', TRUE),
('Mr. Satan', 3, 3, 1, NULL, TRUE),
('Alan Labouseur', 3, 3, 1, '1912-06-23', FALSE);  -- Inserting Alan! sorry i killed you

INSERT INTO Character (name, race_id, home_planet_id, alignment_id, date_of_birth, is_alive) VALUES
('Vegito', 1, 1, 1, NULL, TRUE);

select *
from Character;

-- TechniqueType Table
CREATE TABLE TechniqueType (
    technique_type_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Inserting into TechniqueType
INSERT INTO TechniqueType (name) VALUES
('Energy Projection'),
('Melee Attack'),
('Support'),
('Transformation');

select *
from TechniqueType;

-- Technique Table
CREATE TABLE Technique (
    technique_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    technique_type_id INT REFERENCES TechniqueType(technique_type_id),
    energy_cost INT CHECK (energy_cost >= 0),
    cooldown_time INT CHECK (cooldown_time >= 0),
    range TEXT CHECK (range IN ('short', 'mid', 'long'))
);

-- Inserting into Technique
INSERT INTO Technique (technique_id, name, description, technique_type_id, energy_cost, cooldown_time, range) VALUES
(1000111, 'Kamehameha', 'A powerful energy beam attack.', 1, 50, 2, 'long'),
(1000112, 'Galick Gun', 'Vegetas signature energy wave.', 1, 45, 3, 'long'),
(1000113, 'Special Beam Cannon', 'A drilling energy beam attack.', 1, 60, 5, 'mid'),
(1000114, 'Masenko', 'A rapid fire energy beam attack.', 1, 30, 1, 'mid'),
(1000115, 'Spirit Bomb', 'An energy sphere attack.', 1, 100, 10, 'long'),
(1000116, 'Dragon Fist', 'A powerful melee attack.', 2, 40, 4, 'short'),
(1000117,'Instant Transmission', 'The ability to teleport.', 3, 20, 0, 'short'),
(1000118, 'Fusion Dance', 'A dance to fuse two characters.', 3, 0, 30, 'short');

select *
from Technique;

-- CharacterTechnique Table
CREATE TABLE CharacterTechnique (
    character_id INT REFERENCES Character(character_id),
    technique_id INT REFERENCES Technique(technique_id),
    first_used_date DATE,
    mastery_level TEXT CHECK (mastery_level IN ('beginner', 'intermediate', 'mastered')),
    PRIMARY KEY (character_id, technique_id)
);

select *
from CharacterTechnique;

-- Inserting into CharacterTechnique
INSERT INTO CharacterTechnique (character_id, technique_id, first_used_date, mastery_level) VALUES
(1, 1000111, '1986-01-01', 'mastered'),  -- Goku - Kamehameha
(2, 1000112, '1986-01-01', 'mastered'),  -- Vegeta - Galick Gun
(3, 1000113, '1986-01-01', 'mastered'),  -- Piccolo - Special Beam Cannon
(1, 1000115, '1987-01-01', 'mastered'),  -- Goku - Spirit Bomb
(1, 1000117, '1987-04-01', 'mastered'),  -- Goku - Instant Transmission
(4, 1000111, '1990-01-01', 'intermediate'), -- Gohan - Kamehameha
(4, 1000114, '1990-01-01', 'mastered'),  -- Gohan - Masenko
(1, 1000116, '1992-05-01', 'mastered'),  -- Goku - Dragon Fist
(1, 1000118, '1995-01-01', 'mastered'),  -- Goku & Vegeta - Fusion Dance
(2, 1000111, '1995-01-01', 'mastered');

-- Transformation Table
CREATE TABLE Transformation (
    transformation_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT
);

-- Inserting into Transformation
INSERT INTO Transformation (name, description) VALUES
('Super Saiyan', 'The first and most iconic Saiyan transformation.'),
('Super Saiyan 2', 'An advanced version of Super Saiyan.'),
('Super Saiyan 3', 'A further advanced and powerful form.'),
('Super Saiyan God', 'A divine transformation.'),
('Super Saiyan Blue', 'A combination of Super Saiyan and Super Saiyan God.');

select *
from Transformation;

-- TransformationRequirement Table
CREATE TABLE TransformationRequirement (
    transformation_id INT PRIMARY KEY REFERENCES Transformation(transformation_id),
    min_power_level INT CHECK (min_power_level >= 0),
    required_emotion TEXT
);


-- Inserting into TransformationRequirement
INSERT INTO TransformationRequirement (transformation_id, min_power_level, required_emotion) VALUES
(1, 50000, 'Rage'),
(2, 1000000, 'Intense Training'),
(3, 4000000000, 'Intense Training'),
(4, 10000000000, 'Divine Ki'),
(5, 100000000000, 'Divine Ki and Super Saiyan');

ALTER TABLE TransformationRequirement
ALTER COLUMN min_power_level TYPE BIGINT;

select *
from TransformationRequirement;

-- CharacterTransformation Table
CREATE TABLE CharacterTransformation (
    character_id INT REFERENCES Character(character_id),
    transformation_id INT REFERENCES Transformation(transformation_id),
    date_achieved DATE,
    PRIMARY KEY (character_id, transformation_id)
);

-- Inserting into CharacterTransformation
INSERT INTO CharacterTransformation (character_id, transformation_id, date_achieved) VALUES
(1, 1, '1989-01-01'),   -- Goku - Super Saiyan
(2, 1, '1990-01-01'),   -- Vegeta - Super Saiyan
(1, 2, '1992-01-01'),   -- Goku - Super Saiyan 2
(4, 2, '1993-01-01'),   -- Gohan - Super Saiyan 2
(1, 3, '1995-01-01'),   -- Goku - Super Saiyan 3
(1, 4, '2015-01-01'),   -- Goku - Super Saiyan God
(1, 5, '2015-02-01'),   -- Goku - Super Saiyan Blue
(2, 5, '2015-02-01'),   -- Vegeta - Super Saiyan Blue
(2, 4, '2015-02-01');   -- Vegeta - Super Saiyan God

select *
from CharacterTransformation;

-- Mentorship Table
CREATE TABLE Mentorship (
    mentor_id INT REFERENCES Character(character_id),
    student_id INT REFERENCES Character(character_id),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (mentor_id, student_id)
);

-- Inserting into Mentorship
INSERT INTO Mentorship (mentor_id, student_id, start_date, end_date) VALUES
(3, 1, '1984-01-01', '1989-01-01'),  -- Piccolo mentored Goku
(1, 4, '1990-01-01', '1995-01-01'),  -- Goku mentored Gohan
(1, 8, '1984-01-01', '1985-01-01');  -- Goku mentored Krillin

select *
from Mentorship;

-- PowerLevelHistory Table
CREATE TABLE PowerLevelHistory (
    character_id INT REFERENCES Character(character_id),
    date DATE,
    power_level INT CHECK (power_level >= 0),
    PRIMARY KEY (character_id, date)
);

ALTER TABLE PowerLevelHistory
ALTER COLUMN power_level TYPE BIGINT;

-- Inserting into PowerLevelHistory
INSERT INTO PowerLevelHistory (character_id, date, power_level) VALUES
(1, '1984-01-01', 416),    -- Goku
(1, '1989-01-01', 150000000),
(1, '1995-01-01', 3000000000),
(2, '1984-01-01', 18000),    -- Vegeta
(2, '1990-01-01', 120000000),
(4, '1989-01-01', 1000),     -- Gohan
(4, '1993-01-01', 800000000);

-- Krillin's power level history
INSERT INTO PowerLevelHistory (character_id, date, power_level) VALUES
(8, '1984-01-01', 100),   -- Early Dragon Ball
(8, '1989-01-01', 13000),  -- Frieza Saga
(8, '1993-01-01', 75000);  -- Cell Saga

-- Bulma's power level history (Bulma's power level is relatively consistent and very low)
INSERT INTO PowerLevelHistory (character_id, date, power_level) VALUES
(9, '1984-01-01', 5),
(9, '1989-01-01', 5),
(9, '1993-01-01', 5);

-- Piccolo's power level history
INSERT INTO PowerLevelHistory (character_id, date, power_level) VALUES
(3, '1984-01-01', 408);   -- Early Dragon Ball Z
(3, '1989-01-01', 1000000;  -- Frieza Saga
(3, '1993-01-01', 150000000); -- Cell Saga

select *
from PowerLevelHistory;

-- Team Table
CREATE TABLE Team (
    team_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT
);

-- Inserting into Team
INSERT INTO Team (name, description) VALUES
('Z Fighters', 'The main group of heroes protecting Earth.'),
('Ginyu Force', 'Friezas elite fighting squad.'),
('Universe 7 Team', 'Team for the Tournament of Power.');

Select *
from Team;

-- CharacterTeam Table
CREATE TABLE CharacterTeam (
    character_id INT REFERENCES Character(character_id),
    team_id INT REFERENCES Team(team_id),
    join_date DATE,
    leave_date DATE,
    PRIMARY KEY (character_id, team_id)
);

-- Inserting into CharacterTeam
INSERT INTO CharacterTeam (character_id, team_id, join_date, leave_date) VALUES
(1, 1, '1986-01-01', NULL),   -- Goku - Z Fighters
(2, 1, '1987-01-01', NULL),   -- Vegeta - Z Fighters
(3, 1, '1984-01-01', NULL),   -- Piccolo - Z Fighters
(4, 1, '1989-01-01', NULL),   -- Gohan - Z Fighters
(8, 1, '1984-01-01', NULL),   -- Krillin - Z Fighters
(9, 1, '1986-01-01', NULL);   -- Bulma - Z Fighters

-- Fusion Table
CREATE TABLE Fusion (
    fusion_id SERIAL PRIMARY KEY,
    character_1_id INT REFERENCES Character(character_id),
    character_2_id INT REFERENCES Character(character_id),
    fused_character_id INT REFERENCES Character(character_id),
    method TEXT,
    date DATE
);

INSERT INTO Fusion (character_1_id, character_2_id, fused_character_id, method, date) VALUES
(1, 2, NULL, 'Fusion Dance', '1995-01-01'),  -- Goku & Vegeta (Failed)
(1, 2, NULL, 'Potara Earrings', '1995-01-01'), -- Goku & Vegeta (Failed)
(1, 2, 12, 'Fusion Dance', '1995-01-01');  -- Goku & Vegeta = Vegito

select *
from Fusion;


--------------VIEWS------------------

--CHARACTER POWER LEVELS--
CREATE VIEW CharacterPowerLevels AS
SELECT
    c.name AS character_name,
    plh.power_level AS current_power_level
FROM
    Character c
JOIN
    PowerLevelHistory plh ON c.character_id = plh.character_id
WHERE
    plh.date = (SELECT MAX(date) FROM PowerLevelHistory WHERE character_id = c.character_id);
--
select * 
from CharacterPowerLevels;
--


--SAIYAN TRANSFORMATIONS--
CREATE VIEW SaiyanTransformations AS
SELECT
    c.name AS saiyan_name,
    t.name AS transformation_name,
    ct.date_achieved AS transformation_date
FROM
    Character c
JOIN
    CharacterTransformation ct ON c.character_id = ct.character_id
JOIN
    Transformation t ON ct.transformation_id = t.transformation_id
WHERE
    c.race_id = (SELECT race_id FROM Race WHERE race_name = 'Saiyan');
--
select *
from SaiyanTransformations;
--


--TECHNIQUE USAGE--
CREATE VIEW TechniqueUsage AS
SELECT
    c.name AS character_name,
    t.name AS technique_name
FROM
    Character c
JOIN
    CharacterTechnique ct ON c.character_id = ct.character_id
JOIN
    Technique t ON ct.technique_id = t.technique_id;
--	
select *
from TechniqueUsage;
--

----------REPORTS--------

--TECHNIQUE REPORT--
SELECT
    c.name AS character_name,
    t.name AS technique_name,
    tt.name AS technique_type,
    ct.mastery_level
FROM
    Character c
JOIN
    CharacterTechnique ct ON c.character_id = ct.character_id
JOIN
    Technique t ON ct.technique_id = t.technique_id
JOIN
    TechniqueType tt ON t.technique_type_id = tt.technique_type_id
ORDER BY
    c.name, t.name;

--MENTORSHIP REPORT--
SELECT
    c1.name AS mentor_name,
    c2.name AS student_name,
    m.start_date,
    m.end_date
FROM
    Mentorship m
JOIN
    Character c1 ON m.mentor_id = c1.character_id
JOIN
    Character c2 ON m.student_id = c2.character_id
ORDER BY
    mentor_name, student_name;


--AVERAGE POWER LEVEL BY RACE--
SELECT
    r.race_name,
    AVG(plh.power_level) AS average_power_level
FROM
    Character c
JOIN
    PowerLevelHistory plh ON c.character_id = plh.character_id
JOIN
    Race r ON c.race_id = r.race_id
WHERE plh.date = (SELECT MAX(date) FROM PowerLevelHistory WHERE character_id = c.character_id)
GROUP BY
    r.race_name
ORDER BY
    AVG(plh.power_level) DESC;

--------------STORED PROCEDURES----------------

--character transformations--
CREATE OR REPLACE FUNCTION GetTransformationsByCharacter (
    p_character_name TEXT
)
RETURNS TABLE (transformation_name TEXT, date_achieved DATE)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
    SELECT
        t.name,
        ct.date_achieved
    FROM
        Character c
    JOIN
        CharacterTransformation ct ON c.character_id = ct.character_id
    JOIN
        Transformation t ON ct.transformation_id = t.transformation_id
    WHERE
        c.name = p_character_name
    ORDER BY
        ct.date_achieved;
END;
$$;

-------
SELECT * 
FROM GetTransformationsByCharacter('Goku');
-------

------TRIGGERS-------

--no future birth dates--
CREATE OR REPLACE FUNCTION prevent_future_birthdate()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.date_of_birth > CURRENT_DATE THEN
        RAISE EXCEPTION 'Date of birth cannot be in the future';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER check_future_birthdate
    BEFORE INSERT OR UPDATE ON Character
    FOR EACH ROW
    EXECUTE PROCEDURE prevent_future_birthdate();

--test--
INSERT INTO Character (name, race_id, home_planet_id, alignment_id, date_of_birth)
VALUES ('TestCharacter2', 1, 1, 1, '2026-01-01');  -- Replace with valid race_id, etc.
--

--setting a default value for a character to be alive if no other value is input
CREATE OR REPLACE FUNCTION set_default_is_alive()
    RETURNS TRIGGER
    LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.is_alive IS NULL THEN
        NEW.is_alive := TRUE;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER default_character_alive
    BEFORE INSERT ON Character
    FOR EACH ROW
    EXECUTE PROCEDURE set_default_is_alive();

--test--
INSERT INTO Character (name, race_id, home_planet_id, alignment_id, date_of_birth)
VALUES ('TestDefaultAlive', 1, 1, 1, '2000-01-01');

SELECT name, is_alive FROM Character WHERE name = 'TestDefaultAlive';
--

----SECURITY-----

Create role researcher;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO researcher;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO researcher; --researchers need broad information on everything

Create role fighter;
GRANT SELECT ON Character TO fighter;
GRANT SELECT ON Race TO fighter;
GRANT SELECT ON Planet TO fighter;
GRANT SELECT ON Alignment TO fighter;
GRANT SELECT ON Technique TO fighter;
GRANT SELECT ON TechniqueType TO fighter;
GRANT SELECT ON CharacterTechnique TO fighter;
GRANT SELECT ON PowerLevelHistory TO fighter;
GRANT SELECT ON Transformation TO fighter;
GRANT SELECT ON CharacterTransformation TO fighter;
GRANT SELECT ON Team TO fighter;
GRANT SELECT ON CharacterTeam TO fighter; --fighters need to acces info on character info, techniques and also see power levels

REVOKE INSERT ON PowerLevelHistory FROM fighter;







