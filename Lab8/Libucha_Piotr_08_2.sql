DROP SCHEMA lab08 CASCADE;
CREATE SCHEMA lab08;

CREATE SEQUENCE lab08.person_person_id_seq;

CREATE TABLE lab08.person (
                person_id INTEGER NOT NULL DEFAULT nextval('lab08.person_person_id_seq'),
                fname VARCHAR(20) NOT NULL,
                lname VARCHAR(20) NOT NULL,
                primary_group CHAR(1) NOT NULL,
                secondary_group CHAR(2) NOT NULL,
                CONSTRAINT person_pk PRIMARY KEY (person_id)
);

ALTER SEQUENCE lab08.person_person_id_seq OWNED BY lab08.person.person_id;

CREATE TABLE lab08.person_group ( name varchar(20), nc int ) ;  
INSERT INTO lab08.person_group VALUES ( 'DB', 2), ( 'C+', 3 ), ( 'PY', 4 ) ;

-- 1. Napisać wyzwalacz walidujący fname i lname w tabeli person, tylko litery, bez spacji i tabulatorów. W lname dopuszczalny znak - (myślnik, pauza).

-- ^[A-Z][a-z]*$ 
-- ^[A-Z][a-z]*(-?[a-z]*)*$

CREATE OR REPLACE FUNCTION lab08.validate_person ()
RETURNS TRIGGER AS 
$$ BEGIN
    IF NEW.fname !~ '^[A-Z][a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe imię';
    END IF;
    IF NEW.lname !~ '^[A-Z][a-z]*(-?[A-Z][a-z]*)*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe nazwisko';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

CREATE TRIGGER validate_person_trigger
    AFTER INSERT OR UPDATE ON lab08.person
    FOR EACH ROW EXECUTE PROCEDURE lab08.validate_person();


-- 2. Napisać wyzwalacz normalizujący fname i lname w tabeli person, fname i skladowe lname ( przy podwójnym nazwisku) powinny zaczynać się od dużej litery, reszta małe. Usuwamy spacje.

-- UPPER(LEFT(fname, 1)) + LOWER(RIGHT(fname, LENGTH(fname) - 1))

CREATE OR REPLACE FUNCTION lab08.normalize_person()
RETURNS TRIGGER AS 
$$ BEGIN
    NEW.fname := INITCAP(NEW.fname);
    NEW.lname := REPLACE(INITCAP(REPLACE(NEW.lname, '-', ' ')), ' ', '-');
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

CREATE TRIGGER normalize_person_trigger
    BEFORE INSERT OR UPDATE ON lab08.person
    FOR EACH ROW EXECUTE PROCEDURE lab08.normalize_person();

INSERT INTO lab08.person (lname, fname, primary_group, secondary_group ) VALUES
( 'Dyd', 'Ant', 'P', 'WY' ), 
( 'dyd', 'ant', 'P', 'WY' ),
( 'Dyd dyd', 'ant', 'P', 'WY' ), 
( 'dYD DYd', 'ANT', 'P', 'WY' ), 
( 'dYd DYd-dYD', 'ANT', 'P', 'WY' ); 

INSERT INTO lab08.person (lname, fname, primary_group, secondary_group ) VALUES
( 'Dyd', 'Ant', 'A', 'P' ), 
( 'dyd', 'ant', 'B', 'A' ),
( 'Dyd dyd', 'ant', 'C', 'B' ), 
( 'dYD DYd', 'ANT', 'A', 'C' ), 
( 'dYd DYd-dYD', 'ANT', 'A', 'B' ); 

-- 3. Napisać wyzwalacz aktualizujący tabelę zawierającą liczbę wszystkich osób w danej grupie. Uwzględnić insert, delete i update.

CREATE OR REPLACE FUNCTION lab08.update_person_group()
RETURNS TRIGGER AS 
$$ BEGIN
	DELETE FROM lab08.person_group;
	INSERT INTO lab08.person_group
	SELECT num.the_group AS "group", SUM(num.num_people) AS "number of people" FROM
	(SELECT person.primary_group AS the_group, COUNT(person.primary_group) AS num_people FROM lab08.person GROUP BY person.primary_group
	UNION
	SELECT person.secondary_group AS the_group, COUNT(person.secondary_group) AS num_people FROM lab08.person GROUP BY person.secondary_group) AS num
	GROUP BY num.the_group;
	RETURN NEW;
END $$ LANGUAGE 'plpgsql';

CREATE TRIGGER update_person_group_trigger
    AFTER INSERT OR UPDATE OR DELETE ON lab08.person
    EXECUTE PROCEDURE lab08.update_person_group();





