CREATE SCHEMA db_project;


CREATE SEQUENCE db_project.adres_id_adres_seq;

CREATE TABLE db_project.adres (
                id_adres INTEGER NOT NULL DEFAULT nextval('db_project.adres_id_adres_seq'),
                miejscowosc VARCHAR NOT NULL,
                kod_pocztowy VARCHAR NOT NULL,
                nr_budynku INTEGER NOT NULL,
                ulica VARCHAR NOT NULL,
                CONSTRAINT id_adres PRIMARY KEY (id_adres)
);


ALTER SEQUENCE db_project.adres_id_adres_seq OWNED BY db_project.adres.id_adres;

CREATE SEQUENCE db_project.dostawca_id_dostawca_seq;

CREATE TABLE db_project.dostawca (
                id_dostawca INTEGER NOT NULL DEFAULT nextval('db_project.dostawca_id_dostawca_seq'),
                nazwa VARCHAR NOT NULL,
                id_adres INTEGER NOT NULL,
                CONSTRAINT id_dostawca PRIMARY KEY (id_dostawca)
);


ALTER SEQUENCE db_project.dostawca_id_dostawca_seq OWNED BY db_project.dostawca.id_dostawca;

CREATE SEQUENCE db_project.produkt_id_produkt_seq;

CREATE TABLE db_project.produkt (
                id_produkt INTEGER NOT NULL DEFAULT nextval('db_project.produkt_id_produkt_seq'),
                cena_bazowa NUMERIC NOT NULL,
                stawka_vat NUMERIC NOT NULL,
                nazwa VARCHAR NOT NULL,
                id_dostawca INTEGER NOT NULL,
                CONSTRAINT id_produkt PRIMARY KEY (id_produkt)
);


ALTER SEQUENCE db_project.produkt_id_produkt_seq OWNED BY db_project.produkt.id_produkt;

CREATE SEQUENCE db_project.stan_magazynowy_id_stan_magazynowy_seq;

CREATE TABLE db_project.stan_magazynowy (
                id_stan_magazynowy INTEGER NOT NULL DEFAULT nextval('db_project.stan_magazynowy_id_stan_magazynowy_seq'),
                ilosc INTEGER NOT NULL,
                id_produkt INTEGER NOT NULL,
                CONSTRAINT id_stan_magazynowy PRIMARY KEY (id_stan_magazynowy)
);


ALTER SEQUENCE db_project.stan_magazynowy_id_stan_magazynowy_seq OWNED BY db_project.stan_magazynowy.id_stan_magazynowy;

CREATE SEQUENCE db_project.klient_id_klient_seq;

CREATE TABLE db_project.klient (
                id_klient INTEGER NOT NULL DEFAULT nextval('db_project.klient_id_klient_seq'),
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                id_adres INTEGER NOT NULL,
                email VARCHAR NOT NULL,
                nr_telefonu VARCHAR,
                CONSTRAINT id_klient PRIMARY KEY (id_klient)
);


ALTER SEQUENCE db_project.klient_id_klient_seq OWNED BY db_project.klient.id_klient;

CREATE SEQUENCE db_project.koszyk_id_koszyk_seq;

CREATE TABLE db_project.koszyk (
                id_koszyk INTEGER NOT NULL DEFAULT nextval('db_project.koszyk_id_koszyk_seq'),
                id_klient INTEGER NOT NULL,
                CONSTRAINT id_koszyk PRIMARY KEY (id_koszyk)
);


ALTER SEQUENCE db_project.koszyk_id_koszyk_seq OWNED BY db_project.koszyk.id_koszyk;

CREATE SEQUENCE db_project.koszyk_produkt_id_koszyk_produkt_seq;

CREATE TABLE db_project.koszyk_produkt (
                id_koszyk_produkt INTEGER NOT NULL DEFAULT nextval('db_project.koszyk_produkt_id_koszyk_produkt_seq'),
                id_koszyk INTEGER NOT NULL,
                id_produkt INTEGER NOT NULL,
                ilosc INTEGER NOT NULL,
                CONSTRAINT id_koszyk_produkt PRIMARY KEY (id_koszyk_produkt)
);


ALTER SEQUENCE db_project.koszyk_produkt_id_koszyk_produkt_seq OWNED BY db_project.koszyk_produkt.id_koszyk_produkt;

CREATE SEQUENCE db_project.pracownik_id_pracownik_seq;

CREATE TABLE db_project.pracownik (
                id_pracownik INTEGER NOT NULL DEFAULT nextval('db_project.pracownik_id_pracownik_seq'),
                imie VARCHAR NOT NULL,
                nazwisko VARCHAR NOT NULL,
                stanowisko VARCHAR NOT NULL,
                id_adres INTEGER NOT NULL,
                email VARCHAR NOT NULL,
                nr_telefonu VARCHAR NOT NULL,
                nr_konta VARCHAR NOT NULL,
                CONSTRAINT id_pracownik PRIMARY KEY (id_pracownik)
);


ALTER SEQUENCE db_project.pracownik_id_pracownik_seq OWNED BY db_project.pracownik.id_pracownik;

CREATE SEQUENCE db_project.kod_rabatowy_id_kod_rabatowy_seq;

CREATE TABLE db_project.kod_rabatowy (
                id_kod_rabatowy INTEGER NOT NULL DEFAULT nextval('db_project.kod_rabatowy_id_kod_rabatowy_seq'),
                stawka_procentowa NUMERIC NOT NULL,
                kwota NUMERIC NOT NULL,
                kod VARCHAR NOT NULL,
                limit_uzyc INTEGER NOT NULL,
                wykorzystano INTEGER DEFAULT 0 NOT NULL,
                id_pracownik INTEGER NOT NULL,
                CONSTRAINT id_kod_rabatowy PRIMARY KEY (id_kod_rabatowy)
);


ALTER SEQUENCE db_project.kod_rabatowy_id_kod_rabatowy_seq OWNED BY db_project.kod_rabatowy.id_kod_rabatowy;

CREATE SEQUENCE db_project.zakup_id_zakup_seq;

CREATE TABLE db_project.zakup (
                id_zakup INTEGER NOT NULL DEFAULT nextval('db_project.zakup_id_zakup_seq'),
                ilosc INTEGER NOT NULL,
                id_produkt INTEGER NOT NULL,
                id_klient INTEGER NOT NULL,
                id_kod_rabatowy INTEGER,
                nr_zamowienia INTEGER NOT NULL,
                id_pracownik INTEGER NOT NULL,
                data DATE NOT NULL,
                CONSTRAINT id_zakup PRIMARY KEY (id_zakup)
);


ALTER SEQUENCE db_project.zakup_id_zakup_seq OWNED BY db_project.zakup.id_zakup;

ALTER TABLE db_project.pracownik ADD CONSTRAINT adres_pracownik_fk
FOREIGN KEY (id_adres)
REFERENCES db_project.adres (id_adres)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.klient ADD CONSTRAINT adres_klient_fk
FOREIGN KEY (id_adres)
REFERENCES db_project.adres (id_adres)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.dostawca ADD CONSTRAINT adres_dostawca_fk
FOREIGN KEY (id_adres)
REFERENCES db_project.adres (id_adres)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.produkt ADD CONSTRAINT dostawca_produkt_fk
FOREIGN KEY (id_dostawca)
REFERENCES db_project.dostawca (id_dostawca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.stan_magazynowy ADD CONSTRAINT produkt_stan_magazynowy_fk
FOREIGN KEY (id_produkt)
REFERENCES db_project.produkt (id_produkt)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.zakup ADD CONSTRAINT produkt_zakup_fk
FOREIGN KEY (id_produkt)
REFERENCES db_project.produkt (id_produkt)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.koszyk_produkt ADD CONSTRAINT produkt_koszyk_produkt_fk
FOREIGN KEY (id_produkt)
REFERENCES db_project.produkt (id_produkt)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.zakup ADD CONSTRAINT klient_zakup_fk
FOREIGN KEY (id_klient)
REFERENCES db_project.klient (id_klient)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.koszyk ADD CONSTRAINT klient_koszyk_fk
FOREIGN KEY (id_klient)
REFERENCES db_project.klient (id_klient)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.koszyk_produkt ADD CONSTRAINT koszyk_koszyk_produkt_fk
FOREIGN KEY (id_koszyk)
REFERENCES db_project.koszyk (id_koszyk)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.zakup ADD CONSTRAINT pracownik_zakup_fk
FOREIGN KEY (id_pracownik)
REFERENCES db_project.pracownik (id_pracownik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.kod_rabatowy ADD CONSTRAINT pracownik_kod_rabatowy_fk
FOREIGN KEY (id_pracownik)
REFERENCES db_project.pracownik (id_pracownik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE db_project.zakup ADD CONSTRAINT kod_rabatowy_zakup_fk
FOREIGN KEY (id_kod_rabatowy)
REFERENCES db_project.kod_rabatowy (id_kod_rabatowy)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
