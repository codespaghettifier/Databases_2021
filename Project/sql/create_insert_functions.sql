CREATE OR REPLACE FUNCTION db_project.add_adres(miejscowosc varchar, kod_pocztowy varchar, ulica varchar, nr_budynku int)
RETURNS VOID AS
$$
	INSERT INTO db_project.adres (miejscowosc, kod_pocztowy, ulica, nr_budynku) VALUES
	(miejscowosc, kod_pocztowy, ulica, nr_budynku);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_dostawca(nazwa varchar, id_adres int)
RETURNS VOID AS
$$
	INSERT INTO db_project.dostawca (nazwa, id_adres) VALUES
	(nazwa, id_adres);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_klient(imie varchar, nazwisko varchar, id_adres int, email varchar, nr_telefonu varchar)
RETURNS VOID AS
$$
	INSERT INTO db_project.klient (imie, nazwisko, id_adres, email, nr_telefonu) VALUES
	(imie, nazwisko, id_adres, email, nr_telefonu);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_pracownik(imie varchar, nazwisko varchar, stanowisko varchar, id_adres int, email varchar, nr_telefonu varchar, nr_konta varchar)
RETURNS VOID AS
$$
	INSERT INTO db_project.pracownik (imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta) VALUES
	(imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_produkt(cena_bazowa float, stawka_vat float, nazwa varchar, id_dostawca int)
RETURNS VOID AS
$$
	INSERT INTO db_project.produkt (cena_bazowa, stawka_vat, nazwa, id_dostawca) VALUES
	(cena_bazowa, stawka_vat, nazwa, id_dostawca);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_stan_magazynowy(ilosc int, id_produkt int)
RETURNS VOID AS
$$
	INSERT INTO db_project.stan_magazynowy (ilosc, id_produkt) VALUES
	(ilosc, id_produkt);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_kod_rabatowy(stawka_procentowa float, kwota float, kod varchar, limit_uzyc int, wykorzystano int, id_pracownik int)
RETURNS VOID AS
$$
	INSERT INTO db_project.kod_rabatowy (stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik) VALUES
	(stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_koszyk(id_klient int)
RETURNS VOID AS
$$
	INSERT INTO db_project.koszyk (id_klient) VALUES
	(id_klient);
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_koszyk_produkt(id_klient_param int, id_produkt int, ilosc int)
RETURNS VOID AS
$$
    WITH koszyk AS (
        SELECT koszyk.id_koszyk AS id
        FROM db_project.koszyk
        WHERE koszyk.id_klient = id_klient_param
    )
	INSERT INTO db_project.koszyk_produkt (id_koszyk, id_produkt, ilosc) VALUES
	((SELECT id from koszyk), id_produkt, ilosc)
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION db_project.add_zakup(ilosc int, id_produkt int, id_klient int, id_kod_rabatowy int, nr_zamowienia int, id_pracownik int, data date)
RETURNS VOID AS
$$
	INSERT INTO db_project.zakup (ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data) VALUES
	(ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data);
$$
LANGUAGE SQL;

