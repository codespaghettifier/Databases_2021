-- Zad 1 Lista uczestników kursu niemieckiego lub angielskiego.

SELECT DISTINCT id_uczestnik, imie, nazwisko FROM lab05.uczestnik uczestnik
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.kurs kurs ON kurs.id_kurs = uczest_kurs.id_kurs
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
WHERE opis LIKE '%angielski%' OR opis LIKE '%niemiecki%';

-- Zad 2 Lista uczestników kursu niemieckiego i angielskiego.

SELECT DISTINCT id_uczestnik, imie, nazwisko FROM lab05.uczestnik uczestnik
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.kurs kurs ON kurs.id_kurs = uczest_kurs.id_kurs
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
WHERE opis LIKE '%angielski%'
INTERSECT
SELECT DISTINCT id_uczestnik, imie, nazwisko FROM lab05.uczestnik uczestnik
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.kurs kurs ON kurs.id_kurs = uczest_kurs.id_kurs
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
WHERE opis LIKE '%niemiecki%';

-- Zad 3 Lista uczestników kursu niemieckiego z wyłączeniem uczestników angielskiego.

SELECT DISTINCT id_uczestnik, imie, nazwisko FROM lab05.uczestnik uczestnik
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.kurs kurs ON kurs.id_kurs = uczest_kurs.id_kurs
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
WHERE opis LIKE '%niemiecki%'
EXCEPT
SELECT DISTINCT id_uczestnik, imie, nazwisko FROM lab05.uczestnik uczestnik
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.kurs kurs ON kurs.id_kurs = uczest_kurs.id_kurs
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs
WHERE opis LIKE '%angielski%';

-- Zad 4 Listy [literówka - lista] kursów dla których suma opłat jest większa od zadanej wartości.

CREATE VIEW lab05.view_suma_oplat_za_kurs (id_kurs, suma) AS
SELECT kurs.id_kurs, SUM(oplata) AS suma_oplat FROM lab05.kurs_opis kurs_opis
JOIN lab05.kurs kurs ON kurs.id_kurs = kurs_opis.id_kurs
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs
GROUP BY kurs.id_kurs;

SELECT opis, suma AS "suma oplat" FROM lab05.view_suma_oplat_za_kurs suma_oplat
JOIN lab05.kurs_opis kurs_opis ON kurs_opis.id_kurs = suma_oplat.id_kurs
WHERE suma_oplat.suma > (
    SELECT AVG(suma) FROM
    lab05.view_suma_oplat_za_kurs suma_oplat
);

-- Zad 5 Lista wykładowców o największej ilości studentów na kursach.

SELECT wykladowca.imie, wykladowca.nazwisko, ilosc_studentow.ilosc AS "ilość studentów na kursach" FROM lab05.wykladowca wykladowca
JOIN lab05.view_ilosc_studentow_wykladowcy ilosc_studentow ON ilosc_studentow.id_wykladowca = wykladowca.id_wykladowca
WHERE ilosc_studentow.ilosc = (SELECT MAX(ilosc_studentow.ilosc) FROM lab05.view_ilosc_studentow_wykladowcy ilosc_studentow);

CREATE VIEW lab05.view_ilosc_studentow_wykladowcy (id_wykladowca, ilosc) AS
SELECT wykladowca.id_wykladowca, COUNT(studenci_wykladowcy.id_uczest) AS ilosc FROM lab05.wykladowca
JOIN (SELECT DISTINCT wykladowca.id_wykladowca, uczest_kurs.id_uczest FROM lab05.wykladowca wykladowca
JOIN lab05.wykl_kurs wykl_kurs ON wykl_kurs.id_wykl = wykladowca.id_wykladowca
JOIN lab05.kurs kurs ON kurs.id_kurs = wykl_kurs.id_kurs
JOIN lab05.uczest_kurs uczest_kurs ON uczest_kurs.id_kurs = kurs.id_kurs) AS studenci_wykladowcy ON studenci_wykladowcy.id_wykladowca = wykladowca.id_wykladowca
GROUP BY wykladowca.id_wykladowca;

-- Zad 6 Lista studentów o maksymalnej ocenie dla danej organizacji.

SELECT DISTINCT uczestnik.imie, uczestnik.nazwisko, organizacja.nazwa  FROM lab05.uczestnik
JOIN lab05.uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik
JOIN lab05.uczestnik_organizacja ON uczestnik_organizacja.id_uczestnik = uczestnik.id_uczestnik
JOIN lab05.organizacja ON organizacja.id_organizacja = uczestnik_organizacja.id_organizacja
WHERE uczest_kurs.ocena = 5;




