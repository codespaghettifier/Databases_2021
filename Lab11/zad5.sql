
CREATE TABLE lab11.osoba (
    id int,
    imie varchar(255),
    nazwisko varchar(255),
    adres varchar(255)
);

CREATE OR REPLACE FUNCTION lab11.f1_osoba(i int )
RETURNS SETOF varchar(255) AS
$$
    SELECT uczestnik.nazwisko FROM lab11.uczestnik WHERE uczestnik.id_uczestnik = i;
$$
LANGUAGE SQL; 
