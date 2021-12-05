-- 1. Utworzyć funkcję,  która dostarcza listę z nazwiskami, imionami i adresem email uczestników dla organizacji. 
-- Identyfikator organizacji jest argumentem funkcji.

CREATE OR REPLACE FUNCTION lab07.getStudentsFromOrganization(int)
RETURNS table(nazwisko text, imie text, email text) AS
$body$
    SELECT uczestnik.nazwisko, uczestnik.imie, uczestnik.email
    FROM lab07.uczestnik
    JOIN lab07.uczestnik_organizacja ON uczestnik_organizacja.id_uczestnik = uczestnik.id_uczestnik
    WHERE uczestnik_organizacja.id_organizacja = $1;
$body$
LANGUAGE SQL;

-- 2. Utworzyć funkcję,  która dostarcza ilość studentów dla kursów danego języka. Nazwa języka jest argumentem funkcji.

CREATE OR REPLACE FUNCTION lab07.getNumberOfStudentsOnCourse(text)
RETURNS bigint AS
$body$
    SELECT COUNT(uczest_kurs.id_uczest)
    FROM lab07.uczest_kurs
    JOIN lab07.kurs ON kurs.id_kurs = uczest_kurs.id_kurs
    JOIN lab07.kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
    WHERE kurs_opis.opis LIKE CONCAT('%', $1, '%');
$body$
LANGUAGE SQL;

-- 3. Utworzyć funkcję,  która dostarcza listę wykładowców prowadzących kursy dla zadanej organizacji. 
-- Argumentem funkcji jest adres strony np. www.uj.edu.pl.

CREATE OR REPLACE FUNCTION lab07.getLecutersFromOrganization(text)
RETURNS table(nazwisko text, imie text) AS
$body$
    SELECT wykladowca.nazwisko, wykladowca.imie
    FROM lab07.wykladowca
    JOIN lab07.uczestnik_organizacja ON uczestnik_organizacja.id_wykladowca = wykladowca.id_wykladowca
    JOIN lab07.organizacja ON organizacja.id_organizacja = uczestnik_organizacja.id_organizacja
    WHERE organizacja.strona_www = $1;
$body$
LANGUAGE SQL;

SELECT wykladowca.nazwisko, wykladowca.imie
FROM lab07.wykladowca
JOIN lab07.uczestnik_organizacja ON uczestnik_organizacja.id_wykladowca = wykladowca.id_wykladowca
JOIN lab07.organizacja ON organizacja.id_organizacja = uczestnik_organizacja.id_organizacja
WHERE organizacja.strona_www = 'www.agh.edu.pl';

-- 4. Utworzyć funkcję,  która zwraca napis ( string) którego zawartością jest lista. Wiersze listy zawierają  opis kursu, data rozpoczęcia, data zakończenia oddzielone średnikami. Każdy wiersz jest umieszczony w nawiasach () i oddzielony przecinkiem.

CREATE OR REPLACE FUNCTION lab07.getCoursesList()
RETURNS text AS
$body$
DECLARE
    course RECORD;
    list text;
BEGIN
    list := '';
    FOR course IN (
        SELECT kurs_opis.opis, kurs.data_rozpoczecia, kurs.data_zakonczenia
        FROM lab07.kurs
        JOIN lab07.kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs)
    LOOP
        list := list || '(' || course.opis || ';' || course.data_rozpoczecia || ';' || course.data_zakonczenia || '),';
    END LOOP;
    RETURN list;
END
$body$
LANGUAGE 'plpgsql';