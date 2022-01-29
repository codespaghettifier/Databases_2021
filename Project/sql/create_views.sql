-- Zamówienia

CREATE VIEW "zamowienie" AS
SELECT zakup.nr_zamowienia, zakup.id_klient, zakup.id_kod_rabatowy, zakup.id_pracownik, zakup.data, SUM(produkt.cena_bazowa * zakup.ilosc) AS kwota
FROM db_project.zakup
JOIN db_project.produkt ON produkt.id_produkt = zakup.id_produkt
JOIN db_project.klient ON klient.id_klient = zakup.id_klient
GROUP BY zakup.nr_zamowienia, zakup.id_klient, zakup.id_kod_rabatowy, zakup.id_pracownik, zakup.data;


-- Łączna kwota uzielonych rabatów według kodu

CREATE VIEW "Łączna kwota uzielonych rabatów według kodu" AS
SELECT kod_rabatowy.kod, kod_rabatowy.stawka_procentowa, kod_rabatowy.kwota, SUM(kod_rabatowy.stawka_procentowa * 0.01 * produkt.cena_bazowa * zakup.ilosc + kod_rabatowy.kwota)
FROM db_project.kod_rabatowy
JOIN db_project.zakup ON zakup.id_kod_rabatowy = kod_rabatowy.id_kod_rabatowy
JOIN db_project.produkt ON produkt.id_produkt = zakup.id_produkt
GROUP BY kod_rabatowy.id_kod_rabatowy, kod_rabatowy.kod, kod_rabatowy.stawka_procentowa, kod_rabatowy.kwota
ORDER BY kod_rabatowy.kod;


-- Zamówienia o największej łącznej cenie przed podatkiem vat

CREATE VIEW "Zamówienia o największej łącznej kwocie przed vat" AS
SELECT zamowienie.nr_zamowienia, zamowienie.id_klient, klient.imie, klient.nazwisko, zamowienie.kwota
FROM zamowienie
JOIN db_project.klient ON klient.id_klient = zamowienie.id_klient
ORDER BY kwota DESC;


-- Pracownicy według największej sprzedaży

CREATE VIEW "Pracownicy według największej sprzedaży" AS
SELECT pracownik.id_pracownik, pracownik.imie, pracownik.nazwisko, SUM(zamowienie.kwota) AS suma_sprzedazy
FROM zamowienie
JOIN db_project.pracownik ON pracownik.id_pracownik = zamowienie.id_pracownik
GROUP BY pracownik.id_pracownik, pracownik.imie, pracownik.nazwisko
ORDER BY suma_sprzedazy DESC;


-- Produkty według wygenerowanego przychodu

CREATE VIEW "Produkty według wygenerowanego przychodu" AS
SELECT produkt.id_produkt, produkt.nazwa, SUM(zakup.ilosc * produkt.cena_bazowa) AS przychod
FROM db_project.produkt
JOIN db_project.zakup ON zakup.id_produkt = produkt.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa
ORDER BY przychod DESC;


-- Podatek do zaplacenia wegług stawki VAT

CREATE VIEW "Podatek do zaplacenia wegług stawki VAT" AS
SELECT produkt.stawka_vat, SUM(produkt.cena_bazowa * zakup.ilosc * produkt.stawka_vat) kwota_podatku
FROM db_project.zakup
JOIN db_project.produkt ON produkt.id_produkt = zakup.id_produkt
GROUP BY produkt.stawka_vat
ORDER BY produkt.stawka_vat;


-- Produkty do zamówienia ASAP (brak wystarczającej ilości w magazynie do wypełnienia zamówień z koszyków)

CREATE VIEW "Produkty do zamówienia ASAP" AS
SELECT produkt.id_produkt, produkt.nazwa, SUM(koszyk_produkt.ilosc) - stan_magazynowy.ilosc AS brakujaca_ilosc
FROM db_project.koszyk_produkt
JOIN db_project.produkt ON produkt.id_produkt = koszyk_produkt.id_produkt
LEFT JOIN db_project.stan_magazynowy ON stan_magazynowy.id_produkt = produkt.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa, stan_magazynowy.ilosc
HAVING SUM(koszyk_produkt.ilosc) - stan_magazynowy.ilosc > 0
ORDER BY brakujaca_ilosc DESC;
