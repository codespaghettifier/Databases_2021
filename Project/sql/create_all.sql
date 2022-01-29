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


INSERT INTO db_project.adres (miejscowosc, kod_pocztowy, ulica, nr_budynku) VALUES
('Katowice', '84-322', 'Papieżowa', 193),
('Toruń', '54-848', 'Kremówkowa', 732),
('Rzeszów', '60-287', 'Informatyczna', 349),
('Nowy Sącz', '81-342', 'Reymonta', 263),
('Rzeszów', '51-891', 'Studencka', 62),
('Rzeszów', '8-508', 'Górnicza', 825),
('Opole', '80-267', 'Bazowadanowa', 112),
('Łódź', '72-260', 'Jana Pawła II', 2137),
('Wadowice', '89-154', 'Jana Pawła II', 2137),
('Rzeszów', '80-334', 'Studencka', 16),
('Opole', '52-326', 'Rektorska', 429),
('Katowice', '30-434', 'Kawowa', 212),
('Katowice', '3-266', 'Papieżowa', 803),
('Rzeszów', '35-909', 'Papieżowa', 829),
('Opole', '88-801', 'Kremówkowa', 638),
('Koszalin', '86-402', 'Czarnowiejska', 449),
('Katowice', '80-399', 'Kremówkowa', 2),
('Toruń', '1-392', 'Fizyczna', 161),
('Pcim', '24-929', 'Informatyczna', 278),
('Szczecin', '1-392', 'Sieciowców', 87),
('Szczecin', '6-270', 'Kremówkowa', 317),
('Warszawa', '45-625', 'Dziekańska', 58),
('Kielce', '26-421', 'Studencka', 934),
('Katowice', '45-656', 'Devopsów', 796),
('Opole', '7-175', 'Rektorska', 449),
('Wadowice', '43-851', 'Programistów', 685),
('Toruń', '26-421', 'Czarnowiejska', 244),
('Toruń', '45-625', 'Reymonta', 300),
('Szczebrzeszyn', '10-991', 'Reymonta', 519),
('Toruń', '23-613', 'Informatyczna', 401),
('Kielce', '8-508', 'Czarnowiejska', 182),
('Wrocław', '84-322', 'Jana Pawła II', 2137),
('Opole', '45-742', 'Czarnowiejska', 713),
('Nowy Sącz', '68-161', 'Papieżowa', 807),
('Kielce', '80-399', 'Bazowadanowa', 627),
('Kielce', '74-443', 'Kremówkowa', 903),
('Bydgoszcz', '24-225', 'Kernelowa', 695),
('Opole', '72-260', 'Devopsów', 372),
('Nowy Sącz', '36-59', 'Jana Pawła II', 2137),
('Łódź', '31-860', 'Fizyczna', 206),
('Gdańsk', '26-171', 'Programistów', 271),
('Łódź', '12-166', 'Informatyczna', 481),
('Kraków', '26-771', 'Papieżowa', 104),
('Gdańsk', '61-207', 'Studencka', 900),
('Opole', '68-713', 'Fizyczna', 603),
('Szczecin', '25-741', 'Sieciowców', 957),
('Wrocław', '48-46', 'Papieżowa', 999),
('Toruń', '71-172', 'Kawowa', 188),
('Kielce', '45-744', 'Moździeżowa', 378),
('Pcim', '12-166', 'Reymonta', 924),
('Opole', '46-53', 'Górnicza', 729),
('Toruń', '71-172', 'Jana Pawła II', 2137),
('Gdańsk', '74-443', 'Kernelowa', 23),
('Pcim', '92-662', 'Devopsów', 71),
('Szczecin', '24-225', 'Testerów', 785),
('Toruń', '84-322', 'Testerów', 224),
('Szczebrzeszyn', '68-595', 'Papieżowa', 805),
('Wrocław', '47-979', 'Kremówkowa', 530),
('Nowy Sącz', '81-342', 'Programistów', 922),
('Toruń', '90-981', 'Programistów', 892),
('Koszalin', '24-142', 'Moździeżowa', 265),
('Łódź', '32-583', 'Sieciowców', 545),
('Rzeszów', '68-713', 'Informatyczna', 616),
('Wrocław', '84-322', 'Czarnowiejska', 226),
('Łódź', '47-233', 'Kremówkowa', 903),
('Toruń', '26-954', 'Moździeżowa', 656),
('Toruń', '30-434', 'Sieciowców', 245),
('Pcim', '80-399', 'Testerów', 967),
('Rzeszów', '45-744', 'Papieżowa', 42),
('Katowice', '28-967', 'Rektorska', 111);

INSERT INTO db_project.dostawca (nazwa, id_adres) VALUES
('ASDF z o.o.', 68),
('Qwerty S.A.', 58),
('Januszex z o.o', 51),
('Nosaczpol S.A', 36),
('Wodociągi Kieleckie S.A.', 27),
('Delko S.A', 42),
('Interkarton z o.o.', 49),
('Mirex z o.o', 45);

INSERT INTO db_project.klient (imie, nazwisko, id_adres, email, nr_telefonu) VALUES
('Ryszard', 'Babacki', 63, 'babacki@januszex.pl', '184642384'),
('Krzysztof', 'Cabacki', 54, 'cabacki@example.com', '315895182'),
('Zbigniew', 'Januszewski', 45, 'januszewski@example.com', '406414084'),
('Marcin', 'Tomaszewski', 23, 'tomaszewski@januszex.pl', '717771542'),
('Tomasz', 'Zawadzki', 16, 'zawadzki@januszex.pl', '916057681'),
('Piotr', 'Dadacki', 56, 'dadacki@asdf.pl', '858187665'),
('Dariusz', 'Sosnowski', 57, 'sosnowski@asdf.pl', '260299527'),
('Zbigniew', 'Babacki', 6, 'babacki@qwerty.com', '373647944'),
('Ryszard', 'Abacki', 43, 'abacki@januszex.pl', '147848138'),
('Andrzej', 'Babacki', 27, 'babacki@januszex.pl', '605437477'),
('Grzegorz', 'Sosnowski', 25, 'sosnowski@qwerty.com', '544145751'),
('Adam', 'Januszewski', 13, 'januszewski@januszex.pl', '335158717'),
('Marcin', 'Dadacki', 61, 'dadacki@qwerty.com', '195116364'),
('Michał', 'Abacki', 8, 'abacki@example.com', '567898787'),
('Jan', 'Chrabąszczaja', 14, 'chrabaszczaja@asdf.pl', '006895184'),
('Paweł', 'Nowak', 15, 'nowak@qwerty.com', '595852824'),
('Krzysztof', 'Chrabąszczaja', 25, 'chrabaszczaja@gmail.com', '977916544'),
('Adam', 'Babacki', 29, 'babacki@gmail.com', '456892250'),
('Adam', 'Zawadzki', 33, 'zawadzki@januszex.pl', '577453050'),
('Stanisław', 'Kowalski', 15, 'kowalski@qwerty.com', '068201848'),
('Zbigniew', 'Nowak', 37, 'nowak@gmail.com', '331177774'),
('Michał', 'Dadacki', 66, 'dadacki@qwerty.com', '904443292'),
('Piotr', 'Dadacki', 55, 'dadacki@qwerty.com', '129288669'),
('Jan', 'Mróz', 6, 'mroz@qwerty.com', '142076056'),
('Zbigniew', 'Kowalski', 20, 'kowalski@qwerty.com', '106468466'),
('Mariusz', 'Zawadzki', 2, 'zawadzki@januszex.pl', '242225539'),
('Paweł', 'Zawadzki', 69, 'zawadzki@gmail.com', '412670437'),
('Dariusz', 'Tomaszewski', 13, 'tomaszewski@asdf.pl', '397463779'),
('Stanisław', 'Januszewski', 59, 'januszewski@example.com', '947006425'),
('Ryszard', 'Zawadzki', 6, 'zawadzki@example.com', '655672720'),
('Krzysztof', 'Babacki', 15, 'babacki@example.com', '823729958'),
('Piotr', 'Abacki', 32, 'abacki@example.com', '028780015'),
('Zbigniew', 'Zawadzki', 5, 'zawadzki@example.com', '223980933'),
('Zbigniew', 'Mróz', 42, 'mroz@gmail.com', '473910745'),
('Jan', 'Abacki', 17, 'abacki@example.com', '091637319'),
('Stanisław', 'Babacki', 28, 'babacki@gmail.com', '715628076'),
('Rafał', 'Kowalski', 1, 'kowalski@asdf.pl', '632493225'),
('Paweł', 'Kowalski', 8, 'kowalski@example.com', '342898900'),
('Jan', 'Szewczyk', 4, 'szewczyk@asdf.pl', '390156350'),
('Piotr', 'Tomaszewski', 41, 'tomaszewski@gmail.com', '068782519'),
('Dariusz', 'Mróz', 48, 'mroz@qwerty.com', '446150974'),
('Jan', 'Babacki', 14, 'babacki@gmail.com', '083013447'),
('Grzegorz', 'Abacki', 46, 'abacki@example.com', '085654816'),
('Rafał', 'Nowak', 60, 'nowak@januszex.pl', '827629337'),
('Tomasz', 'Babacki', 14, 'babacki@qwerty.com', '066550626'),
('Marcin', 'Abacki', 47, 'abacki@qwerty.com', '995580786'),
('Grzegorz', 'Cabacki', 22, 'cabacki@januszex.pl', '344421142'),
('Mariusz', 'Abacki', 60, 'abacki@qwerty.com', '488940323'),
('Tomasz', 'Abacki', 29, 'abacki@asdf.pl', '421872843'),
('Tomasz', 'Tomaszewski', 16, 'tomaszewski@qwerty.com', '860192076');

INSERT INTO db_project.pracownik (imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta) VALUES
('Mariusz', 'Mróz', 'sprzedawca', 54, 'mroz@asdf.pl', '710214755', '77412899368545707546454282'),
('Zbigniew', 'Januszewski', 'manager', 54, 'januszewski@asdf.pl', '621379826', '11928028740023338417949374'),
('Rafał', 'Zawadzki', 'manager', 52, 'zawadzki@qwerty.com', '206736415', '71381785897372375671247708'),
('Marek', 'Nowak', 'sprzedawca', 8, 'nowak@januszex.pl', '858318603', '02245662161497298717511547'),
('Rafał', 'Szewczyk', 'sprzedawca', 67, 'szewczyk@januszex.pl', '666872371', '06704753071613690612483348'),
('Krzysztof', 'Nowak', 'kierownik sklepu', 18, 'nowak@qwerty.com', '860202058', '68867074343697464932312007'),
('Jan', 'Tomaszewski', 'manager', 15, 'tomaszewski@asdf.pl', '904951399', '79076990926231811668576132'),
('Rafał', 'Chrabąszczaja', 'manager', 43, 'chrabaszczaja@gmail.com', '597349173', '57982185144563940431308235'),
('Michał', 'Abacki', 'manager', 39, 'abacki@qwerty.com', '475373826', '50124578281610408317643603'),
('Michał', 'Nowak', 'manager', 17, 'nowak@asdf.pl', '408569136', '75065743138386348463506675');

INSERT INTO db_project.produkt (nazwa, cena_bazowa, stawka_vat, id_dostawca) VALUES
('bulbulator', 548, 5, 2),
('błotnik do czołgu', 8533, 23, 1),
('kabel od internetu', 2132, 23, 6),
('kawa', 296, 23, 6),
('woda Vytautas', 5024, 23, 5),
('pralka Haier', 4629, 5, 7),
('terrarium dla żółwia', 6833, 23, 5),
('karma dla gekona', 990, 8, 8),
('lodówka Haier', 6466, 8, 1);

INSERT INTO db_project.stan_magazynowy (id_produkt, ilosc) VALUES
(1, 22),
(2, 19),
(3, 8),
(4, 38),
(5, 18),
(6, 2),
(7, 7),
(8, 4),
(9, 5);

INSERT INTO db_project.kod_rabatowy (stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik) VALUES
(0, 90, 'letmein', 693, 252, 1),
(35, 0, 'cheaperplease', 405, 167, 1),
(0, 80, 'gonnacallmanager', 910, 397, 5),
(0, 60, 'imkaren', 772, 102, 1),
(0, 40, 'glovoxd', 669, 568, 3);

INSERT INTO db_project.koszyk (id_klient) VALUES
(41),
(32),
(10),
(8),
(38),
(30),
(31),
(34),
(14),
(3),
(37),
(23),
(45),
(17),
(42),
(33),
(22),
(13),
(18),
(1),
(21),
(26),
(40),
(25),
(35);

INSERT INTO db_project.koszyk_produkt (id_koszyk, id_produkt, ilosc) VALUES
(1, 9, 38),
(1, 3, 27),
(1, 5, 27),
(1, 7, 10),
(1, 8, 22),
(1, 1, 29),
(2, 6, 27),
(2, 3, 24),
(2, 7, 3),
(3, 2, 21),
(3, 3, 36),
(3, 9, 36),
(3, 6, 20),
(4, 1, 29),
(5, 1, 7),
(5, 4, 27),
(6, 6, 12),
(6, 1, 22),
(6, 5, 38),
(6, 8, 3),
(6, 7, 29),
(6, 2, 39),
(7, 7, 25),
(7, 9, 5),
(7, 1, 3),
(7, 3, 42),
(7, 4, 6),
(7, 5, 20),
(7, 6, 19),
(8, 6, 21),
(8, 3, 41),
(8, 9, 37),
(9, 5, 37),
(9, 8, 27),
(9, 3, 9),
(9, 9, 30),
(9, 4, 18),
(9, 2, 10),
(9, 6, 13),
(10, 5, 42),
(10, 9, 25),
(10, 2, 22),
(11, 8, 35),
(11, 6, 36),
(11, 2, 25),
(11, 4, 33),
(11, 7, 30),
(11, 9, 2),
(12, 1, 3),
(12, 3, 20),
(12, 4, 35),
(12, 7, 27),
(13, 5, 1),
(13, 6, 27),
(13, 2, 17),
(13, 7, 30),
(13, 3, 10),
(13, 8, 10),
(14, 5, 21),
(14, 9, 30),
(15, 2, 15),
(15, 9, 7),
(15, 8, 18),
(15, 1, 25),
(16, 3, 18),
(16, 8, 15),
(17, 3, 37),
(17, 2, 16),
(18, 5, 39),
(18, 6, 3),
(18, 3, 10),
(18, 7, 19),
(18, 9, 23),
(18, 2, 31),
(18, 8, 24),
(19, 2, 14),
(19, 5, 29),
(19, 3, 28),
(20, 5, 11),
(20, 9, 20),
(20, 8, 28),
(20, 7, 2),
(20, 3, 31),
(21, 6, 33),
(22, 6, 25),
(22, 9, 38),
(22, 2, 24),
(23, 9, 34),
(23, 2, 17),
(23, 6, 30),
(23, 4, 9),
(24, 5, 26),
(24, 7, 36),
(24, 9, 23),
(25, 3, 29),
(25, 4, 9),
(25, 6, 5),
(25, 9, 32);

INSERT INTO db_project.zakup (ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data) VALUES
(41, 6, 20, NULL, 1, 5, '2006-11-16'),
(40, 5, 20, NULL, 1, 5, '2006-11-16'),
(10, 4, 20, NULL, 1, 5, '2006-11-16'),
(13, 7, 20, NULL, 1, 5, '2006-11-16'),
(7, 1, 20, NULL, 1, 5, '2006-11-16'),
(19, 2, 20, NULL, 1, 5, '2006-11-16'),
(13, 6, 1, NULL, 2, 10, '2020-06-22'),
(28, 9, 1, NULL, 2, 10, '2020-06-22'),
(12, 4, 1, NULL, 2, 10, '2020-06-22'),
(16, 1, 1, NULL, 2, 10, '2020-06-22'),
(34, 7, 38, NULL, 3, 3, '2021-01-14'),
(8, 9, 38, NULL, 3, 3, '2021-01-14'),
(3, 3, 38, NULL, 3, 3, '2021-01-14'),
(21, 5, 15, 2, 4, 8, '2014-01-09'),
(10, 2, 15, 2, 4, 8, '2014-01-09'),
(34, 7, 15, 2, 4, 8, '2014-01-09'),
(35, 8, 15, 2, 4, 8, '2014-01-09'),
(30, 6, 15, 2, 4, 8, '2014-01-09'),
(13, 8, 27, NULL, 5, 9, '2010-10-27'),
(31, 2, 27, NULL, 5, 9, '2010-10-27'),
(10, 8, 29, NULL, 6, 10, '2019-08-26'),
(4, 4, 29, NULL, 6, 10, '2019-08-26'),
(3, 4, 34, 4, 7, 8, '2015-02-26'),
(12, 7, 34, 4, 7, 8, '2015-02-26'),
(24, 6, 34, 4, 7, 8, '2015-02-26'),
(7, 9, 34, 4, 7, 8, '2015-02-26'),
(1, 8, 34, 4, 7, 8, '2015-02-26'),
(10, 3, 34, 4, 7, 8, '2015-02-26'),
(10, 1, 34, 4, 7, 8, '2015-02-26'),
(18, 6, 24, NULL, 8, 4, '2013-02-18'),
(32, 7, 24, NULL, 8, 4, '2013-02-18'),
(7, 4, 24, NULL, 8, 4, '2013-02-18'),
(32, 8, 24, NULL, 8, 4, '2013-02-18'),
(28, 8, 34, NULL, 9, 5, '2008-09-17'),
(38, 3, 34, NULL, 9, 5, '2008-09-17'),
(33, 9, 34, NULL, 9, 5, '2008-09-17'),
(23, 2, 34, NULL, 9, 5, '2008-09-17'),
(38, 6, 34, NULL, 9, 5, '2008-09-17'),
(21, 4, 34, NULL, 9, 5, '2008-09-17'),
(11, 1, 36, NULL, 10, 9, '2009-02-12'),
(5, 2, 36, NULL, 10, 9, '2009-02-12'),
(38, 5, 36, NULL, 10, 9, '2009-02-12'),
(17, 6, 36, NULL, 10, 9, '2009-02-12'),
(3, 9, 36, NULL, 10, 9, '2009-02-12'),
(26, 3, 12, 1, 11, 7, '2021-02-22'),
(30, 1, 12, 1, 11, 7, '2021-02-22'),
(42, 8, 12, 1, 11, 7, '2021-02-22'),
(27, 5, 12, 1, 11, 7, '2021-02-22'),
(25, 9, 12, 1, 11, 7, '2021-02-22'),
(28, 5, 39, NULL, 12, 2, '2021-03-22'),
(30, 2, 43, 2, 13, 1, '2001-04-06'),
(28, 5, 43, 2, 13, 1, '2001-04-06'),
(36, 7, 43, 2, 13, 1, '2001-04-06'),
(13, 3, 43, 2, 13, 1, '2001-04-06'),
(5, 3, 27, NULL, 14, 7, '2015-10-20'),
(9, 5, 27, NULL, 14, 7, '2015-10-20'),
(19, 8, 27, NULL, 14, 7, '2015-10-20'),
(40, 7, 27, NULL, 14, 7, '2015-10-20'),
(41, 6, 23, NULL, 15, 3, '2016-07-27'),
(25, 4, 23, NULL, 15, 3, '2016-07-27'),
(23, 9, 23, NULL, 15, 3, '2016-07-27'),
(31, 1, 23, NULL, 15, 3, '2016-07-27'),
(20, 8, 23, NULL, 15, 3, '2016-07-27'),
(41, 2, 23, NULL, 15, 3, '2016-07-27'),
(42, 7, 42, NULL, 16, 8, '2008-04-17'),
(36, 6, 42, NULL, 16, 8, '2008-04-17'),
(35, 5, 42, NULL, 16, 8, '2008-04-17'),
(23, 9, 42, NULL, 16, 8, '2008-04-17'),
(4, 3, 1, NULL, 17, 7, '2003-03-01'),
(26, 7, 1, NULL, 17, 7, '2003-03-01'),
(16, 3, 30, NULL, 18, 3, '2006-06-02'),
(27, 8, 30, NULL, 18, 3, '2006-06-02'),
(5, 4, 30, NULL, 18, 3, '2006-06-02'),
(27, 7, 30, NULL, 18, 3, '2006-06-02'),
(39, 3, 30, 3, 19, 7, '2019-11-15'),
(8, 4, 30, 3, 19, 7, '2019-11-15'),
(6, 7, 30, 3, 19, 7, '2019-11-15'),
(27, 2, 30, 3, 19, 7, '2019-11-15'),
(13, 8, 30, 3, 19, 7, '2019-11-15'),
(42, 9, 30, 3, 19, 7, '2019-11-15'),
(32, 1, 17, 2, 20, 9, '2002-03-01'),
(18, 6, 17, 2, 20, 9, '2002-03-01'),
(29, 9, 17, 2, 20, 9, '2002-03-01'),
(28, 6, 43, 5, 21, 3, '2016-07-30'),
(27, 7, 43, 5, 21, 3, '2016-07-30'),
(28, 1, 43, 5, 21, 3, '2016-07-30'),
(4, 5, 43, 5, 21, 3, '2016-07-30'),
(33, 3, 43, 5, 21, 3, '2016-07-30'),
(16, 2, 16, 3, 22, 6, '2001-03-23'),
(33, 7, 16, 3, 22, 6, '2001-03-23'),
(8, 9, 16, 3, 22, 6, '2001-03-23'),
(20, 3, 16, 3, 22, 6, '2001-03-23'),
(22, 1, 16, 3, 22, 6, '2001-03-23'),
(24, 5, 16, 3, 22, 6, '2001-03-23'),
(18, 9, 17, 1, 23, 7, '2000-04-07'),
(31, 2, 17, 1, 23, 7, '2000-04-07'),
(26, 4, 17, 1, 23, 7, '2000-04-07'),
(8, 5, 17, 1, 23, 7, '2000-04-07'),
(36, 1, 17, 1, 23, 7, '2000-04-07'),
(41, 5, 4, NULL, 24, 1, '2007-11-27'),
(23, 8, 4, NULL, 24, 1, '2007-11-27'),
(5, 1, 4, NULL, 24, 1, '2007-11-27'),
(4, 9, 4, NULL, 24, 1, '2007-11-27'),
(32, 4, 4, NULL, 24, 1, '2007-11-27'),
(17, 4, 25, 5, 25, 5, '2013-12-14'),
(21, 5, 25, 5, 25, 5, '2013-12-14'),
(34, 3, 25, 5, 25, 5, '2013-12-14'),
(13, 9, 25, 5, 25, 5, '2013-12-14'),
(38, 2, 25, 5, 25, 5, '2013-12-14'),
(36, 8, 25, 5, 25, 5, '2013-12-14'),
(3, 7, 8, 5, 26, 8, '2019-07-21'),
(22, 8, 8, 5, 26, 8, '2019-07-21'),
(15, 1, 8, 5, 26, 8, '2019-07-21'),
(6, 6, 8, 5, 26, 8, '2019-07-21'),
(31, 1, 2, 2, 27, 3, '2012-01-20'),
(9, 2, 2, 2, 27, 3, '2012-01-20'),
(37, 8, 2, 2, 27, 3, '2012-01-20'),
(15, 4, 2, 2, 27, 3, '2012-01-20'),
(9, 7, 12, NULL, 28, 9, '2010-12-27'),
(27, 9, 12, NULL, 28, 9, '2010-12-27'),
(9, 3, 12, NULL, 28, 9, '2010-12-27'),
(31, 2, 12, NULL, 28, 9, '2010-12-27'),
(31, 4, 12, NULL, 28, 9, '2010-12-27'),
(10, 5, 3, NULL, 29, 6, '2015-03-03'),
(13, 4, 3, NULL, 29, 6, '2015-03-03'),
(30, 8, 3, NULL, 29, 6, '2015-03-03'),
(19, 1, 3, NULL, 29, 6, '2015-03-03'),
(15, 6, 21, 3, 30, 9, '2014-12-26'),
(19, 5, 21, 3, 30, 9, '2014-12-26'),
(5, 7, 21, 3, 30, 9, '2014-12-26'),
(7, 3, 21, 3, 30, 9, '2014-12-26'),
(9, 1, 21, 3, 30, 9, '2014-12-26'),
(38, 7, 1, NULL, 31, 7, '2021-08-08'),
(8, 6, 1, NULL, 31, 7, '2021-08-08'),
(10, 2, 1, NULL, 31, 7, '2021-08-08'),
(20, 2, 28, 4, 32, 10, '2011-08-05'),
(5, 8, 28, 4, 32, 10, '2011-08-05'),
(9, 7, 28, 4, 32, 10, '2011-08-05'),
(3, 4, 28, 4, 32, 10, '2011-08-05'),
(12, 9, 28, 4, 32, 10, '2011-08-05'),
(13, 6, 23, 1, 33, 2, '2007-09-22'),
(27, 8, 23, 1, 33, 2, '2007-09-22'),
(41, 2, 23, 1, 33, 2, '2007-09-22'),
(4, 4, 23, 1, 33, 2, '2007-09-22'),
(4, 9, 23, 1, 33, 2, '2007-09-22'),
(29, 1, 23, 1, 33, 2, '2007-09-22'),
(22, 7, 23, 1, 33, 2, '2007-09-22'),
(34, 2, 34, NULL, 34, 3, '2000-09-22'),
(8, 9, 34, NULL, 34, 3, '2000-09-22'),
(16, 8, 46, NULL, 35, 3, '2013-08-27'),
(12, 9, 46, NULL, 35, 3, '2013-08-27'),
(24, 1, 46, NULL, 35, 3, '2013-08-27'),
(26, 4, 46, NULL, 35, 3, '2013-08-27'),
(42, 2, 46, NULL, 35, 3, '2013-08-27'),
(14, 9, 38, NULL, 36, 1, '2007-05-28'),
(23, 6, 38, NULL, 36, 1, '2007-05-28'),
(37, 5, 38, NULL, 36, 1, '2007-05-28'),
(27, 2, 38, NULL, 36, 1, '2007-05-28'),
(33, 1, 38, NULL, 36, 1, '2007-05-28'),
(19, 4, 24, 3, 37, 7, '2008-04-17'),
(18, 2, 24, 3, 37, 7, '2008-04-17'),
(12, 7, 24, 3, 37, 7, '2008-04-17'),
(20, 5, 24, 3, 37, 7, '2008-04-17'),
(34, 8, 24, 3, 37, 7, '2008-04-17'),
(23, 1, 24, 3, 37, 7, '2008-04-17'),
(21, 6, 45, NULL, 38, 5, '2003-10-03'),
(1, 6, 34, 1, 39, 3, '2015-12-22'),
(6, 3, 34, 1, 39, 3, '2015-12-22'),
(30, 5, 34, 1, 39, 3, '2015-12-22'),
(4, 9, 34, 1, 39, 3, '2015-12-22'),
(30, 1, 34, 1, 39, 3, '2015-12-22'),
(17, 7, 34, 1, 39, 3, '2015-12-22'),
(17, 2, 46, 5, 40, 8, '2007-12-18'),
(9, 8, 46, 5, 40, 8, '2007-12-18'),
(13, 9, 46, 5, 40, 8, '2007-12-18'),
(14, 3, 28, 1, 41, 1, '2001-11-24'),
(12, 2, 28, 1, 41, 1, '2001-11-24'),
(14, 9, 28, 1, 41, 1, '2001-11-24'),
(26, 4, 28, 1, 41, 1, '2001-11-24'),
(38, 2, 34, NULL, 42, 5, '2007-04-07'),
(32, 3, 34, NULL, 42, 5, '2007-04-07'),
(13, 4, 42, 5, 43, 2, '2005-05-05'),
(40, 5, 40, NULL, 44, 3, '2001-04-08'),
(17, 4, 40, NULL, 44, 3, '2001-04-08'),
(4, 9, 40, NULL, 44, 3, '2001-04-08'),
(15, 8, 40, NULL, 44, 3, '2001-04-08'),
(34, 6, 40, NULL, 44, 3, '2001-04-08'),
(15, 7, 40, NULL, 44, 3, '2001-04-08'),
(27, 1, 22, NULL, 45, 5, '2021-02-21'),
(10, 6, 22, NULL, 45, 5, '2021-02-21'),
(18, 9, 22, NULL, 45, 5, '2021-02-21'),
(11, 7, 22, NULL, 45, 5, '2021-02-21'),
(20, 2, 22, NULL, 45, 5, '2021-02-21'),
(7, 9, 37, NULL, 46, 3, '2001-03-25'),
(16, 5, 37, NULL, 46, 3, '2001-03-25'),
(28, 6, 37, NULL, 46, 3, '2001-03-25'),
(4, 6, 14, NULL, 47, 1, '2005-02-21'),
(23, 5, 14, NULL, 47, 1, '2005-02-21'),
(4, 3, 14, NULL, 47, 1, '2005-02-21'),
(35, 3, 11, NULL, 48, 1, '2021-01-21'),
(21, 3, 34, 1, 49, 5, '2010-04-12'),
(37, 1, 34, 1, 49, 5, '2010-04-12'),
(8, 5, 34, 1, 49, 5, '2010-04-12'),
(33, 9, 34, 1, 49, 5, '2010-04-12'),
(11, 9, 11, NULL, 50, 3, '2006-01-27'),
(1, 7, 11, NULL, 50, 3, '2006-01-27'),
(21, 3, 16, 3, 51, 5, '2001-10-25'),
(36, 5, 16, 3, 51, 5, '2001-10-25'),
(25, 7, 16, 3, 51, 5, '2001-10-25'),
(27, 1, 16, 3, 51, 5, '2001-10-25'),
(33, 8, 16, 3, 51, 5, '2001-10-25'),
(4, 6, 43, 2, 52, 10, '2012-12-08'),
(1, 4, 43, 2, 52, 10, '2012-12-08'),
(1, 5, 43, 2, 52, 10, '2012-12-08'),
(37, 7, 48, NULL, 53, 10, '2001-07-13'),
(29, 6, 48, NULL, 53, 10, '2001-07-13'),
(8, 4, 48, NULL, 53, 10, '2001-07-13'),
(6, 5, 48, NULL, 53, 10, '2001-07-13'),
(17, 1, 48, NULL, 53, 10, '2001-07-13'),
(29, 8, 3, NULL, 54, 10, '2003-12-30'),
(35, 3, 3, NULL, 54, 10, '2003-12-30'),
(39, 2, 3, NULL, 54, 10, '2003-12-30'),
(20, 9, 3, NULL, 54, 10, '2003-12-30'),
(42, 6, 9, 4, 55, 3, '2000-12-03'),
(2, 2, 9, 4, 55, 3, '2000-12-03'),
(3, 1, 9, 4, 55, 3, '2000-12-03'),
(4, 2, 44, NULL, 56, 10, '2015-05-18'),
(25, 8, 44, NULL, 56, 10, '2015-05-18'),
(29, 7, 44, NULL, 56, 10, '2015-05-18'),
(39, 9, 40, NULL, 57, 8, '2005-10-03'),
(16, 7, 40, NULL, 57, 8, '2005-10-03'),
(16, 5, 40, NULL, 57, 8, '2005-10-03'),
(15, 4, 40, NULL, 57, 8, '2005-10-03'),
(34, 4, 22, NULL, 58, 1, '2013-02-14'),
(30, 3, 22, NULL, 58, 1, '2013-02-14'),
(40, 9, 22, NULL, 58, 1, '2013-02-14'),
(34, 5, 31, 1, 59, 8, '2008-01-18'),
(4, 9, 31, 1, 59, 8, '2008-01-18'),
(34, 6, 31, 1, 59, 8, '2008-01-18'),
(17, 6, 42, NULL, 60, 4, '2018-03-21'),
(2, 5, 40, 5, 61, 3, '2003-10-26'),
(2, 7, 40, 5, 61, 3, '2003-10-26'),
(17, 4, 37, 3, 62, 9, '2020-06-18'),
(33, 1, 37, 3, 62, 9, '2020-06-18'),
(30, 2, 37, 3, 62, 9, '2020-06-18'),
(37, 8, 37, 3, 62, 9, '2020-06-18'),
(33, 7, 37, 3, 62, 9, '2020-06-18'),
(29, 9, 37, 3, 62, 9, '2020-06-18'),
(3, 6, 37, 3, 62, 9, '2020-06-18'),
(6, 5, 37, 3, 62, 9, '2020-06-18'),
(2, 6, 8, 3, 63, 6, '2014-05-28'),
(10, 4, 8, 3, 63, 6, '2014-05-28'),
(12, 8, 8, 3, 63, 6, '2014-05-28'),
(22, 3, 8, 3, 63, 6, '2014-05-28'),
(24, 1, 8, 3, 63, 6, '2014-05-28'),
(31, 9, 9, NULL, 64, 7, '2013-01-06'),
(11, 8, 9, NULL, 64, 7, '2013-01-06'),
(5, 7, 9, NULL, 64, 7, '2013-01-06'),
(26, 9, 27, NULL, 65, 1, '2007-07-16'),
(17, 7, 27, NULL, 65, 1, '2007-07-16'),
(22, 3, 27, NULL, 65, 1, '2007-07-16'),
(2, 2, 2, 5, 66, 10, '2003-01-07'),
(22, 3, 2, 5, 66, 10, '2003-01-07'),
(19, 2, 47, 4, 67, 7, '2005-07-19'),
(27, 1, 47, 4, 67, 7, '2005-07-19'),
(24, 9, 38, 4, 68, 9, '2008-12-29'),
(13, 4, 38, 4, 68, 9, '2008-12-29'),
(8, 3, 38, 4, 68, 9, '2008-12-29'),
(8, 6, 24, NULL, 69, 1, '2004-03-18'),
(23, 3, 24, NULL, 69, 1, '2004-03-18'),
(17, 2, 24, NULL, 69, 1, '2004-03-18'),
(7, 1, 24, NULL, 69, 1, '2004-03-18'),
(13, 9, 24, NULL, 69, 1, '2004-03-18'),
(32, 9, 13, NULL, 70, 6, '2005-02-06'),
(19, 7, 13, NULL, 70, 6, '2005-02-06'),
(10, 3, 12, NULL, 71, 6, '2013-06-23'),
(29, 7, 19, NULL, 72, 9, '2010-05-30'),
(37, 6, 19, NULL, 72, 9, '2010-05-30'),
(32, 5, 17, NULL, 73, 5, '2010-08-06'),
(4, 6, 17, NULL, 73, 5, '2010-08-06'),
(19, 7, 17, NULL, 73, 5, '2010-08-06'),
(21, 8, 17, NULL, 73, 5, '2010-08-06'),
(3, 2, 17, NULL, 73, 5, '2010-08-06'),
(36, 4, 17, NULL, 73, 5, '2010-08-06'),
(7, 6, 42, NULL, 74, 2, '2003-02-09'),
(2, 3, 42, NULL, 74, 2, '2003-02-09'),
(36, 5, 42, NULL, 74, 2, '2003-02-09'),
(20, 4, 42, NULL, 74, 2, '2003-02-09'),
(36, 9, 29, 4, 75, 10, '2005-01-18'),
(11, 8, 29, 4, 75, 10, '2005-01-18'),
(41, 2, 29, 4, 75, 10, '2005-01-18'),
(20, 4, 29, 4, 75, 10, '2005-01-18'),
(32, 3, 29, 1, 76, 1, '2010-11-16'),
(26, 4, 29, 1, 76, 1, '2010-11-16'),
(27, 7, 29, 1, 76, 1, '2010-11-16'),
(14, 6, 29, 1, 76, 1, '2010-11-16'),
(31, 2, 29, 1, 76, 1, '2010-11-16'),
(36, 3, 35, 5, 77, 10, '2012-10-28'),
(12, 6, 35, 5, 77, 10, '2012-10-28'),
(7, 2, 45, NULL, 78, 4, '2010-04-08'),
(34, 5, 45, NULL, 78, 4, '2010-04-08'),
(1, 3, 45, NULL, 78, 4, '2010-04-08'),
(25, 4, 45, NULL, 78, 4, '2010-04-08'),
(18, 7, 45, NULL, 78, 4, '2010-04-08'),
(26, 7, 23, 1, 79, 9, '2020-06-10'),
(26, 9, 23, 1, 79, 9, '2020-06-10'),
(34, 6, 23, 1, 79, 9, '2020-06-10'),
(18, 2, 45, 2, 80, 2, '2015-03-03'),
(26, 9, 45, 2, 80, 2, '2015-03-03'),
(19, 1, 45, 2, 80, 2, '2015-03-03'),
(23, 7, 45, 2, 80, 2, '2015-03-03'),
(14, 6, 15, NULL, 81, 3, '2004-07-05'),
(20, 8, 15, NULL, 81, 3, '2004-07-05'),
(33, 3, 15, NULL, 81, 3, '2004-07-05'),
(16, 1, 15, NULL, 81, 3, '2004-07-05'),
(19, 7, 15, NULL, 81, 3, '2004-07-05'),
(23, 9, 15, NULL, 81, 3, '2004-07-05'),
(42, 9, 3, 1, 82, 1, '2018-01-08'),
(11, 5, 3, 1, 82, 1, '2018-01-08'),
(22, 6, 3, 1, 82, 1, '2018-01-08'),
(4, 1, 3, 1, 82, 1, '2018-01-08'),
(29, 7, 3, 1, 82, 1, '2018-01-08'),
(40, 7, 37, 1, 83, 7, '2012-08-24'),
(31, 9, 37, 1, 83, 7, '2012-08-24'),
(18, 6, 37, 1, 83, 7, '2012-08-24'),
(9, 4, 37, 1, 83, 7, '2012-08-24'),
(27, 1, 37, 1, 83, 7, '2012-08-24'),
(25, 8, 36, NULL, 84, 2, '2001-11-11'),
(16, 6, 36, NULL, 84, 2, '2001-11-11'),
(6, 1, 7, NULL, 85, 5, '2005-01-09'),
(20, 8, 7, NULL, 85, 5, '2005-01-09'),
(33, 6, 7, NULL, 85, 5, '2005-01-09'),
(31, 9, 7, NULL, 85, 5, '2005-01-09'),
(37, 3, 7, NULL, 85, 5, '2005-01-09'),
(12, 5, 7, NULL, 85, 5, '2005-01-09'),
(39, 6, 47, 2, 86, 5, '2008-12-01'),
(14, 1, 47, 2, 86, 5, '2008-12-01'),
(4, 3, 47, 2, 86, 5, '2008-12-01'),
(15, 4, 47, 2, 86, 5, '2008-12-01'),
(19, 8, 8, 3, 87, 10, '2019-12-04'),
(17, 2, 8, 3, 87, 10, '2019-12-04'),
(34, 3, 8, 3, 87, 10, '2019-12-04'),
(23, 4, 8, 3, 87, 10, '2019-12-04'),
(7, 7, 8, 3, 87, 10, '2019-12-04'),
(15, 6, 8, 3, 87, 10, '2019-12-04'),
(41, 8, 34, NULL, 88, 3, '2002-12-20'),
(20, 2, 34, NULL, 88, 3, '2002-12-20'),
(6, 7, 34, NULL, 88, 3, '2002-12-20'),
(38, 9, 34, NULL, 88, 3, '2002-12-20'),
(33, 6, 34, NULL, 88, 3, '2002-12-20'),
(28, 2, 50, NULL, 89, 1, '2006-08-05'),
(34, 8, 50, NULL, 89, 1, '2006-08-05'),
(42, 5, 3, NULL, 90, 9, '2010-06-21'),
(8, 3, 3, NULL, 90, 9, '2010-06-21'),
(14, 4, 3, NULL, 90, 9, '2010-06-21'),
(4, 1, 3, NULL, 90, 9, '2010-06-21'),
(18, 6, 35, NULL, 91, 8, '2006-08-22'),
(30, 2, 35, NULL, 91, 8, '2006-08-22'),
(24, 7, 35, NULL, 91, 8, '2006-08-22'),
(41, 3, 35, NULL, 91, 8, '2006-08-22'),
(6, 6, 42, NULL, 92, 9, '2012-03-10'),
(36, 8, 42, NULL, 92, 9, '2012-03-10'),
(33, 2, 42, NULL, 92, 9, '2012-03-10'),
(13, 3, 42, NULL, 92, 9, '2012-03-10'),
(15, 9, 42, NULL, 92, 9, '2012-03-10'),
(7, 7, 9, 5, 93, 4, '2015-03-25'),
(22, 3, 38, 4, 94, 5, '2015-05-24'),
(37, 7, 38, 4, 94, 5, '2015-05-24'),
(26, 5, 38, 4, 94, 5, '2015-05-24'),
(37, 6, 38, 4, 94, 5, '2015-05-24'),
(26, 8, 38, 4, 94, 5, '2015-05-24'),
(39, 2, 38, 4, 94, 5, '2015-05-24'),
(19, 7, 37, 3, 95, 8, '2007-12-21'),
(32, 2, 37, 3, 95, 8, '2007-12-21'),
(21, 1, 37, 3, 95, 8, '2007-12-21'),
(34, 6, 37, 3, 95, 8, '2007-12-21'),
(35, 2, 49, NULL, 96, 10, '2000-07-24'),
(7, 3, 49, NULL, 96, 10, '2000-07-24'),
(35, 9, 49, NULL, 96, 10, '2000-07-24'),
(21, 6, 49, NULL, 96, 10, '2000-07-24'),
(11, 1, 49, NULL, 96, 10, '2000-07-24'),
(7, 2, 40, NULL, 97, 4, '2015-12-20'),
(4, 4, 40, NULL, 97, 4, '2015-12-20'),
(37, 1, 22, 1, 98, 9, '2005-06-14'),
(34, 4, 22, 1, 98, 9, '2005-06-14'),
(11, 8, 22, 1, 98, 9, '2005-06-14'),
(16, 3, 22, 1, 98, 9, '2005-06-14'),
(3, 2, 22, 1, 98, 9, '2005-06-14'),
(41, 6, 22, 1, 98, 9, '2005-06-14'),
(18, 4, 11, NULL, 99, 8, '2021-11-24'),
(41, 3, 11, NULL, 99, 8, '2021-11-24'),
(32, 5, 11, NULL, 99, 8, '2021-11-24'),
(1, 2, 23, NULL, 100, 1, '2007-12-19'),
(26, 3, 23, NULL, 100, 1, '2007-12-19'),
(33, 1, 32, NULL, 101, 4, '2001-09-24'),
(15, 2, 32, NULL, 101, 4, '2001-09-24'),
(40, 9, 32, NULL, 101, 4, '2001-09-24'),
(6, 5, 32, NULL, 101, 4, '2001-09-24'),
(32, 6, 32, NULL, 101, 4, '2001-09-24'),
(28, 6, 42, NULL, 102, 4, '2011-08-06'),
(13, 9, 42, NULL, 102, 4, '2011-08-06'),
(36, 3, 42, NULL, 102, 4, '2011-08-06'),
(4, 7, 42, NULL, 102, 4, '2011-08-06'),
(11, 8, 42, NULL, 102, 4, '2011-08-06'),
(18, 4, 42, NULL, 102, 4, '2011-08-06'),
(30, 5, 42, NULL, 102, 4, '2011-08-06'),
(32, 1, 42, NULL, 102, 4, '2011-08-06'),
(8, 2, 1, 1, 103, 6, '2004-07-01'),
(3, 5, 1, 1, 103, 6, '2004-07-01'),
(40, 4, 1, 1, 103, 6, '2004-07-01'),
(39, 6, 38, 3, 104, 1, '2011-03-11'),
(38, 8, 38, 3, 104, 1, '2011-03-11'),
(40, 9, 38, 3, 104, 1, '2011-03-11'),
(20, 7, 38, 3, 104, 1, '2011-03-11'),
(10, 2, 2, 2, 105, 1, '2006-07-12'),
(12, 3, 2, 2, 105, 1, '2006-07-12'),
(19, 6, 2, 2, 105, 1, '2006-07-12'),
(5, 1, 16, 3, 106, 5, '2011-07-17'),
(8, 9, 16, 3, 106, 5, '2011-07-17'),
(10, 3, 16, 3, 106, 5, '2011-07-17'),
(28, 8, 16, 3, 106, 5, '2011-07-17'),
(3, 7, 16, 3, 106, 5, '2011-07-17'),
(27, 2, 16, 3, 106, 5, '2011-07-17'),
(13, 4, 16, 3, 106, 5, '2011-07-17'),
(8, 5, 31, NULL, 107, 2, '2006-09-28'),
(27, 6, 31, NULL, 107, 2, '2006-09-28'),
(28, 7, 26, 3, 108, 1, '2002-08-25'),
(37, 3, 26, 3, 108, 1, '2002-08-25'),
(26, 9, 27, NULL, 109, 5, '2018-07-26'),
(30, 7, 27, NULL, 109, 5, '2018-07-26'),
(28, 8, 27, NULL, 109, 5, '2018-07-26'),
(22, 5, 27, NULL, 109, 5, '2018-07-26'),
(38, 4, 27, NULL, 109, 5, '2018-07-26'),
(9, 5, 6, 2, 110, 10, '2020-09-30'),
(16, 3, 6, 2, 110, 10, '2020-09-30'),
(20, 4, 6, 2, 110, 10, '2020-09-30'),
(2, 6, 6, 2, 110, 10, '2020-09-30'),
(14, 7, 6, 2, 110, 10, '2020-09-30'),
(40, 9, 6, 2, 110, 10, '2020-09-30'),
(39, 9, 14, NULL, 111, 3, '2014-02-01'),
(38, 5, 14, NULL, 111, 3, '2014-02-01'),
(9, 6, 14, NULL, 111, 3, '2014-02-01'),
(11, 1, 14, NULL, 111, 3, '2014-02-01'),
(9, 4, 3, 4, 112, 5, '2018-06-12'),
(2, 7, 3, 4, 112, 5, '2018-06-12'),
(18, 9, 6, NULL, 113, 3, '2019-01-08'),
(8, 8, 6, NULL, 113, 3, '2019-01-08'),
(8, 5, 6, NULL, 113, 3, '2019-01-08'),
(3, 7, 23, 3, 114, 3, '2009-07-31'),
(39, 1, 23, 3, 114, 3, '2009-07-31'),
(42, 4, 23, 3, 114, 3, '2009-07-31'),
(6, 1, 12, 1, 115, 8, '2016-06-14'),
(18, 5, 12, 1, 115, 8, '2016-06-14'),
(9, 6, 12, 1, 115, 8, '2016-06-14'),
(26, 8, 12, 1, 115, 8, '2016-06-14'),
(20, 3, 12, 1, 115, 8, '2016-06-14'),
(11, 8, 34, 2, 116, 5, '2021-07-14'),
(39, 3, 34, 2, 116, 5, '2021-07-14'),
(21, 4, 34, 2, 116, 5, '2021-07-14'),
(36, 9, 34, 2, 116, 5, '2021-07-14'),
(8, 2, 34, 2, 116, 5, '2021-07-14'),
(2, 5, 34, 2, 116, 5, '2021-07-14'),
(19, 9, 20, 3, 117, 10, '2011-10-23'),
(19, 2, 20, 3, 117, 10, '2011-10-23'),
(14, 8, 20, 3, 117, 10, '2011-10-23'),
(14, 7, 20, 3, 117, 10, '2011-10-23'),
(6, 5, 34, 1, 118, 8, '2003-07-17'),
(14, 2, 34, 1, 118, 8, '2003-07-17'),
(22, 4, 34, 1, 118, 8, '2003-07-17'),
(14, 3, 34, 1, 118, 8, '2003-07-17'),
(18, 4, 44, 2, 119, 5, '2003-06-24'),
(23, 8, 44, 2, 119, 5, '2003-06-24'),
(42, 1, 44, 2, 119, 5, '2003-06-24'),
(40, 6, 44, 2, 119, 5, '2003-06-24'),
(18, 9, 44, 2, 119, 5, '2003-06-24'),
(1, 1, 14, 1, 120, 2, '2009-02-02'),
(10, 2, 14, 1, 120, 2, '2009-02-02'),
(4, 8, 14, 1, 120, 2, '2009-02-02'),
(10, 7, 14, 1, 120, 2, '2009-02-02'),
(8, 9, 26, 4, 121, 6, '2018-02-03'),
(28, 1, 26, 4, 121, 6, '2018-02-03'),
(18, 6, 43, 4, 122, 2, '2020-08-15'),
(34, 8, 43, 4, 122, 2, '2020-08-15'),
(1, 2, 43, 4, 122, 2, '2020-08-15'),
(5, 4, 43, 4, 122, 2, '2020-08-15'),
(19, 9, 43, 4, 122, 2, '2020-08-15'),
(30, 1, 43, 4, 122, 2, '2020-08-15'),
(1, 1, 27, NULL, 123, 9, '2002-10-13'),
(19, 8, 27, NULL, 123, 9, '2002-10-13'),
(3, 3, 27, NULL, 123, 9, '2002-10-13'),
(39, 7, 27, NULL, 123, 9, '2002-10-13'),
(16, 2, 27, NULL, 123, 9, '2002-10-13'),
(33, 2, 33, 1, 124, 10, '2004-01-20'),
(23, 4, 33, 1, 124, 10, '2004-01-20'),
(33, 1, 33, 1, 124, 10, '2004-01-20'),
(36, 6, 33, 1, 124, 10, '2004-01-20'),
(4, 3, 40, NULL, 125, 1, '2009-09-12'),
(19, 6, 40, NULL, 125, 1, '2009-09-12'),
(19, 1, 27, NULL, 126, 10, '2012-12-17'),
(34, 2, 42, 1, 127, 1, '2009-01-27'),
(26, 1, 42, 1, 127, 1, '2009-01-27'),
(15, 8, 42, 1, 127, 1, '2009-01-27'),
(1, 5, 30, NULL, 128, 9, '2011-03-02'),
(29, 7, 30, NULL, 128, 9, '2011-03-02'),
(40, 9, 30, NULL, 128, 9, '2011-03-02'),
(27, 2, 30, NULL, 128, 9, '2011-03-02'),
(27, 2, 35, 3, 129, 2, '2009-08-11'),
(18, 6, 45, NULL, 130, 3, '2015-04-24'),
(15, 1, 45, NULL, 130, 3, '2015-04-24'),
(32, 3, 45, NULL, 130, 3, '2015-04-24'),
(40, 5, 45, NULL, 130, 3, '2015-04-24'),
(29, 2, 25, NULL, 131, 7, '2001-04-22'),
(36, 7, 25, NULL, 131, 7, '2001-04-22'),
(17, 3, 20, NULL, 132, 1, '2019-11-27'),
(11, 2, 20, NULL, 132, 1, '2019-11-27'),
(29, 7, 20, NULL, 132, 1, '2019-11-27'),
(42, 5, 20, NULL, 132, 1, '2019-11-27'),
(10, 8, 20, NULL, 132, 1, '2019-11-27'),
(13, 6, 20, NULL, 132, 1, '2019-11-27'),
(26, 3, 43, 1, 133, 4, '2020-03-25'),
(14, 7, 43, 1, 133, 4, '2020-03-25'),
(38, 2, 43, 1, 133, 4, '2020-03-25'),
(5, 9, 43, 1, 133, 4, '2020-03-25'),
(12, 6, 43, 1, 133, 4, '2020-03-25'),
(28, 8, 43, 1, 133, 4, '2020-03-25'),
(12, 8, 48, 4, 134, 1, '2011-06-11'),
(16, 1, 48, 4, 134, 1, '2011-06-11'),
(19, 9, 48, 4, 134, 1, '2011-06-11'),
(8, 3, 48, 4, 134, 1, '2011-06-11'),
(3, 5, 48, 4, 134, 1, '2011-06-11'),
(13, 4, 48, 4, 134, 1, '2011-06-11'),
(30, 3, 7, NULL, 135, 5, '2004-11-23'),
(8, 9, 7, NULL, 135, 5, '2004-11-23'),
(37, 7, 12, NULL, 136, 6, '2000-02-15'),
(33, 8, 12, NULL, 136, 6, '2000-02-15'),
(20, 9, 12, NULL, 136, 6, '2000-02-15'),
(3, 2, 19, NULL, 137, 9, '2000-05-23'),
(8, 8, 19, NULL, 137, 9, '2000-05-23'),
(25, 6, 19, NULL, 137, 9, '2000-05-23'),
(36, 4, 19, NULL, 137, 9, '2000-05-23'),
(10, 3, 19, NULL, 137, 9, '2000-05-23'),
(42, 1, 17, 5, 138, 9, '2011-02-02'),
(9, 2, 17, 5, 138, 9, '2011-02-02'),
(33, 3, 17, 5, 138, 9, '2011-02-02'),
(7, 4, 17, 5, 138, 9, '2011-02-02'),
(22, 7, 17, 5, 138, 9, '2011-02-02'),
(31, 5, 30, 1, 139, 4, '2010-12-11'),
(15, 3, 30, 1, 139, 4, '2010-12-11'),
(41, 9, 30, 1, 139, 4, '2010-12-11'),
(11, 7, 33, NULL, 140, 3, '2003-05-06'),
(40, 9, 33, NULL, 140, 3, '2003-05-06'),
(37, 6, 4, 2, 141, 2, '2015-09-29'),
(25, 3, 4, 2, 141, 2, '2015-09-29'),
(15, 9, 4, 2, 141, 2, '2015-09-29'),
(41, 2, 4, 2, 141, 2, '2015-09-29'),
(8, 1, 1, NULL, 142, 7, '2014-10-14'),
(35, 3, 1, NULL, 142, 7, '2014-10-14'),
(25, 4, 1, NULL, 142, 7, '2014-10-14'),
(31, 9, 1, NULL, 142, 7, '2014-10-14'),
(30, 6, 1, NULL, 142, 7, '2014-10-14'),
(34, 2, 1, NULL, 142, 7, '2014-10-14'),
(36, 2, 11, 2, 143, 3, '2003-10-07'),
(17, 7, 11, 2, 143, 3, '2003-10-07'),
(27, 3, 11, 2, 143, 3, '2003-10-07'),
(39, 8, 11, 2, 143, 3, '2003-10-07'),
(30, 6, 11, 2, 143, 3, '2003-10-07'),
(1, 4, 13, NULL, 144, 2, '2005-10-08'),
(1, 8, 13, NULL, 144, 2, '2005-10-08'),
(6, 3, 13, NULL, 144, 2, '2005-10-08'),
(40, 1, 13, NULL, 144, 2, '2005-10-08'),
(28, 4, 14, NULL, 145, 6, '2007-01-13'),
(34, 2, 14, NULL, 145, 6, '2007-01-13'),
(40, 7, 14, NULL, 145, 6, '2007-01-13'),
(26, 1, 14, NULL, 145, 6, '2007-01-13'),
(10, 9, 14, NULL, 145, 6, '2007-01-13'),
(18, 2, 3, 5, 146, 10, '2011-11-13'),
(14, 7, 3, 5, 146, 10, '2011-11-13'),
(11, 8, 50, 3, 147, 10, '2000-04-30'),
(39, 6, 50, 3, 147, 10, '2000-04-30'),
(1, 7, 50, 3, 147, 10, '2000-04-30'),
(9, 4, 50, 3, 147, 10, '2000-04-30'),
(12, 4, 47, 1, 148, 5, '2010-03-08'),
(41, 2, 47, 1, 148, 5, '2010-03-08'),
(23, 8, 47, 1, 148, 5, '2010-03-08'),
(4, 7, 47, 1, 148, 5, '2010-03-08'),
(10, 5, 47, 1, 148, 5, '2010-03-08'),
(11, 8, 10, 4, 149, 3, '2002-12-22'),
(21, 2, 1, NULL, 150, 6, '2016-01-17'),
(3, 8, 13, NULL, 151, 1, '2020-10-14'),
(25, 2, 13, NULL, 151, 1, '2020-10-14'),
(29, 3, 13, NULL, 151, 1, '2020-10-14'),
(6, 2, 7, 5, 152, 8, '2005-02-04'),
(15, 4, 7, 5, 152, 8, '2005-02-04'),
(38, 3, 7, 5, 152, 8, '2005-02-04'),
(38, 5, 7, 5, 152, 8, '2005-02-04'),
(42, 9, 7, 5, 152, 8, '2005-02-04'),
(39, 9, 46, 1, 153, 9, '2014-12-21'),
(2, 8, 46, 1, 153, 9, '2014-12-21'),
(1, 5, 46, 1, 153, 9, '2014-12-21'),
(27, 3, 26, NULL, 154, 6, '2005-05-16'),
(35, 5, 26, NULL, 154, 6, '2005-05-16'),
(1, 7, 26, NULL, 154, 6, '2005-05-16'),
(40, 4, 26, NULL, 154, 6, '2005-05-16'),
(6, 2, 29, 5, 155, 3, '2008-10-12'),
(16, 3, 29, 5, 155, 3, '2008-10-12'),
(41, 1, 29, 5, 155, 3, '2008-10-12'),
(41, 6, 29, 5, 155, 3, '2008-10-12'),
(11, 4, 50, NULL, 156, 6, '2010-10-23'),
(36, 5, 11, NULL, 157, 7, '2015-08-28'),
(21, 8, 11, NULL, 157, 7, '2015-08-28'),
(3, 1, 11, NULL, 157, 7, '2015-08-28'),
(42, 7, 11, NULL, 157, 7, '2015-08-28'),
(7, 2, 11, NULL, 157, 7, '2015-08-28'),
(7, 4, 11, NULL, 157, 7, '2015-08-28'),
(21, 6, 2, 5, 158, 9, '2015-05-03'),
(17, 1, 2, 5, 158, 9, '2015-05-03'),
(19, 7, 2, 5, 158, 9, '2015-05-03'),
(38, 2, 2, 5, 158, 9, '2015-05-03'),
(10, 9, 2, 5, 158, 9, '2015-05-03'),
(33, 4, 2, 5, 158, 9, '2015-05-03'),
(30, 3, 2, 5, 158, 9, '2015-05-03'),
(13, 4, 27, 4, 159, 5, '2017-02-26'),
(39, 1, 2, 5, 160, 8, '2009-02-05'),
(16, 7, 2, 5, 160, 8, '2009-02-05'),
(12, 8, 2, 5, 160, 8, '2009-02-05'),
(12, 4, 31, NULL, 161, 2, '2006-10-28'),
(37, 7, 31, NULL, 161, 2, '2006-10-28'),
(7, 1, 31, NULL, 161, 2, '2006-10-28'),
(20, 7, 19, NULL, 162, 5, '2015-11-29'),
(1, 9, 37, 1, 163, 1, '2005-08-14'),
(6, 8, 37, 1, 163, 1, '2005-08-14'),
(15, 5, 37, 1, 163, 1, '2005-08-14'),
(20, 4, 26, 3, 164, 6, '2012-04-07'),
(15, 9, 26, 3, 164, 6, '2012-04-07'),
(40, 8, 26, 3, 164, 6, '2012-04-07'),
(11, 1, 26, 3, 164, 6, '2012-04-07'),
(7, 2, 26, 3, 164, 6, '2012-04-07'),
(10, 3, 26, 3, 164, 6, '2012-04-07'),
(39, 9, 40, 1, 165, 3, '2011-07-11'),
(29, 4, 40, 1, 165, 3, '2011-07-11'),
(31, 3, 40, 1, 165, 3, '2011-07-11'),
(9, 9, 3, NULL, 166, 3, '2005-10-21'),
(38, 6, 3, NULL, 166, 3, '2005-10-21'),
(15, 6, 7, NULL, 167, 3, '2014-01-01'),
(15, 3, 7, NULL, 167, 3, '2014-01-01'),
(23, 2, 7, NULL, 167, 3, '2014-01-01'),
(13, 9, 19, 1, 168, 4, '2014-10-16'),
(17, 5, 19, 1, 168, 4, '2014-10-16'),
(42, 2, 19, 1, 168, 4, '2014-10-16'),
(15, 4, 19, 1, 168, 4, '2014-10-16'),
(1, 3, 19, 1, 168, 4, '2014-10-16'),
(5, 8, 19, 1, 168, 4, '2014-10-16'),
(37, 8, 19, NULL, 169, 2, '2000-06-07'),
(11, 7, 19, NULL, 169, 2, '2000-06-07'),
(28, 3, 19, NULL, 169, 2, '2000-06-07'),
(15, 6, 19, NULL, 169, 2, '2000-06-07'),
(21, 9, 19, NULL, 169, 2, '2000-06-07'),
(27, 1, 14, 4, 170, 4, '2012-05-07'),
(36, 9, 26, NULL, 171, 1, '2002-11-18'),
(18, 7, 26, NULL, 171, 1, '2002-11-18'),
(17, 3, 26, NULL, 171, 1, '2002-11-18'),
(35, 4, 26, NULL, 171, 1, '2002-11-18'),
(36, 2, 26, NULL, 171, 1, '2002-11-18'),
(6, 6, 26, NULL, 171, 1, '2002-11-18'),
(30, 5, 49, NULL, 172, 8, '2003-02-01'),
(14, 1, 49, NULL, 172, 8, '2003-02-01'),
(29, 7, 49, NULL, 172, 8, '2003-02-01'),
(2, 9, 45, 3, 173, 2, '2020-04-25'),
(9, 8, 45, 3, 173, 2, '2020-04-25'),
(37, 1, 45, 3, 173, 2, '2020-04-25'),
(14, 4, 45, 3, 173, 2, '2020-04-25'),
(42, 3, 45, 3, 173, 2, '2020-04-25'),
(5, 2, 45, 3, 173, 2, '2020-04-25'),
(41, 3, 3, NULL, 174, 2, '2012-10-06'),
(2, 1, 3, NULL, 174, 2, '2012-10-06'),
(17, 2, 3, NULL, 174, 2, '2012-10-06'),
(42, 4, 3, NULL, 174, 2, '2012-10-06'),
(41, 7, 6, NULL, 175, 7, '2007-05-16'),
(22, 1, 6, NULL, 175, 7, '2007-05-16'),
(26, 5, 6, NULL, 175, 7, '2007-05-16'),
(8, 6, 6, NULL, 175, 7, '2007-05-16'),
(18, 2, 6, NULL, 175, 7, '2007-05-16'),
(19, 7, 46, NULL, 176, 3, '2004-05-10'),
(22, 4, 46, NULL, 176, 3, '2004-05-10'),
(22, 6, 23, NULL, 177, 6, '2009-04-28'),
(13, 1, 23, NULL, 177, 6, '2009-04-28'),
(10, 8, 23, NULL, 177, 6, '2009-04-28'),
(42, 3, 23, NULL, 177, 6, '2009-04-28'),
(39, 3, 21, 3, 178, 10, '2000-12-15'),
(34, 8, 21, 3, 178, 10, '2000-12-15'),
(11, 7, 21, 3, 178, 10, '2000-12-15'),
(9, 1, 21, 3, 178, 10, '2000-12-15'),
(4, 5, 21, 3, 178, 10, '2000-12-15'),
(29, 9, 21, 3, 178, 10, '2000-12-15'),
(40, 9, 50, NULL, 179, 8, '2016-08-26'),
(18, 7, 50, NULL, 179, 8, '2016-08-26'),
(15, 5, 50, NULL, 179, 8, '2016-08-26'),
(27, 7, 46, 5, 180, 1, '2021-12-14'),
(34, 2, 46, 5, 180, 1, '2021-12-14'),
(9, 1, 46, 5, 180, 1, '2021-12-14'),
(26, 3, 42, 5, 181, 3, '2007-12-21'),
(34, 2, 42, 5, 181, 3, '2007-12-21'),
(29, 7, 42, 5, 181, 3, '2007-12-21'),
(22, 9, 42, 5, 181, 3, '2007-12-21'),
(14, 5, 26, NULL, 182, 1, '2006-12-07'),
(7, 4, 26, NULL, 182, 1, '2006-12-07'),
(17, 9, 26, NULL, 182, 1, '2006-12-07'),
(12, 8, 26, NULL, 182, 1, '2006-12-07'),
(23, 6, 26, NULL, 182, 1, '2006-12-07'),
(21, 3, 26, NULL, 182, 1, '2006-12-07'),
(17, 2, 2, NULL, 183, 1, '2014-04-18'),
(20, 4, 2, NULL, 183, 1, '2014-04-18'),
(29, 5, 2, NULL, 183, 1, '2014-04-18'),
(32, 6, 2, NULL, 183, 1, '2014-04-18'),
(4, 5, 4, 4, 184, 9, '2009-05-11'),
(32, 7, 4, 4, 184, 9, '2009-05-11'),
(9, 9, 13, NULL, 185, 9, '2009-07-28'),
(41, 3, 13, NULL, 185, 9, '2009-07-28'),
(17, 1, 13, NULL, 185, 9, '2009-07-28'),
(28, 8, 13, NULL, 185, 9, '2009-07-28'),
(35, 7, 13, NULL, 185, 9, '2009-07-28'),
(9, 1, 48, NULL, 186, 8, '2011-06-17'),
(33, 6, 2, 4, 187, 7, '2012-11-23'),
(8, 5, 2, 4, 187, 7, '2012-11-23'),
(37, 5, 7, 2, 188, 2, '2003-04-05'),
(27, 8, 25, 4, 189, 10, '2011-10-18'),
(30, 1, 25, 4, 189, 10, '2011-10-18'),
(19, 7, 43, NULL, 190, 3, '2004-07-27'),
(40, 4, 43, NULL, 190, 3, '2004-07-27'),
(34, 2, 43, NULL, 190, 3, '2004-07-27'),
(32, 9, 43, NULL, 190, 3, '2004-07-27'),
(17, 1, 49, NULL, 191, 6, '2015-03-13'),
(15, 2, 49, NULL, 191, 6, '2015-03-13'),
(6, 3, 4, 1, 192, 7, '2001-07-26'),
(38, 5, 4, 1, 192, 7, '2001-07-26'),
(22, 9, 17, NULL, 193, 2, '2007-07-13'),
(38, 4, 17, NULL, 193, 2, '2007-07-13'),
(17, 6, 38, NULL, 194, 7, '2008-03-07'),
(19, 8, 38, NULL, 194, 7, '2008-03-07'),
(6, 3, 44, 5, 195, 1, '2003-08-24'),
(13, 7, 44, 5, 195, 1, '2003-08-24'),
(12, 6, 44, 5, 195, 1, '2003-08-24'),
(35, 1, 44, 5, 195, 1, '2003-08-24'),
(22, 2, 29, NULL, 196, 9, '2013-12-03'),
(2, 8, 29, NULL, 196, 9, '2013-12-03'),
(27, 5, 29, NULL, 196, 9, '2013-12-03'),
(7, 7, 29, NULL, 196, 9, '2013-12-03'),
(41, 8, 20, 3, 197, 1, '2017-03-13'),
(26, 7, 20, 3, 197, 1, '2017-03-13'),
(40, 3, 20, 3, 197, 1, '2017-03-13'),
(1, 2, 20, 3, 197, 1, '2017-03-13'),
(12, 6, 20, 3, 197, 1, '2017-03-13'),
(32, 9, 46, 1, 198, 4, '2019-02-23'),
(25, 7, 46, 1, 198, 4, '2019-02-23'),
(6, 6, 46, 1, 198, 4, '2019-02-23'),
(38, 3, 46, 1, 198, 4, '2019-02-23'),
(42, 5, 46, 1, 198, 4, '2019-02-23'),
(10, 2, 46, 1, 198, 4, '2019-02-23'),
(7, 1, 46, 1, 198, 4, '2019-02-23'),
(35, 2, 34, NULL, 199, 4, '2004-09-26'),
(3, 6, 34, NULL, 199, 4, '2004-09-26'),
(19, 8, 34, NULL, 199, 4, '2004-09-26'),
(9, 9, 34, NULL, 199, 4, '2004-09-26'),
(28, 4, 37, NULL, 200, 6, '2014-08-27'),
(28, 3, 37, NULL, 200, 6, '2014-08-27'),
(13, 1, 37, NULL, 200, 6, '2014-08-27'),
(25, 8, 37, NULL, 200, 6, '2014-08-27'),
(34, 6, 30, NULL, 201, 9, '2014-09-22'),
(24, 9, 30, NULL, 201, 9, '2014-09-22'),
(17, 7, 30, NULL, 201, 9, '2014-09-22'),
(1, 2, 22, NULL, 202, 3, '2013-11-24'),
(9, 3, 22, NULL, 202, 3, '2013-11-24'),
(33, 5, 22, NULL, 202, 3, '2013-11-24'),
(18, 4, 22, NULL, 202, 3, '2013-11-24'),
(10, 7, 22, NULL, 202, 3, '2013-11-24'),
(10, 1, 23, NULL, 203, 2, '2011-03-23'),
(37, 8, 23, NULL, 203, 2, '2011-03-23'),
(24, 9, 23, NULL, 203, 2, '2011-03-23'),
(39, 3, 23, NULL, 203, 2, '2011-03-23'),
(21, 5, 23, NULL, 203, 2, '2011-03-23'),
(15, 4, 23, NULL, 203, 2, '2011-03-23'),
(16, 6, 17, NULL, 204, 3, '2020-03-23'),
(2, 2, 17, NULL, 204, 3, '2020-03-23'),
(20, 1, 17, NULL, 204, 3, '2020-03-23'),
(13, 4, 17, NULL, 204, 3, '2020-03-23'),
(24, 3, 36, 5, 205, 9, '2001-02-08'),
(32, 4, 36, 5, 205, 9, '2001-02-08'),
(9, 5, 36, 5, 205, 9, '2001-02-08'),
(9, 1, 36, 5, 205, 9, '2001-02-08'),
(4, 2, 36, 5, 205, 9, '2001-02-08'),
(22, 1, 47, 1, 206, 2, '2001-12-31'),
(40, 3, 47, 1, 206, 2, '2001-12-31'),
(2, 9, 47, 1, 206, 2, '2001-12-31'),
(13, 5, 9, NULL, 207, 7, '2004-02-27'),
(38, 8, 9, NULL, 207, 7, '2004-02-27'),
(21, 2, 9, NULL, 207, 7, '2004-02-27'),
(6, 6, 9, NULL, 207, 7, '2004-02-27'),
(36, 3, 34, NULL, 208, 7, '2008-07-01'),
(17, 2, 34, NULL, 208, 7, '2008-07-01'),
(39, 8, 34, NULL, 208, 7, '2008-07-01'),
(12, 1, 34, NULL, 208, 7, '2008-07-01'),
(5, 6, 34, NULL, 208, 7, '2008-07-01'),
(11, 4, 34, NULL, 208, 7, '2008-07-01'),
(19, 7, 46, 3, 209, 5, '2016-11-18'),
(3, 2, 9, 5, 210, 8, '2011-05-22'),
(10, 8, 9, 5, 210, 8, '2011-05-22'),
(30, 9, 12, NULL, 211, 3, '2007-04-27'),
(3, 8, 12, NULL, 211, 3, '2007-04-27'),
(26, 7, 12, NULL, 211, 3, '2007-04-27'),
(21, 4, 12, NULL, 211, 3, '2007-04-27'),
(25, 2, 12, NULL, 211, 3, '2007-04-27'),
(28, 1, 12, NULL, 211, 3, '2007-04-27'),
(1, 5, 3, NULL, 212, 5, '2020-10-13'),
(17, 1, 3, NULL, 212, 5, '2020-10-13'),
(11, 2, 3, NULL, 212, 5, '2020-10-13'),
(23, 3, 3, NULL, 212, 5, '2020-10-13'),
(40, 4, 3, NULL, 212, 5, '2020-10-13'),
(28, 6, 3, NULL, 212, 5, '2020-10-13'),
(38, 1, 49, NULL, 213, 10, '2020-06-13'),
(33, 4, 49, NULL, 213, 10, '2020-06-13'),
(22, 2, 49, NULL, 213, 10, '2020-06-13'),
(40, 7, 49, NULL, 213, 10, '2020-06-13'),
(3, 5, 49, NULL, 213, 10, '2020-06-13'),
(36, 6, 49, NULL, 213, 10, '2020-06-13'),
(34, 9, 14, NULL, 214, 7, '2016-12-19'),
(20, 3, 14, NULL, 214, 7, '2016-12-19'),
(26, 7, 14, NULL, 214, 7, '2016-12-19'),
(4, 5, 34, 3, 215, 2, '2021-05-31'),
(29, 3, 34, 3, 215, 2, '2021-05-31'),
(39, 4, 34, 3, 215, 2, '2021-05-31'),
(3, 6, 34, 3, 215, 2, '2021-05-31'),
(23, 1, 10, NULL, 216, 3, '2014-08-10'),
(29, 2, 10, NULL, 216, 3, '2014-08-10'),
(38, 3, 10, NULL, 216, 3, '2014-08-10'),
(30, 9, 10, NULL, 216, 3, '2014-08-10'),
(10, 6, 10, NULL, 216, 3, '2014-08-10'),
(39, 9, 36, 3, 217, 8, '2018-06-22'),
(16, 8, 36, 3, 217, 8, '2018-06-22'),
(17, 4, 36, 3, 217, 8, '2018-06-22'),
(1, 2, 36, 3, 217, 8, '2018-06-22'),
(29, 7, 21, NULL, 218, 7, '2018-01-21'),
(1, 9, 21, NULL, 218, 7, '2018-01-21'),
(23, 8, 21, NULL, 218, 7, '2018-01-21'),
(3, 5, 21, NULL, 218, 7, '2018-01-21'),
(8, 6, 21, NULL, 218, 7, '2018-01-21'),
(2, 2, 5, NULL, 219, 4, '2006-11-07'),
(16, 4, 5, NULL, 219, 4, '2006-11-07'),
(40, 5, 5, NULL, 219, 4, '2006-11-07'),
(4, 6, 5, NULL, 219, 4, '2006-11-07'),
(18, 7, 15, 3, 220, 5, '2010-05-14'),
(17, 9, 15, 3, 220, 5, '2010-05-14'),
(36, 4, 15, 3, 220, 5, '2010-05-14'),
(5, 2, 15, 3, 220, 5, '2010-05-14'),
(38, 8, 15, 3, 220, 5, '2010-05-14'),
(38, 1, 15, 3, 220, 5, '2010-05-14'),
(2, 7, 5, 4, 221, 5, '2021-01-22'),
(11, 5, 5, 4, 221, 5, '2021-01-22'),
(1, 4, 5, 4, 221, 5, '2021-01-22'),
(7, 9, 5, 4, 221, 5, '2021-01-22'),
(28, 7, 31, NULL, 222, 1, '2021-01-01'),
(17, 2, 3, NULL, 223, 2, '2019-06-09'),
(20, 6, 3, NULL, 223, 2, '2019-06-09'),
(40, 1, 3, NULL, 223, 2, '2019-06-09'),
(15, 9, 3, NULL, 223, 2, '2019-06-09'),
(33, 6, 31, 1, 224, 2, '2011-04-30'),
(3, 3, 31, 1, 224, 2, '2011-04-30'),
(36, 7, 31, 1, 224, 2, '2011-04-30'),
(16, 8, 31, 1, 224, 2, '2011-04-30'),
(32, 2, 31, 1, 224, 2, '2011-04-30'),
(24, 2, 24, 1, 225, 4, '2013-01-04'),
(23, 5, 24, 1, 225, 4, '2013-01-04'),
(20, 9, 2, 3, 226, 8, '2002-04-08'),
(15, 6, 2, 3, 226, 8, '2002-04-08'),
(36, 5, 2, 3, 226, 8, '2002-04-08'),
(25, 9, 4, 5, 227, 7, '2018-02-06'),
(40, 5, 4, 5, 227, 7, '2018-02-06'),
(34, 8, 4, 5, 227, 7, '2018-02-06'),
(10, 6, 7, 3, 228, 10, '2016-01-07'),
(30, 9, 7, 3, 228, 10, '2016-01-07'),
(14, 7, 7, 3, 228, 10, '2016-01-07'),
(3, 1, 33, NULL, 229, 3, '2011-09-08'),
(16, 5, 33, NULL, 229, 3, '2011-09-08'),
(25, 7, 33, NULL, 229, 3, '2011-09-08'),
(22, 3, 43, 1, 230, 1, '2000-06-06'),
(38, 8, 43, 1, 230, 1, '2000-06-06'),
(30, 9, 43, 1, 230, 1, '2000-06-06'),
(16, 7, 43, 1, 230, 1, '2000-06-06'),
(21, 5, 43, 1, 230, 1, '2000-06-06'),
(31, 6, 43, 1, 230, 1, '2000-06-06'),
(33, 1, 43, 1, 230, 1, '2000-06-06'),
(3, 2, 43, 1, 230, 1, '2000-06-06'),
(31, 7, 29, NULL, 231, 10, '2013-09-14'),
(14, 6, 29, NULL, 231, 10, '2013-09-14'),
(5, 8, 29, NULL, 231, 10, '2013-09-14'),
(28, 3, 29, NULL, 231, 10, '2013-09-14'),
(18, 5, 29, NULL, 231, 10, '2013-09-14'),
(15, 8, 41, NULL, 232, 10, '2005-10-08'),
(15, 6, 41, NULL, 232, 10, '2005-10-08'),
(12, 7, 41, NULL, 232, 10, '2005-10-08'),
(18, 9, 44, 4, 233, 1, '2008-05-11'),
(9, 6, 44, 4, 233, 1, '2008-05-11'),
(41, 5, 32, 5, 234, 1, '2017-03-20'),
(29, 8, 32, 5, 234, 1, '2017-03-20'),
(36, 1, 32, 5, 234, 1, '2017-03-20'),
(18, 1, 18, 5, 235, 8, '2007-03-13'),
(8, 9, 18, 5, 235, 8, '2007-03-13'),
(41, 7, 18, 5, 235, 8, '2007-03-13'),
(14, 5, 18, 5, 235, 8, '2007-03-13'),
(20, 6, 18, 5, 235, 8, '2007-03-13'),
(1, 3, 4, 3, 236, 7, '2019-07-12'),
(23, 8, 4, 3, 236, 7, '2019-07-12'),
(18, 5, 4, 3, 236, 7, '2019-07-12'),
(32, 4, 4, 3, 236, 7, '2019-07-12'),
(31, 2, 4, 3, 236, 7, '2019-07-12'),
(10, 1, 10, 2, 237, 5, '2015-06-18'),
(9, 9, 10, 2, 237, 5, '2015-06-18'),
(38, 3, 10, 2, 237, 5, '2015-06-18'),
(36, 8, 10, 2, 237, 5, '2015-06-18'),
(19, 6, 8, NULL, 238, 8, '2009-02-22'),
(21, 8, 8, NULL, 238, 8, '2009-02-22'),
(21, 7, 8, NULL, 238, 8, '2009-02-22'),
(41, 1, 24, 5, 239, 4, '2017-01-25'),
(16, 3, 24, 5, 239, 4, '2017-01-25'),
(39, 7, 24, 5, 239, 4, '2017-01-25'),
(6, 4, 24, 5, 239, 4, '2017-01-25'),
(3, 8, 24, 5, 239, 4, '2017-01-25'),
(22, 6, 8, NULL, 240, 7, '2019-09-18'),
(26, 8, 8, NULL, 240, 7, '2019-09-18'),
(5, 1, 8, NULL, 240, 7, '2019-09-18'),
(24, 7, 8, NULL, 240, 7, '2019-09-18'),
(22, 2, 8, NULL, 240, 7, '2019-09-18'),
(16, 4, 8, NULL, 240, 7, '2019-09-18'),
(18, 5, 43, NULL, 241, 10, '2003-09-22'),
(39, 1, 43, NULL, 241, 10, '2003-09-22'),
(39, 8, 43, NULL, 241, 10, '2003-09-22'),
(34, 4, 43, NULL, 241, 10, '2003-09-22'),
(18, 2, 43, NULL, 241, 10, '2003-09-22'),
(22, 9, 43, NULL, 241, 10, '2003-09-22'),
(13, 8, 36, 4, 242, 4, '2019-04-05'),
(41, 6, 36, 4, 242, 4, '2019-04-05'),
(33, 3, 36, 4, 242, 4, '2019-04-05'),
(38, 1, 36, 4, 242, 4, '2019-04-05'),
(2, 4, 14, 5, 243, 8, '2020-01-29'),
(39, 5, 14, 5, 243, 8, '2020-01-29'),
(39, 8, 14, 5, 243, 8, '2020-01-29'),
(13, 1, 6, NULL, 244, 9, '2015-09-16'),
(23, 5, 6, NULL, 244, 9, '2015-09-16'),
(41, 7, 6, NULL, 244, 9, '2015-09-16'),
(31, 2, 6, NULL, 244, 9, '2015-09-16'),
(11, 8, 6, NULL, 244, 9, '2015-09-16'),
(8, 9, 6, NULL, 244, 9, '2015-09-16'),
(3, 3, 35, 5, 245, 10, '2011-09-16'),
(42, 5, 35, 5, 245, 10, '2011-09-16'),
(28, 6, 35, 5, 245, 10, '2011-09-16'),
(28, 4, 35, 5, 245, 10, '2011-09-16'),
(12, 7, 35, 5, 245, 10, '2011-09-16'),
(28, 1, 35, 5, 245, 10, '2011-09-16'),
(1, 9, 35, 5, 245, 10, '2011-09-16'),
(2, 8, 19, 5, 246, 10, '2013-08-29'),
(28, 4, 19, 5, 246, 10, '2013-08-29'),
(22, 5, 19, 5, 246, 10, '2013-08-29'),
(10, 9, 35, NULL, 247, 2, '2015-09-17'),
(7, 2, 35, NULL, 247, 2, '2015-09-17'),
(31, 1, 35, NULL, 247, 2, '2015-09-17'),
(31, 7, 35, NULL, 247, 2, '2015-09-17'),
(17, 9, 41, NULL, 248, 6, '2007-11-24'),
(23, 2, 41, NULL, 248, 6, '2007-11-24'),
(31, 8, 30, NULL, 249, 6, '2013-07-29'),
(35, 5, 30, NULL, 249, 6, '2013-07-29'),
(19, 4, 30, NULL, 249, 6, '2013-07-29'),
(5, 7, 30, NULL, 249, 6, '2013-07-29'),
(25, 2, 1, NULL, 250, 9, '2003-12-15'),
(11, 5, 1, NULL, 250, 9, '2003-12-15'),
(8, 6, 1, NULL, 250, 9, '2003-12-15'),
(8, 8, 1, NULL, 250, 9, '2003-12-15'),
(13, 1, 1, NULL, 250, 9, '2003-12-15'),
(42, 3, 1, NULL, 250, 9, '2003-12-15'),
(11, 4, 1, NULL, 250, 9, '2003-12-15'),
(42, 5, 43, NULL, 251, 10, '2008-07-23'),
(3, 8, 27, NULL, 252, 2, '2003-10-19'),
(7, 3, 27, NULL, 252, 2, '2003-10-19'),
(31, 6, 27, NULL, 252, 2, '2003-10-19'),
(35, 7, 27, NULL, 252, 2, '2003-10-19'),
(22, 1, 27, NULL, 252, 2, '2003-10-19'),
(20, 5, 27, NULL, 252, 2, '2003-10-19'),
(29, 2, 27, NULL, 252, 2, '2003-10-19'),
(39, 4, 27, NULL, 252, 2, '2003-10-19'),
(37, 8, 35, 4, 253, 1, '2009-11-15'),
(21, 1, 35, 4, 253, 1, '2009-11-15'),
(18, 7, 35, 4, 253, 1, '2009-11-15'),
(17, 4, 35, 4, 253, 1, '2009-11-15'),
(7, 3, 35, 4, 253, 1, '2009-11-15'),
(31, 6, 35, 4, 253, 1, '2009-11-15'),
(25, 6, 8, 1, 254, 5, '2019-05-21'),
(21, 7, 8, 1, 254, 5, '2019-05-21'),
(15, 2, 8, 1, 254, 5, '2019-05-21'),
(39, 1, 38, 2, 255, 6, '2009-09-15'),
(10, 5, 38, 2, 255, 6, '2009-09-15'),
(11, 4, 38, 2, 255, 6, '2009-09-15'),
(4, 3, 38, 2, 255, 6, '2009-09-15'),
(21, 3, 28, 4, 256, 10, '2012-08-10'),
(26, 9, 28, 4, 256, 10, '2012-08-10'),
(20, 2, 28, 4, 256, 10, '2012-08-10'),
(18, 5, 28, 4, 256, 10, '2012-08-10'),
(33, 8, 41, 1, 257, 8, '2021-04-10'),
(11, 7, 20, 2, 258, 5, '2014-07-27'),
(6, 4, 20, 2, 258, 5, '2014-07-27'),
(20, 1, 20, 2, 258, 5, '2014-07-27'),
(2, 2, 20, 2, 258, 5, '2014-07-27'),
(39, 5, 40, 4, 259, 4, '2019-04-11'),
(20, 7, 40, 4, 259, 4, '2019-04-11'),
(20, 9, 40, 4, 259, 4, '2019-04-11'),
(41, 4, 40, 4, 259, 4, '2019-04-11'),
(24, 8, 40, 4, 259, 4, '2019-04-11'),
(10, 1, 40, 4, 259, 4, '2019-04-11'),
(34, 3, 45, NULL, 260, 7, '2013-04-02'),
(7, 4, 45, NULL, 260, 7, '2013-04-02'),
(21, 7, 17, NULL, 261, 8, '2002-08-25'),
(20, 5, 17, NULL, 261, 8, '2002-08-25'),
(35, 9, 17, NULL, 261, 8, '2002-08-25'),
(30, 6, 17, NULL, 261, 8, '2002-08-25'),
(8, 1, 17, NULL, 261, 8, '2002-08-25'),
(20, 2, 33, NULL, 262, 4, '2001-09-07'),
(26, 9, 48, NULL, 263, 5, '2002-11-12'),
(26, 4, 48, NULL, 263, 5, '2002-11-12'),
(11, 6, 48, NULL, 263, 5, '2002-11-12'),
(13, 8, 48, NULL, 263, 5, '2002-11-12'),
(6, 3, 48, NULL, 263, 5, '2002-11-12'),
(34, 5, 48, NULL, 263, 5, '2002-11-12'),
(41, 6, 13, 5, 264, 3, '2013-12-09'),
(29, 7, 13, 5, 264, 3, '2013-12-09'),
(21, 2, 13, 5, 265, 8, '2011-01-23'),
(8, 5, 13, 5, 265, 8, '2011-01-23'),
(27, 1, 13, 5, 265, 8, '2011-01-23'),
(17, 8, 13, 5, 265, 8, '2011-01-23'),
(17, 4, 13, 5, 265, 8, '2011-01-23'),
(20, 1, 46, 2, 266, 5, '2018-03-20'),
(1, 7, 46, 2, 266, 5, '2018-03-20'),
(31, 4, 46, 2, 266, 5, '2018-03-20'),
(33, 7, 41, NULL, 267, 3, '2005-11-28'),
(2, 1, 44, NULL, 268, 2, '2000-06-30'),
(4, 8, 44, NULL, 268, 2, '2000-06-30'),
(1, 3, 31, 5, 269, 2, '2012-03-04'),
(39, 7, 31, 5, 269, 2, '2012-03-04'),
(3, 1, 47, 1, 270, 1, '2004-11-11'),
(38, 5, 47, 1, 270, 1, '2004-11-11'),
(3, 2, 47, 1, 270, 1, '2004-11-11'),
(38, 5, 4, 2, 271, 4, '2019-04-05'),
(35, 9, 4, 2, 271, 4, '2019-04-05'),
(19, 7, 24, NULL, 272, 7, '2017-06-17'),
(7, 9, 24, NULL, 272, 7, '2017-06-17'),
(18, 5, 24, NULL, 272, 7, '2017-06-17'),
(41, 4, 24, NULL, 272, 7, '2017-06-17'),
(13, 7, 24, 2, 273, 8, '2002-10-07'),
(5, 3, 24, 2, 273, 8, '2002-10-07'),
(39, 6, 24, 2, 273, 8, '2002-10-07'),
(12, 9, 26, NULL, 274, 6, '2009-11-09'),
(10, 5, 26, NULL, 274, 6, '2009-11-09'),
(29, 4, 26, NULL, 274, 6, '2009-11-09'),
(28, 1, 26, NULL, 274, 6, '2009-11-09'),
(24, 5, 49, NULL, 275, 6, '2019-05-03'),
(38, 3, 49, NULL, 275, 6, '2019-05-03'),
(6, 7, 49, NULL, 275, 6, '2019-05-03'),
(24, 9, 49, NULL, 275, 6, '2019-05-03'),
(34, 9, 1, 4, 276, 6, '2015-09-03'),
(31, 5, 1, 4, 276, 6, '2015-09-03'),
(5, 3, 1, 4, 276, 6, '2015-09-03'),
(16, 8, 48, 4, 277, 3, '2003-12-06'),
(41, 6, 48, 4, 277, 3, '2003-12-06'),
(15, 4, 48, 4, 277, 3, '2003-12-06'),
(34, 9, 48, 4, 277, 3, '2003-12-06'),
(16, 5, 35, 4, 278, 4, '2005-07-08'),
(7, 7, 35, 4, 278, 4, '2005-07-08'),
(17, 8, 35, 4, 278, 4, '2005-07-08'),
(9, 1, 35, 4, 278, 4, '2005-07-08'),
(18, 2, 35, 4, 278, 4, '2005-07-08'),
(22, 3, 35, 4, 278, 4, '2005-07-08'),
(10, 5, 47, NULL, 279, 4, '2009-06-19'),
(35, 4, 47, NULL, 279, 4, '2009-06-19'),
(24, 4, 47, 4, 280, 2, '2004-08-22'),
(32, 5, 47, 4, 280, 2, '2004-08-22'),
(40, 6, 47, 4, 280, 2, '2004-08-22'),
(23, 7, 47, 4, 280, 2, '2004-08-22'),
(27, 1, 47, 4, 280, 2, '2004-08-22'),
(31, 2, 47, 4, 280, 2, '2004-08-22'),
(24, 8, 10, 2, 281, 7, '2008-06-21'),
(19, 6, 10, 2, 281, 7, '2008-06-21'),
(34, 7, 13, NULL, 282, 2, '2004-04-22'),
(40, 9, 13, NULL, 282, 2, '2004-04-22'),
(2, 1, 13, NULL, 282, 2, '2004-04-22'),
(2, 5, 13, NULL, 282, 2, '2004-04-22'),
(5, 2, 13, NULL, 282, 2, '2004-04-22'),
(6, 9, 30, NULL, 283, 6, '2018-04-25'),
(34, 8, 30, NULL, 283, 6, '2018-04-25'),
(40, 5, 30, NULL, 283, 6, '2018-04-25'),
(22, 4, 30, NULL, 283, 6, '2018-04-25'),
(29, 6, 30, NULL, 283, 6, '2018-04-25'),
(13, 2, 13, NULL, 284, 10, '2006-06-30'),
(33, 8, 13, NULL, 284, 10, '2006-06-30'),
(21, 9, 13, NULL, 284, 10, '2006-06-30'),
(13, 1, 13, NULL, 284, 10, '2006-06-30'),
(3, 7, 14, 3, 285, 2, '2013-02-22'),
(2, 8, 14, 3, 285, 2, '2013-02-22'),
(12, 3, 18, 1, 286, 9, '2016-12-21'),
(33, 2, 18, 1, 286, 9, '2016-12-21'),
(40, 4, 18, 1, 286, 9, '2016-12-21'),
(10, 7, 18, 1, 286, 9, '2016-12-21'),
(28, 5, 42, NULL, 287, 7, '2012-12-14'),
(8, 1, 42, NULL, 287, 7, '2012-12-14'),
(35, 8, 42, NULL, 287, 7, '2012-12-14'),
(23, 3, 42, NULL, 287, 7, '2012-12-14'),
(18, 7, 42, NULL, 287, 7, '2012-12-14'),
(30, 9, 42, NULL, 287, 7, '2012-12-14'),
(20, 1, 30, NULL, 288, 1, '2019-12-01'),
(4, 2, 30, NULL, 288, 1, '2019-12-01'),
(13, 6, 30, NULL, 288, 1, '2019-12-01'),
(1, 7, 18, NULL, 289, 9, '2011-09-12'),
(26, 3, 18, NULL, 289, 9, '2011-09-12'),
(13, 1, 18, NULL, 289, 9, '2011-09-12'),
(33, 2, 9, NULL, 290, 5, '2005-01-13'),
(24, 4, 9, NULL, 290, 5, '2005-01-13'),
(37, 9, 9, NULL, 290, 5, '2005-01-13'),
(33, 1, 33, 1, 291, 6, '2002-01-07'),
(8, 7, 33, 1, 291, 6, '2002-01-07'),
(8, 2, 33, 1, 291, 6, '2002-01-07'),
(13, 8, 33, 1, 291, 6, '2002-01-07'),
(39, 9, 33, 1, 291, 6, '2002-01-07'),
(11, 3, 15, 5, 292, 7, '2008-04-14'),
(16, 5, 15, 5, 292, 7, '2008-04-14'),
(13, 1, 15, 5, 292, 7, '2008-04-14'),
(26, 2, 15, 5, 292, 7, '2008-04-14'),
(24, 7, 15, 5, 292, 7, '2008-04-14'),
(10, 4, 15, 5, 292, 7, '2008-04-14'),
(42, 3, 16, NULL, 293, 9, '2003-01-19'),
(1, 2, 16, NULL, 293, 9, '2003-01-19'),
(18, 5, 16, NULL, 293, 9, '2003-01-19'),
(37, 4, 16, NULL, 293, 9, '2003-01-19'),
(17, 1, 14, NULL, 294, 6, '2002-10-30'),
(27, 9, 14, NULL, 294, 6, '2002-10-30'),
(35, 2, 14, NULL, 294, 6, '2002-10-30'),
(7, 4, 14, NULL, 294, 6, '2002-10-30'),
(8, 4, 34, 3, 295, 6, '2013-05-17'),
(36, 8, 34, 3, 295, 6, '2013-05-17'),
(23, 9, 34, 3, 295, 6, '2013-05-17'),
(5, 5, 34, 3, 295, 6, '2013-05-17'),
(31, 7, 12, 1, 296, 10, '2021-12-04'),
(18, 5, 12, 1, 296, 10, '2021-12-04'),
(5, 8, 12, 1, 296, 10, '2021-12-04'),
(26, 6, 12, 1, 296, 10, '2021-12-04'),
(38, 4, 12, 1, 296, 10, '2021-12-04'),
(4, 4, 24, 1, 297, 9, '2005-07-31'),
(17, 9, 24, 1, 297, 9, '2005-07-31'),
(40, 3, 24, 1, 297, 9, '2005-07-31'),
(10, 6, 24, 1, 297, 9, '2005-07-31'),
(30, 2, 24, 1, 297, 9, '2005-07-31'),
(16, 6, 36, NULL, 298, 6, '2021-01-21'),
(19, 1, 36, NULL, 298, 6, '2021-01-21'),
(30, 7, 36, NULL, 298, 6, '2021-01-21'),
(42, 5, 36, NULL, 298, 6, '2021-01-21'),
(11, 6, 46, NULL, 299, 9, '2003-07-08'),
(40, 7, 46, NULL, 299, 9, '2003-07-08'),
(1, 3, 46, NULL, 299, 9, '2003-07-08'),
(20, 9, 46, NULL, 299, 9, '2003-07-08'),
(11, 8, 46, NULL, 299, 9, '2003-07-08'),
(19, 2, 30, NULL, 300, 4, '2006-03-08'),
(4, 5, 30, NULL, 300, 4, '2006-03-08'),
(12, 6, 30, NULL, 300, 4, '2006-03-08'),
(31, 5, 18, NULL, 301, 2, '2010-07-19'),
(39, 2, 18, NULL, 301, 2, '2010-07-19'),
(41, 3, 18, NULL, 301, 2, '2010-07-19'),
(2, 4, 18, NULL, 301, 2, '2010-07-19'),
(2, 1, 18, NULL, 301, 2, '2010-07-19'),
(34, 7, 18, NULL, 301, 2, '2010-07-19'),
(35, 6, 18, NULL, 301, 2, '2010-07-19'),
(13, 7, 3, NULL, 302, 7, '2018-02-02'),
(10, 6, 3, NULL, 302, 7, '2018-02-02'),
(29, 9, 20, NULL, 303, 1, '2019-03-14'),
(4, 8, 20, NULL, 303, 1, '2019-03-14'),
(37, 3, 40, 3, 304, 5, '2017-07-08'),
(3, 5, 8, 1, 305, 8, '2001-05-26'),
(16, 7, 8, 1, 305, 8, '2001-05-26'),
(2, 6, 8, 1, 305, 8, '2001-05-26'),
(31, 1, 25, NULL, 306, 4, '2019-10-20'),
(33, 2, 25, NULL, 306, 4, '2019-10-20'),
(36, 3, 25, NULL, 306, 4, '2019-10-20'),
(32, 4, 25, NULL, 306, 4, '2019-10-20'),
(13, 5, 25, NULL, 306, 4, '2019-10-20'),
(24, 9, 31, 2, 307, 8, '2008-05-17'),
(37, 1, 31, 2, 307, 8, '2008-05-17'),
(23, 5, 31, 2, 307, 8, '2008-05-17'),
(34, 3, 31, 2, 307, 8, '2008-05-17'),
(11, 6, 36, NULL, 308, 5, '2017-10-27'),
(30, 2, 36, NULL, 308, 5, '2017-10-27'),
(15, 4, 36, NULL, 308, 5, '2017-10-27'),
(11, 1, 36, NULL, 308, 5, '2017-10-27'),
(21, 3, 36, NULL, 308, 5, '2017-10-27'),
(7, 9, 36, NULL, 308, 5, '2017-10-27'),
(40, 7, 36, NULL, 308, 5, '2017-10-27'),
(31, 4, 46, NULL, 309, 3, '2005-08-25'),
(22, 5, 46, NULL, 309, 3, '2005-08-25'),
(30, 8, 39, NULL, 310, 6, '2002-07-30'),
(35, 1, 39, NULL, 310, 6, '2002-07-30'),
(23, 5, 39, NULL, 310, 6, '2002-07-30'),
(41, 6, 39, NULL, 310, 6, '2002-07-30'),
(34, 1, 1, 5, 311, 8, '2015-08-19'),
(3, 7, 1, 5, 311, 8, '2015-08-19'),
(1, 6, 2, 4, 312, 1, '2001-07-03'),
(33, 9, 2, 4, 312, 1, '2001-07-03'),
(7, 1, 2, 4, 312, 1, '2001-07-03'),
(3, 4, 2, 4, 312, 1, '2001-07-03'),
(14, 3, 2, 4, 312, 1, '2001-07-03'),
(3, 7, 2, 4, 312, 1, '2001-07-03'),
(29, 2, 2, 4, 312, 1, '2001-07-03'),
(32, 6, 24, 5, 313, 3, '2006-11-28'),
(16, 3, 24, 5, 313, 3, '2006-11-28'),
(38, 1, 24, 5, 313, 3, '2006-11-28'),
(13, 4, 24, 5, 313, 3, '2006-11-28'),
(12, 9, 24, 5, 313, 3, '2006-11-28'),
(7, 2, 24, 5, 313, 3, '2006-11-28'),
(9, 8, 48, NULL, 314, 6, '2019-04-16'),
(14, 3, 48, NULL, 314, 6, '2019-04-16'),
(25, 6, 45, NULL, 315, 10, '2010-07-26'),
(23, 4, 45, NULL, 315, 10, '2010-07-26'),
(17, 8, 45, NULL, 315, 10, '2010-07-26'),
(15, 2, 45, NULL, 315, 10, '2010-07-26'),
(26, 1, 45, NULL, 315, 10, '2010-07-26'),
(2, 7, 17, NULL, 316, 4, '2004-09-06'),
(5, 4, 17, NULL, 316, 4, '2004-09-06'),
(28, 2, 17, NULL, 316, 4, '2004-09-06'),
(40, 8, 23, 4, 317, 1, '2013-11-25'),
(23, 5, 23, 4, 317, 1, '2013-11-25'),
(13, 2, 23, 4, 317, 1, '2013-11-25'),
(26, 8, 36, NULL, 318, 3, '2010-03-11'),
(29, 1, 36, NULL, 318, 3, '2010-03-11'),
(15, 7, 36, NULL, 318, 3, '2010-03-11'),
(1, 4, 36, 2, 319, 4, '2001-04-14'),
(28, 9, 36, 2, 319, 4, '2001-04-14'),
(19, 7, 36, 1, 320, 5, '2000-10-02'),
(15, 4, 1, 1, 321, 9, '2007-03-21'),
(27, 3, 1, 1, 321, 9, '2007-03-21'),
(11, 1, 1, 1, 321, 9, '2007-03-21'),
(1, 6, 40, 4, 322, 3, '2013-12-28'),
(7, 2, 7, NULL, 323, 4, '2020-04-22'),
(5, 7, 7, NULL, 323, 4, '2020-04-22'),
(33, 4, 7, NULL, 323, 4, '2020-04-22'),
(38, 6, 7, NULL, 323, 4, '2020-04-22'),
(18, 8, 7, NULL, 323, 4, '2020-04-22'),
(7, 5, 7, NULL, 323, 4, '2020-04-22'),
(18, 3, 7, NULL, 323, 4, '2020-04-22'),
(24, 2, 45, 2, 324, 10, '2010-01-21'),
(19, 1, 45, 2, 324, 10, '2010-01-21'),
(5, 7, 45, 2, 324, 10, '2010-01-21'),
(39, 8, 45, 2, 324, 10, '2010-01-21'),
(28, 9, 20, 2, 325, 7, '2013-04-03'),
(6, 1, 20, 2, 325, 7, '2013-04-03'),
(26, 6, 20, 2, 325, 7, '2013-04-03'),
(28, 3, 20, 2, 325, 7, '2013-04-03'),
(36, 8, 20, 2, 325, 7, '2013-04-03'),
(17, 5, 20, 2, 325, 7, '2013-04-03'),
(32, 2, 20, 2, 325, 7, '2013-04-03'),
(5, 7, 10, NULL, 326, 5, '2016-04-30'),
(29, 1, 10, NULL, 326, 5, '2016-04-30'),
(14, 1, 33, NULL, 327, 2, '2014-06-09'),
(8, 3, 33, NULL, 327, 2, '2014-06-09'),
(31, 6, 33, NULL, 327, 2, '2014-06-09'),
(16, 4, 33, NULL, 327, 2, '2014-06-09'),
(18, 2, 33, NULL, 327, 2, '2014-06-09'),
(34, 5, 33, NULL, 327, 2, '2014-06-09'),
(41, 7, 36, NULL, 328, 4, '2016-01-29'),
(13, 6, 36, NULL, 328, 4, '2016-01-29'),
(38, 8, 36, NULL, 328, 4, '2016-01-29'),
(39, 9, 36, NULL, 328, 4, '2016-01-29'),
(25, 2, 28, NULL, 329, 1, '2003-01-04'),
(31, 6, 28, NULL, 329, 1, '2003-01-04'),
(28, 5, 28, NULL, 329, 1, '2003-01-04'),
(1, 8, 28, NULL, 329, 1, '2003-01-04'),
(38, 8, 41, NULL, 330, 8, '2000-01-10'),
(7, 3, 41, NULL, 330, 8, '2000-01-10'),
(28, 1, 41, NULL, 330, 8, '2000-01-10'),
(19, 9, 41, NULL, 330, 8, '2000-01-10'),
(9, 9, 3, NULL, 331, 7, '2019-01-29'),
(29, 5, 3, NULL, 331, 7, '2019-01-29'),
(21, 8, 3, NULL, 331, 7, '2019-01-29'),
(31, 1, 3, NULL, 331, 7, '2019-01-29'),
(37, 2, 3, NULL, 331, 7, '2019-01-29'),
(31, 7, 11, NULL, 332, 2, '2011-09-04'),
(18, 8, 30, 1, 333, 1, '2016-08-29'),
(37, 7, 30, 1, 333, 1, '2016-08-29'),
(42, 2, 30, 1, 333, 1, '2016-08-29'),
(36, 9, 30, 1, 333, 1, '2016-08-29'),
(11, 3, 30, 1, 333, 1, '2016-08-29'),
(19, 7, 19, NULL, 334, 2, '2006-01-09'),
(28, 3, 19, NULL, 334, 2, '2006-01-09'),
(24, 1, 19, NULL, 334, 2, '2006-01-09'),
(3, 8, 19, NULL, 334, 2, '2006-01-09'),
(33, 9, 19, NULL, 334, 2, '2006-01-09'),
(28, 3, 37, NULL, 335, 5, '2021-03-23'),
(2, 6, 37, NULL, 335, 5, '2021-03-23'),
(36, 8, 18, NULL, 336, 1, '2005-12-10'),
(5, 2, 18, NULL, 336, 1, '2005-12-10'),
(25, 5, 18, NULL, 336, 1, '2005-12-10'),
(31, 3, 48, NULL, 337, 4, '2011-03-08'),
(26, 2, 48, NULL, 337, 4, '2011-03-08'),
(1, 8, 48, NULL, 337, 4, '2011-03-08'),
(35, 5, 48, NULL, 337, 4, '2011-03-08'),
(4, 9, 48, NULL, 337, 4, '2011-03-08'),
(30, 5, 34, NULL, 338, 10, '2005-09-30'),
(34, 7, 34, NULL, 338, 10, '2005-09-30'),
(9, 4, 37, 3, 339, 10, '2019-05-18'),
(11, 3, 37, 3, 339, 10, '2019-05-18'),
(39, 2, 37, 3, 339, 10, '2019-05-18'),
(40, 6, 37, 3, 339, 10, '2019-05-18'),
(13, 7, 37, 3, 339, 10, '2019-05-18'),
(28, 6, 40, 5, 340, 10, '2015-03-17'),
(1, 1, 40, 5, 340, 10, '2015-03-17'),
(23, 9, 40, 5, 340, 10, '2015-03-17'),
(16, 5, 40, 5, 340, 10, '2015-03-17'),
(19, 8, 40, 5, 340, 10, '2015-03-17'),
(17, 3, 10, 5, 341, 8, '2003-06-29'),
(33, 4, 10, 5, 341, 8, '2003-06-29'),
(23, 7, 10, 5, 341, 8, '2003-06-29'),
(37, 2, 10, 5, 341, 8, '2003-06-29'),
(7, 4, 21, 4, 342, 4, '2021-03-08'),
(6, 7, 21, 4, 342, 4, '2021-03-08'),
(5, 8, 21, 4, 342, 4, '2021-03-08'),
(8, 8, 5, 1, 343, 9, '2019-08-17'),
(8, 7, 5, 1, 343, 9, '2019-08-17'),
(20, 3, 44, 5, 344, 10, '2013-05-04'),
(33, 2, 44, 5, 344, 10, '2013-05-04'),
(20, 4, 35, NULL, 345, 6, '2012-06-14'),
(10, 5, 22, NULL, 346, 10, '2018-10-12'),
(8, 2, 22, NULL, 346, 10, '2018-10-12'),
(9, 1, 22, NULL, 346, 10, '2018-10-12'),
(29, 8, 22, NULL, 346, 10, '2018-10-12'),
(12, 3, 22, NULL, 346, 10, '2018-10-12'),
(1, 6, 18, NULL, 347, 6, '2004-09-16'),
(28, 1, 18, NULL, 347, 6, '2004-09-16'),
(19, 5, 18, NULL, 347, 6, '2004-09-16'),
(31, 7, 18, NULL, 347, 6, '2004-09-16'),
(4, 3, 18, NULL, 347, 6, '2004-09-16'),
(1, 2, 18, NULL, 347, 6, '2004-09-16'),
(18, 3, 48, 1, 348, 2, '2002-11-14'),
(28, 5, 17, 1, 349, 6, '2021-07-31'),
(13, 7, 17, 1, 349, 6, '2021-07-31'),
(14, 9, 17, 1, 349, 6, '2021-07-31'),
(5, 6, 50, NULL, 350, 6, '2010-05-30'),
(12, 3, 50, NULL, 350, 6, '2010-05-30'),
(27, 1, 50, NULL, 350, 6, '2010-05-30'),
(1, 2, 50, NULL, 350, 6, '2010-05-30'),
(22, 7, 42, 4, 351, 1, '2017-12-02'),
(40, 1, 22, NULL, 352, 7, '2016-05-12'),
(21, 5, 22, NULL, 352, 7, '2016-05-12'),
(37, 8, 22, NULL, 352, 7, '2016-05-12'),
(8, 3, 22, NULL, 352, 7, '2016-05-12'),
(9, 4, 1, 4, 353, 1, '2000-10-02'),
(14, 2, 41, 4, 354, 2, '2009-06-25'),
(28, 4, 41, 4, 354, 2, '2009-06-25'),
(30, 4, 25, 4, 355, 4, '2008-01-19'),
(8, 1, 25, 4, 355, 4, '2008-01-19'),
(9, 9, 25, 4, 355, 4, '2008-01-19'),
(5, 3, 25, 4, 355, 4, '2008-01-19'),
(1, 2, 25, 4, 355, 4, '2008-01-19'),
(7, 6, 25, 4, 355, 4, '2008-01-19'),
(20, 7, 6, 4, 356, 7, '2014-02-06'),
(3, 8, 6, 4, 356, 7, '2014-02-06'),
(30, 1, 6, 4, 356, 7, '2014-02-06'),
(16, 4, 6, 4, 356, 7, '2014-02-06'),
(25, 6, 6, 4, 356, 7, '2014-02-06'),
(30, 9, 6, 4, 356, 7, '2014-02-06'),
(39, 3, 6, 4, 356, 7, '2014-02-06'),
(6, 1, 13, NULL, 357, 10, '2015-12-06'),
(26, 5, 13, NULL, 357, 10, '2015-12-06'),
(6, 2, 13, NULL, 357, 10, '2015-12-06'),
(29, 7, 13, NULL, 357, 10, '2015-12-06'),
(17, 8, 13, NULL, 357, 10, '2015-12-06'),
(31, 3, 8, 2, 358, 5, '2007-08-09'),
(15, 7, 8, 2, 358, 5, '2007-08-09'),
(5, 4, 8, 2, 358, 5, '2007-08-09'),
(41, 6, 8, 2, 358, 5, '2007-08-09'),
(6, 5, 8, 2, 358, 5, '2007-08-09'),
(29, 1, 34, 1, 359, 8, '2017-11-16'),
(12, 8, 34, 1, 359, 8, '2017-11-16'),
(24, 4, 34, 1, 359, 8, '2017-11-16'),
(11, 3, 34, 1, 359, 8, '2017-11-16'),
(27, 6, 34, 1, 359, 8, '2017-11-16'),
(37, 7, 34, 1, 359, 8, '2017-11-16'),
(36, 4, 5, NULL, 360, 7, '2009-12-03'),
(27, 6, 5, NULL, 360, 7, '2009-12-03'),
(35, 2, 5, NULL, 360, 7, '2009-12-03'),
(16, 7, 5, NULL, 360, 7, '2009-12-03'),
(36, 5, 5, NULL, 360, 7, '2009-12-03'),
(32, 2, 25, NULL, 361, 7, '2000-12-07'),
(13, 6, 25, NULL, 361, 7, '2000-12-07'),
(1, 7, 20, 2, 362, 7, '2004-08-01'),
(12, 8, 20, 2, 362, 7, '2004-08-01'),
(12, 4, 20, 2, 362, 7, '2004-08-01'),
(37, 6, 20, 2, 362, 7, '2004-08-01'),
(6, 1, 1, 2, 363, 1, '2020-04-19'),
(28, 9, 1, 2, 363, 1, '2020-04-19'),
(32, 5, 1, 2, 363, 1, '2020-04-19'),
(9, 2, 21, 1, 364, 5, '2001-02-08'),
(12, 6, 21, 1, 364, 5, '2001-02-08'),
(34, 5, 21, 1, 364, 5, '2001-02-08'),
(19, 7, 21, 1, 364, 5, '2001-02-08'),
(25, 3, 21, 1, 364, 5, '2001-02-08'),
(18, 5, 34, NULL, 365, 7, '2013-11-21'),
(36, 3, 38, NULL, 366, 2, '2001-12-23'),
(11, 1, 38, NULL, 366, 2, '2001-12-23'),
(17, 9, 38, NULL, 366, 2, '2001-12-23'),
(16, 4, 38, NULL, 366, 2, '2001-12-23'),
(5, 1, 41, NULL, 367, 7, '2008-02-16'),
(40, 2, 41, NULL, 367, 7, '2008-02-16'),
(21, 9, 3, NULL, 368, 4, '2006-02-04'),
(25, 7, 3, NULL, 368, 4, '2006-02-04'),
(35, 4, 3, NULL, 368, 4, '2006-02-04'),
(9, 8, 3, NULL, 368, 4, '2006-02-04'),
(25, 2, 40, NULL, 369, 9, '2000-07-26'),
(19, 8, 40, NULL, 369, 9, '2000-07-26'),
(9, 1, 40, NULL, 369, 9, '2000-07-26'),
(33, 9, 40, NULL, 369, 9, '2000-07-26'),
(27, 6, 47, 2, 370, 1, '2019-01-21'),
(16, 7, 47, 2, 370, 1, '2019-01-21'),
(38, 3, 47, 2, 370, 1, '2019-01-21'),
(28, 2, 47, 2, 370, 1, '2019-01-21'),
(21, 1, 47, 2, 370, 1, '2019-01-21'),
(41, 9, 47, 2, 370, 1, '2019-01-21'),
(33, 6, 12, NULL, 371, 7, '2015-05-11'),
(18, 9, 12, NULL, 371, 7, '2015-05-11'),
(36, 2, 12, NULL, 371, 7, '2015-05-11'),
(20, 4, 12, NULL, 371, 7, '2015-05-11'),
(15, 1, 12, NULL, 371, 7, '2015-05-11'),
(29, 5, 12, NULL, 371, 7, '2015-05-11'),
(35, 6, 14, NULL, 372, 3, '2003-10-29'),
(12, 5, 14, NULL, 372, 3, '2003-10-29'),
(1, 2, 29, 2, 373, 10, '2007-09-22'),
(34, 8, 29, 2, 373, 10, '2007-09-22'),
(7, 3, 29, 2, 373, 10, '2007-09-22'),
(41, 9, 29, 2, 373, 10, '2007-09-22'),
(33, 7, 2, 3, 374, 6, '2015-04-25'),
(31, 8, 2, 3, 374, 6, '2015-04-25'),
(41, 1, 2, 3, 374, 6, '2015-04-25'),
(38, 3, 2, 3, 374, 6, '2015-04-25'),
(41, 6, 2, 3, 374, 6, '2015-04-25'),
(30, 4, 2, 3, 374, 6, '2015-04-25'),
(2, 7, 18, 2, 375, 8, '2003-09-01'),
(13, 9, 18, 2, 375, 8, '2003-09-01'),
(22, 5, 18, 2, 375, 8, '2003-09-01'),
(35, 6, 18, 2, 375, 8, '2003-09-01'),
(19, 1, 18, 2, 375, 8, '2003-09-01'),
(10, 5, 26, NULL, 376, 9, '2000-07-18'),
(18, 2, 26, NULL, 376, 9, '2000-07-18'),
(23, 8, 26, NULL, 376, 9, '2000-07-18'),
(6, 6, 26, NULL, 376, 9, '2000-07-18'),
(5, 8, 12, 2, 377, 9, '2007-07-07'),
(12, 9, 21, NULL, 378, 9, '2007-03-01'),
(4, 4, 21, NULL, 378, 9, '2007-03-01'),
(11, 5, 21, NULL, 378, 9, '2007-03-01'),
(30, 8, 21, NULL, 378, 9, '2007-03-01'),
(14, 7, 15, NULL, 379, 6, '2009-03-10'),
(5, 3, 15, NULL, 379, 6, '2009-03-10'),
(28, 4, 15, NULL, 379, 6, '2009-03-10'),
(3, 5, 15, NULL, 379, 6, '2009-03-10'),
(18, 1, 15, NULL, 379, 6, '2009-03-10'),
(30, 9, 18, NULL, 380, 4, '2008-01-28'),
(5, 8, 18, NULL, 380, 4, '2008-01-28'),
(5, 5, 18, NULL, 380, 4, '2008-01-28'),
(36, 6, 23, NULL, 381, 8, '2020-02-29'),
(30, 4, 23, NULL, 381, 8, '2020-02-29'),
(27, 8, 23, NULL, 381, 8, '2020-02-29'),
(8, 9, 28, NULL, 382, 9, '2002-11-22'),
(21, 7, 6, 3, 383, 5, '2002-07-16'),
(10, 8, 6, 3, 383, 5, '2002-07-16'),
(35, 6, 6, 3, 383, 5, '2002-07-16'),
(10, 9, 6, 3, 383, 5, '2002-07-16'),
(40, 1, 6, 3, 383, 5, '2002-07-16'),
(39, 5, 6, 3, 383, 5, '2002-07-16'),
(9, 3, 6, 3, 383, 5, '2002-07-16'),
(40, 7, 41, 1, 384, 4, '2009-03-18'),
(3, 6, 41, 1, 384, 4, '2009-03-18'),
(13, 2, 41, 1, 384, 4, '2009-03-18'),
(32, 5, 24, NULL, 385, 7, '2016-12-15'),
(13, 8, 24, NULL, 385, 7, '2016-12-15'),
(16, 7, 24, NULL, 385, 7, '2016-12-15'),
(35, 4, 24, NULL, 385, 7, '2016-12-15'),
(25, 3, 24, NULL, 385, 7, '2016-12-15'),
(28, 1, 36, NULL, 386, 4, '2018-09-12'),
(24, 6, 36, NULL, 386, 4, '2018-09-12'),
(34, 3, 36, NULL, 386, 4, '2018-09-12'),
(30, 8, 36, NULL, 386, 4, '2018-09-12'),
(31, 4, 44, 1, 387, 3, '2018-10-26'),
(20, 3, 44, 1, 387, 3, '2018-10-26'),
(27, 5, 44, 1, 387, 3, '2018-10-26'),
(34, 8, 44, 1, 387, 3, '2018-10-26'),
(10, 1, 44, 1, 387, 3, '2018-10-26'),
(10, 9, 44, 1, 387, 3, '2018-10-26'),
(17, 8, 18, 2, 388, 4, '2001-11-22'),
(7, 5, 18, 2, 388, 4, '2001-11-22'),
(30, 4, 18, 2, 388, 4, '2001-11-22'),
(16, 1, 18, 2, 388, 4, '2001-11-22'),
(5, 3, 18, 2, 388, 4, '2001-11-22'),
(29, 2, 26, NULL, 389, 7, '2008-10-05'),
(35, 5, 26, NULL, 389, 7, '2008-10-05'),
(6, 9, 26, NULL, 389, 7, '2008-10-05'),
(13, 3, 26, NULL, 389, 7, '2008-10-05'),
(39, 1, 26, NULL, 389, 7, '2008-10-05'),
(25, 3, 30, 5, 390, 5, '2009-06-19'),
(13, 9, 30, 5, 390, 5, '2009-06-19'),
(18, 5, 30, 5, 390, 5, '2009-06-19'),
(1, 6, 30, 5, 390, 5, '2009-06-19'),
(19, 4, 30, 5, 390, 5, '2009-06-19'),
(6, 4, 21, NULL, 391, 2, '2021-07-24'),
(21, 9, 21, NULL, 391, 2, '2021-07-24'),
(36, 3, 21, NULL, 391, 2, '2021-07-24'),
(41, 2, 21, NULL, 391, 2, '2021-07-24'),
(21, 8, 21, NULL, 391, 2, '2021-07-24'),
(25, 3, 3, NULL, 392, 10, '2020-12-03'),
(5, 6, 3, NULL, 392, 10, '2020-12-03'),
(5, 8, 3, NULL, 392, 10, '2020-12-03'),
(20, 7, 3, NULL, 392, 10, '2020-12-03'),
(41, 5, 3, NULL, 392, 10, '2020-12-03'),
(34, 7, 31, NULL, 393, 9, '2015-07-06'),
(17, 8, 31, NULL, 393, 9, '2015-07-06'),
(14, 9, 31, NULL, 393, 9, '2015-07-06'),
(20, 1, 31, NULL, 393, 9, '2015-07-06'),
(26, 4, 31, NULL, 393, 9, '2015-07-06'),
(39, 3, 31, NULL, 393, 9, '2015-07-06'),
(37, 4, 3, NULL, 394, 9, '2004-05-16'),
(31, 1, 3, NULL, 394, 9, '2004-05-16'),
(1, 9, 3, NULL, 394, 9, '2004-05-16'),
(5, 6, 3, NULL, 394, 9, '2004-05-16'),
(13, 8, 37, NULL, 395, 7, '2012-01-15'),
(1, 9, 37, NULL, 395, 7, '2012-01-15'),
(8, 2, 37, NULL, 395, 7, '2012-01-15'),
(6, 1, 37, NULL, 395, 7, '2012-01-15'),
(41, 5, 37, NULL, 395, 7, '2012-01-15'),
(2, 2, 41, 2, 396, 2, '2000-04-19'),
(41, 6, 41, 2, 396, 2, '2000-04-19'),
(19, 8, 41, 2, 396, 2, '2000-04-19'),
(19, 3, 41, 2, 396, 2, '2000-04-19'),
(23, 5, 36, 3, 397, 10, '2009-05-10'),
(18, 9, 36, 3, 397, 10, '2009-05-10'),
(11, 7, 36, 3, 397, 10, '2009-05-10'),
(34, 7, 30, NULL, 398, 1, '2004-09-23'),
(11, 1, 30, NULL, 398, 1, '2004-09-23'),
(32, 8, 30, NULL, 398, 1, '2004-09-23'),
(8, 5, 30, NULL, 398, 1, '2004-09-23'),
(16, 2, 30, NULL, 398, 1, '2004-09-23'),
(30, 7, 4, 2, 399, 4, '2004-12-22'),
(21, 2, 49, NULL, 400, 5, '2017-05-10'),
(24, 5, 49, NULL, 400, 5, '2017-05-10'),
(17, 5, 26, 5, 401, 4, '2014-12-01'),
(18, 4, 4, 5, 402, 4, '2021-05-10'),
(29, 3, 4, 5, 402, 4, '2021-05-10'),
(5, 2, 4, 5, 402, 4, '2021-05-10'),
(25, 1, 4, 5, 402, 4, '2021-05-10'),
(39, 9, 4, 5, 402, 4, '2021-05-10'),
(35, 7, 4, 5, 402, 4, '2021-05-10'),
(34, 6, 50, 1, 403, 9, '2016-04-22'),
(41, 9, 50, 1, 403, 9, '2016-04-22'),
(32, 1, 24, 1, 404, 7, '2019-09-04'),
(30, 8, 21, 1, 405, 4, '2000-03-05'),
(27, 7, 34, NULL, 406, 9, '2009-12-28'),
(2, 9, 34, NULL, 406, 9, '2009-12-28'),
(16, 8, 38, 4, 407, 10, '2021-10-10'),
(12, 2, 35, 3, 408, 5, '2000-01-26'),
(27, 4, 35, 3, 408, 5, '2000-01-26'),
(10, 9, 35, 3, 408, 5, '2000-01-26'),
(16, 7, 35, 3, 408, 5, '2000-01-26'),
(12, 5, 35, 3, 408, 5, '2000-01-26'),
(18, 6, 35, 3, 408, 5, '2000-01-26'),
(7, 4, 4, 2, 409, 4, '2019-01-05'),
(1, 6, 4, 2, 409, 4, '2019-01-05'),
(4, 3, 4, 2, 409, 4, '2019-01-05'),
(42, 4, 40, 4, 410, 2, '2010-10-30'),
(19, 5, 40, 4, 410, 2, '2010-10-30'),
(26, 7, 40, 4, 410, 2, '2010-10-30'),
(1, 6, 40, 4, 410, 2, '2010-10-30'),
(5, 8, 40, 4, 410, 2, '2010-10-30'),
(19, 1, 36, NULL, 411, 3, '2000-03-13'),
(33, 8, 36, NULL, 411, 3, '2000-03-13'),
(17, 7, 36, NULL, 411, 3, '2000-03-13'),
(30, 2, 36, NULL, 411, 3, '2000-03-13'),
(6, 9, 36, NULL, 411, 3, '2000-03-13'),
(5, 3, 28, NULL, 412, 7, '2004-01-13'),
(5, 9, 28, NULL, 412, 7, '2004-01-13'),
(40, 1, 28, NULL, 412, 7, '2004-01-13'),
(13, 2, 28, NULL, 412, 7, '2004-01-13'),
(32, 8, 28, NULL, 412, 7, '2004-01-13'),
(22, 6, 48, NULL, 413, 8, '2018-09-11'),
(2, 2, 48, NULL, 413, 8, '2018-09-11'),
(28, 4, 48, NULL, 413, 8, '2018-09-11'),
(1, 3, 48, NULL, 413, 8, '2018-09-11'),
(22, 5, 48, NULL, 413, 8, '2018-09-11'),
(36, 6, 48, 2, 414, 8, '2008-05-23'),
(41, 7, 19, 3, 415, 6, '2016-02-15'),
(19, 6, 19, 3, 415, 6, '2016-02-15'),
(6, 4, 19, 3, 415, 6, '2016-02-15'),
(17, 8, 45, NULL, 416, 7, '2006-04-23'),
(41, 5, 45, NULL, 416, 7, '2006-04-23'),
(5, 6, 12, 3, 417, 8, '2019-04-25'),
(9, 4, 29, 1, 418, 3, '2010-05-15'),
(8, 8, 29, 1, 418, 3, '2010-05-15'),
(41, 1, 29, 1, 418, 3, '2010-05-15'),
(16, 7, 29, 1, 418, 3, '2010-05-15'),
(7, 2, 29, 1, 418, 3, '2010-05-15'),
(17, 6, 29, 1, 418, 3, '2010-05-15'),
(18, 9, 13, NULL, 419, 3, '2020-05-02'),
(18, 1, 13, NULL, 419, 3, '2020-05-02'),
(6, 5, 13, NULL, 419, 3, '2020-05-02'),
(22, 3, 33, NULL, 420, 4, '2004-02-02'),
(19, 6, 33, NULL, 420, 4, '2004-02-02'),
(2, 4, 33, NULL, 420, 4, '2004-02-02'),
(31, 2, 33, NULL, 420, 4, '2004-02-02');


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


CREATE OR REPLACE FUNCTION db_project.validate_adres()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.miejscowosc !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń[:space:]]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa miejscowości';
    END IF;
    IF NEW.kod_pocztowy !~ '^[0-9]{2}-[0-9]{3}$' THEN
        RAISE EXCEPTION 'Nieprawidłowy kod pocztowy';
    END IF;
    IF NEW.ulica !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa ulicy';
    END IF;
    IF NEW.nr_budynku < 1 THEN
        RAISE EXCEPTION 'Nieprawidłowy numer budynku';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_adres ON db_project.adres;
CREATE TRIGGER trigger_validate_adres
    BEFORE INSERT OR UPDATE ON db_project.adres
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_adres();


CREATE OR REPLACE FUNCTION db_project.validate_dostawca()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.nazwa !~ '^[A-ZĄĘÓŁŚŻŹĆŃa-ząęółśżźćń\.\-0-9[:space:]]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_dostawca ON db_project.dostawca;
CREATE TRIGGER trigger_validate_dostawca
    BEFORE INSERT OR UPDATE ON db_project.dostawca
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_dostawca();


CREATE OR REPLACE FUNCTION db_project.validate_klient()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.imie !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe imię';
    END IF;
    IF NEW.nazwisko !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe nazwisko';
    END IF;
    IF NEW.email !~ '^[a-z]*@[a-z]*\.[a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowy email';
    END IF;
    IF NEW.nr_telefonu !~ '^[0-9]{9}$' THEN
        RAISE EXCEPTION 'Nieprawidłowy numer telefonu';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_klient ON db_project.klient;
CREATE TRIGGER trigger_validate_klient
    BEFORE INSERT OR UPDATE ON db_project.klient
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_klient();


CREATE OR REPLACE FUNCTION db_project.validate_pracownik()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.imie !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe imię';
    END IF;
    IF NEW.nazwisko !~ '^[A-ZĄĘÓŁŚŻŹĆŃ][a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe nazwisko';
    END IF;
    IF NEW.stanowisko !~ '^[a-ząęółśżźćń]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe stanowisko';
    END IF;
    IF NEW.email !~ '^[a-z]*@[a-z]*\.[a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowy email';
    END IF;
    IF NEW.nr_telefonu !~ '^[0-9]{9}$' THEN
        RAISE EXCEPTION 'Nieprawidłowy numer telefonu';
    END IF;
    IF NEW.nr_telefonu !~ '^[0-9]{26}$' THEN
        RAISE EXCEPTION 'Nieprawidłowy numer konta bankowego';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_pracownik ON db_project.pracownik;
CREATE TRIGGER trigger_validate_pracownik
    BEFORE INSERT OR UPDATE ON db_project.pracownik
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_pracownik();


CREATE OR REPLACE FUNCTION db_project.validate_produkt()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.cena_bazowa <= 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa cena';
    END IF;
    IF NEW.stawka_vat < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa stawka VAT';
    END IF;
    IF NEW.nazwa !~ '^[A-ZĄĘÓŁŚŻŹĆŃa-ząęółśżźćń0-9\-@[:space:]]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_produkt ON db_project.produkt;
CREATE TRIGGER trigger_validate_produkt
    BEFORE INSERT OR UPDATE ON db_project.produkt
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_produkt();


CREATE OR REPLACE FUNCTION db_project.Validate_Stan_Magazynowy()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.ilosc < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
    END IF;
    IF EXISTS (SELECT 1 FROM db_project.stan_magazynowy WHERE stan_magazynowy.id_produkt = NEW.id_produkt) THEN
        NEW.id_stan_magazynowy := (SELECT stan_magazynowy.id_stan_magazynowy FROM db_project.stan_magazynowy WHERE stan_magazynowy.id_produkt = NEW.id_produkt);
        DELETE FROM db_project.stan_magazynowy
        WHERE stan_magazynowy.id_produkt = NEW.id_produkt;
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_stan_magazynowy ON db_project.stan_magazynowy;
CREATE TRIGGER trigger_validate_stan_magazynowy
    BEFORE INSERT OR UPDATE ON db_project.stan_magazynowy
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_stan_magazynowy();


CREATE OR REPLACE FUNCTION db_project.validate_kod_rabatowy()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.stawka_procentowa < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa stawka procentowa';
    END IF;
    IF NEW.kwota < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa kwota';
    END IF;
    IF NEW.kod !~ '^[A-Za-z0-9]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowy kod';
    END IF;
    IF NEW.limit_uzyc < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowy limit użyć';
    END IF;
    IF NEW.wykorzystano < 0 OR NEW.wykorzystano > NEW.limit_uzyc THEN
        RAISE EXCEPTION 'Nieprawidłowa liczba użyć kodu';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';


DROP TRIGGER trigger_validate_kod_rabatowy ON db_project.kod_rabatowy;
CREATE TRIGGER trigger_validate_kod_rabatowy
    BEFORE INSERT OR UPDATE ON db_project.kod_rabatowy
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_kod_rabatowy();


CREATE OR REPLACE FUNCTION db_project.validate_koszyk_produkt()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.ilosc < 1 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_koszyk_produkt ON db_project.koszyk_produkt;
CREATE TRIGGER trigger_validate_koszyk_produkt
    BEFORE INSERT OR UPDATE ON db_project.koszyk_produkt
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_koszyk_produkt();


CREATE OR REPLACE FUNCTION db_project.validate_zakup()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.ilosc < 1 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
    END IF;
    IF NEW.nr_zamowienia < 1 THEN
        RAISE EXCEPTION 'Nieprawidłowy numer zamówienia';
    END IF;
    IF (SELECT stan_magazynowy.ilosc
        FROM db_project.stan_magazynowy
        WHERE stan_magazynowy.id_produkt = NEW.id_produkt) < NEW.ilosc THEN
        RAISE EXCEPTION 'Brak wystarczającej ilości towaru w magazynie';
    END IF;
    IF NEW.id_kod_rabatowy IS NOT NULL AND (SELECT kod_rabatowy.wykorzystano >= kod_rabatowy.limit_uzyc
        FROM db_project.kod_rabatowy
        WHERE kod_rabatowy.id_kod_rabatowy = NEW.id_kod_rabatowy) THEN
        RAISE EXCEPTION 'Kod rabatowy nie ważny';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_zakup ON db_project.zakup;
CREATE TRIGGER trigger_validate_zakup
    BEFORE INSERT OR UPDATE ON db_project.zakup
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_zakup();


CREATE OR REPLACE FUNCTION db_project.after_insert_zakup()
RETURNS TRIGGER AS
$$ BEGIN
    UPDATE db_project.stan_magazynowy
    SET ilosc = stan_magazynowy.ilosc - NEW.ilosc
    WHERE stan_magazynowy.id_produkt = NEW.id_produkt;
    IF NEW.id_kod_rabatowy IS NOT NULL THEN
        UPDATE db_project.kod_rabatowy
        SET wykorzystano = kod_rabatowy.wykorzystano + 1
        WHERE kod_rabatowy.id_kod_rabatowy = NEW.id_kod_rabatowy;
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_after_insert_zakup ON db_project.zakup;
CREATE TRIGGER trigger_after_insert_zakup
    AFTER INSERT ON db_project.zakup
    FOR EACH ROW EXECUTE PROCEDURE db_project.after_insert_zakup();


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

