-- Zad 1, 1
SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email FROM lab04.kurs KU JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs LEFT OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs LEFT OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl WHERE wk.id_kurs IS NULL;

-- wstawienie danych do testu
insert into lab04.kurs_opis ( id_kurs, opis ) values
( 13, 'Test kurs 1, zad 1'),
(14, 'Test kurs 2, zad 1') ;

insert into lab04.kurs ( id_kurs, id_grupa, id_nazwa, data_rozpoczecia,data_zakonczenia ) values
( 12, 1, 13, '2021-01-01','2021-03-31'),
(13, 1, 14, '2021-09-01', '2021-11-30') ; 

-- Zad 1, 2
SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email FROM lab04.kurs KU JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs RIGHT OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs RIGHT OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl WHERE ku.id_kurs IS NULL;

-- Zad 1, 3
SELECT  opis, data_rozpoczecia, data_zakonczenia, nazwisko, imie, email FROM lab04.kurs KU JOIN lab04.kurs_opis KO ON ku.id_nazwa = ko.id_kurs FULL OUTER JOIN lab04.wykl_kurs WK ON wk.id_kurs = ku.id_kurs FULL OUTER JOIN lab04.wykladowca WY ON WY.id_wykladowca = wk.id_wykl WHERE wk.id_kurs IS NULL OR ku.id_kurs IS NULL;


-- Zad 2
SELECT opis, data_rozpoczecia, data_zakonczenia, MAX(ocena) AS "maksymalna ocena" FROM lab04.uczest_kurs UK JOIN lab04.kurs KU ON uk.id_kurs = ku.id_kurs JOIN lab04.kurs_opis KO ON ku.id_kurs = ko.id_kurs GROUP BY ku.id_kurs, ko.opis;

SELECT opis, data_rozpoczecia, data_zakonczenia, MIN(ocena) AS "minimalna ocena" FROM lab04.uczest_kurs UK JOIN lab04.kurs KU ON uk.id_kurs = ku.id_kurs JOIN lab04.kurs_opis KO ON ku.id_kurs = ko.id_kurs GROUP BY ku.id_kurs, ko.opis;

SELECT opis, data_rozpoczecia, data_zakonczenia, AVG(ocena) AS "średnia ocen" FROM lab04.uczest_kurs UK JOIN lab04.kurs KU ON uk.id_kurs = ku.id_kurs JOIN lab04.kurs_opis KO ON ku.id_kurs = ko.id_kurs GROUP BY ku.id_kurs, ko.opis;


-- Zad 3
SELECT wy.imie, wy.nazwisko, wy.email, COUNT(id_uczestnik) AS "ilość uczestników" FROM lab04.wykladowca WY JOIN lab04.wykl_kurs WK ON wy.id_wykladowca = wk.id_wykl JOIN lab04.kurs KU ON wk.id_kurs = ku.id_kurs JOIN lab04.uczest_kurs UK ON ku.id_kurs = uk.id_kurs JOIN lab04.uczestnik UC ON uk.id_uczest = uc.id_uczestnik GROUP BY (wy.id_wykladowca) ORDER BY COUNT(id_uczestnik) DESC;

