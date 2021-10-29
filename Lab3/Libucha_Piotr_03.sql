ALTER TABLE "u9libucha"."lab03"."kurs" ADD COLUMN "termin_k" DATE;

ALTER TABLE "u9libucha"."lab03"."kurs" ADD COLUMN "termin_p" DATE;

UPDATE lab03.kurs SET termin_p = to_date(termin,'DD-MM-YYYY');

UPDATE lab03.kurs SET termin_k = to_date(right(termin, 10),'DD-MM-YYYY');

ALTER TABLE "u9libucha"."lab03"."kurs" DROP COLUMN "termin";

ALTER TABLE ONLY "u9libucha"."lab03"."kurs" ALTER COLUMN "termin_k" TYPE DATE, ALTER COLUMN "termin_k" SET NOT NULL;

ALTER TABLE ONLY "u9libucha"."lab03"."kurs" ALTER COLUMN "termin_p" TYPE DATE, ALTER COLUMN "termin_p" SET NOT NULL;



ALTER TABLE "u9libucha"."lab03"."uczestnik" ADD COLUMN "kod_pocztowy" VARCHAR(6) DEFAULT '00-000' NOT NULL;

ALTER TABLE "u9libucha"."lab03"."uczestnik" ADD COLUMN "adres" VARCHAR(80) DEFAULT 'null street 0' NOT NULL;

ALTER TABLE "u9libucha"."lab03"."uczestnik" ADD COLUMN "miejscowosc" VARCHAR(80) DEFAULT 'null island' NOT NULL;




CREATE TABLE lab03.temp_adres (
                "kod_pocztowy" VARCHAR(6) DEFAULT '00-000' NOT NULL,
                "adres" VARCHAR(80) DEFAULT 'null street 0' NOT NULL,
                "miejscowosc" VARCHAR(80) DEFAULT 'null island' NOT NULL
);


ALTER TABLE "u9libucha"."lab03"."temp_adres" ADD COLUMN "id_uczestnik" INTEGER NOT NULL;

ALTER TABLE "u9libucha"."lab03"."temp_adres" ADD CONSTRAINT "uczestnik_temp_adres_fk"
FOREIGN KEY ("id_uczestnik")
REFERENCES "u9libucha"."lab03"."uczestnik" ("id_uczestnik")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

INSERT INTO lab03.temp_adres (id_uczestnik, kod_pocztowy, adres, miejscowosc) VALUES
(1, '22-346', 'Jana Pawła II 32', 'Rzeszów'),
(2, '61-734', 'Devopsów 1', 'Nowy Sącz'),
(3, '92-82', 'Fizyczna 11', 'Wadowice'),
(4, '29-352', 'Kawowa 40', 'Szczecin'),
(5, '55-973', 'Bazowadanowa 39', 'Warszawa'),
(6, '29-352', 'Górnicza 52', 'Nowy Sącz'),
(7, '55-973', 'Papieżowa 16', 'Wrocław'),
(8, '92-82', 'Papieżowa 16', 'Opole'),
(9, '13-543', 'Jana Pawła II 94', 'Katowice'),
(10, '6-329', 'Fizyczna 21', 'Gdańsk'),
(11, '66-257', 'Czarnowiejska 7', 'Nowy Sącz'),
(12, '46-39', 'Moździeżowa 20', 'Kielce'),
(13, '87-645', 'Programistów 87', 'Szczecin'),
(14, '43-31', 'Papieżowa 31', 'Poznań'),
(15, '78-877', 'Informatyczna 5', 'Nowy Sącz'),
(16, '39-45', 'Rektorska 89', 'Kraków'),
(17, '85-886', 'Dziekańska 6', 'Szczebrzeszyn'),
(18, '93-537', 'Studencka 34', 'Kielce'),
(19, '4-615', 'Papieżowa 8', 'Toruń'),
(20, '43-31', 'Kernelowa 19', 'Szczebrzeszyn'),
(21, '57-714', 'Kremówkowa 89', 'Katowice'),
(22, '71-106', 'Kernelowa 67', 'Toruń'),
(23, '13-830', 'Reymonta 51', 'Szczebrzeszyn'),
(24, '24-463', 'Kremówkowa 26', 'Katowice'),
(25, '85-886', 'Sieciowców 92', 'Toruń'),
(26, '24-372', 'Kremówkowa 54', 'Toruń'),
(27, '34-324', 'Testerów 20', 'Rzeszów'),
(28, '24-372', 'Kernelowa 40', 'Koszalin'),
(29, '66-904', 'Studencka 93', 'Rzeszów'),
(30, '47-294', 'Rektorska 4', 'Szczecin');

UPDATE lab03.uczestnik SET (kod_pocztowy, adres, miejscowosc) = (temp_adres.kod_pocztowy, temp_adres.adres, temp_adres.miejscowosc) FROM lab03.temp_adres WHERE uczestnik.id_uczestnik = temp_adres.id_uczestnik;

DROP TABLE lab03.temp_adres;



SELECT Uczestnik.nazwisko, Uczestnik.imie, Uczestnik.adres, Uczestnik.kod_pocztowy, Uczestnik.miejscowosc, Kurs_opis.opis, Kurs.id_kurs, Kurs.id_grupa

FROM lab03.Kurs, lab03.uczest_kurs, lab03.Uczestnik, lab03.Kurs_opis

WHERE Kurs.id_kurs = uczest_kurs.id_kurs and  

      Uczestnik.id_uczestnik = uczest_kurs.id_uczest and

      Kurs.id_kurs = Kurs_opis.id_kurs ;

