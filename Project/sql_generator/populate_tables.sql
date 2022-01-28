INSERT INTO db_project.adres (miejscowosc, kod_pocztowy, ulica, nr_budynku) VALUES
('Toruń', '64-299', 'Kawowa', 342),
('Łódź', '72-897', 'Reymonta', 535),
('Katowice', '90-839', 'Kawowa', 310),
('Kraków', '44-385', 'Dziekańska', 86),
('Toruń', '5-958', 'Fizyczna', 52);

INSERT INTO db_project.dostawca (nazwa, id_adres) VALUES
('Qwerty S.A.', 4),
('Delko S.A', 4),
('Nosaczpol S.A', 3),
('Interkarton z o.o.', 3),
('Wodociągi Kieleckie S.A.', 2);

INSERT INTO db_project.klient (imie, nazwisko, id_adres, email, nr_telefonu) VALUES
('Ryszard', 'Szewczyk', 1, 'szewczyk@asdf.pl', '685493234'),
('Dariusz', 'Sosnowski', 1, 'sosnowski@gmail.com', '063300871'),
('Tomasz', 'Dadacki', 3, 'dadacki@qwerty.com', '995585008'),
('Tomasz', 'Zawadzki', 4, 'zawadzki@example.com', '515982766'),
('Krzysztof', 'Kowalski', 2, 'kowalski@qwerty.com', '668749728');

INSERT INTO db_project.pracownik (imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta) VALUES
('Andrzej', 'Abacki', 'manager', 1, 'abacki@januszex.pl', '884109852', '06347585961554549683620687'),
('Jan', 'Babacki', 'kierownik sklepu', 2, 'babacki@januszex.pl', '311026610', '06344744272388144964996622'),
('Stanisław', 'Sosnowski', 'manager', 1, 'sosnowski@gmail.com', '176685974', '18505334195556686532591008'),
('Marek', 'Nowak', 'kierownik sklepu', 1, 'nowak@example.com', '028049694', '99870306420369239733213303'),
('Stanisław', 'Cabacki', 'kierownik sklepu', 3, 'cabacki@gmail.com', '132799675', '63832856337750282557504691');

INSERT INTO db_project.produkt (nazwa, cena_bazowa, stawka_vat, id_dostawca) VALUES
('kabel od internetu', 1224, 5, 3),
('bulbulator', 9440, 5, 5),
('lodówka Haier', 5989, 23, 4),
('karma dla gekona', 5087, 8, 4),
('błotnik do czołgu', 4528, 5, 2);

INSERT INTO db_project.stan_magazynowy (id_produkt, ilosc) VALUES
(1, 12),
(2, 24),
(3, 33),
(4, 19),
(5, 29);

INSERT INTO db_project.kod_rabatowy (stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik) VALUES
(5, 0, 'gonnacallmanager', 374, 151, 3),
(0, 20, 'cheaperplease', 190, 147, 5),
(0, 90, 'letmein', 325, 65, 4),
(0, 40, 'cheaperplease', 677, 141, 3),
(35, 0, 'cheaperplease', 179, 168, 4);

INSERT INTO db_project.koszyk (id_klient) VALUES
(4),
(1),
(5),
(2),
(3);

INSERT INTO db_project.koszyk_produkt (id_koszyk, id_produkt, ilosc) VALUES
(1, 1, 9),
(1, 2, 10),
(1, 3, 32),
(1, 4, 8),
(2, 3, 16),
(2, 2, 4),
(3, 1, 6),
(3, 4, 15),
(4, 5, 9),
(4, 3, 3),
(5, 2, 16),
(5, 1, 7);

INSERT INTO db_project.zakup (ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data) VALUES
(23, 5, 1, NULL, 1, 1, '2012-04-23'),
(7, 3, 1, 5, 2, 5, '2005-04-06'),
(7, 4, 3, 5, 2, 4, '2009-02-01'),
(35, 5, 3, 2, 2, 5, '2002-05-28'),
(15, 2, 5, 3, 2, 1, '2018-01-16'),
(15, 1, 2, 3, 2, 1, '2018-05-06'),
(34, 5, 5, 5, 3, 5, '2020-10-19'),
(35, 2, 2, NULL, 3, 2, '2009-10-20'),
(18, 1, 3, 5, 3, 2, '2015-01-28'),
(18, 2, 3, NULL, 4, 3, '2020-02-17'),
(21, 4, 1, 2, 4, 1, '2019-11-19'),
(31, 1, 1, NULL, 4, 4, '2002-04-03'),
(8, 5, 4, 5, 4, 1, '2007-06-07'),
(11, 4, 5, 4, 5, 5, '2010-04-29'),
(38, 2, 1, 5, 5, 5, '2019-09-22'),
(22, 3, 1, 3, 5, 5, '2008-05-09'),
(26, 1, 2, NULL, 5, 4, '2006-11-18');

