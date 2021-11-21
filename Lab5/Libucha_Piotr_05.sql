-- as postgres user GRANT CREATE ON DATABASE "DB1lab01" TO andlem;

CREATE SCHEMA lab05;

CREATE TABLE lab05.uczestnik (
  id_uczestnik INTEGER NOT NULL,
  nazwisko VARCHAR(50),
  imie VARCHAR(50),
  kod_pocztowy VARCHAR(6),
  miejscowosc VARCHAR(80),
  adres VARCHAR(200),
  email VARCHAR(150),
  CONSTRAINT uczestnik_pkey PRIMARY KEY(id_uczestnik)
) ;

--ALTER TABLE lab05.uczestnik OWNER TO andlem;

CREATE TABLE lab05.wykladowca (
  id_wykladowca INTEGER NOT NULL,
  nazwisko VARCHAR(50),
  imie VARCHAR(50),
  kod_pocztowy VARCHAR(6),
  miejscowosc VARCHAR(80),
  adres VARCHAR(200),
  email VARCHAR(150),
  telefon VARCHAR(20),
  CONSTRAINT wykladowca_pkey PRIMARY KEY(id_wykladowca)
) ;
-- DROP TABLE lab05.wykladowca;

-- ALTER TABLE lab05.wykladowca  OWNER TO andlem;

CREATE TABLE lab05.kurs_opis (
  id_kurs INTEGER NOT NULL,
  opis VARCHAR(100),
  CONSTRAINT kurs_opis_pkey PRIMARY KEY(id_kurs)
) ;

--ALTER TABLE lab05.kurs_opis  OWNER TO andlem;

CREATE TABLE lab05.kurs (
  id_kurs INTEGER NOT NULL,
  id_grupa INTEGER,
  id_nazwa INTEGER NOT NULL,
  data_rozpoczecia DATE,
  data_zakonczenia DATE,
  CONSTRAINT kurs_pkey PRIMARY KEY(id_kurs),
  CONSTRAINT kurs_id_nazwa_fkey FOREIGN KEY (id_nazwa)
    REFERENCES lab05.kurs_opis(id_kurs)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) ;

--ALTER TABLE lab05.kurs  OWNER TO andlem;

CREATE TABLE lab05.wykl_kurs (
  id_wykl INTEGER NOT NULL,
  id_kurs INTEGER NOT NULL,
  CONSTRAINT wykl_kurs_pkey PRIMARY KEY(id_wykl, id_kurs),
  CONSTRAINT wykl_kurs_id_kurs_fkey FOREIGN KEY (id_kurs)
    REFERENCES lab05.kurs(id_kurs)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT wykl_kurs_id_wykl_fkey FOREIGN KEY (id_wykl)
    REFERENCES lab05.wykladowca(id_wykladowca)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) ;

--ALTER TABLE lab01.wykl_kurs OWNER TO andlem;

CREATE TABLE lab05.uczest_kurs (
  id_uczest INTEGER NOT NULL,
  id_kurs INTEGER NOT NULL,
  oplata NUMERIC(8,2),
  ocena NUMERIC(5,2),
  CONSTRAINT uczest_kurs_pkey PRIMARY KEY(id_uczest, id_kurs),
  CONSTRAINT uczest_kurs_id_kurs_fkey FOREIGN KEY (id_kurs)
    REFERENCES lab05.kurs(id_kurs)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE,
  CONSTRAINT uczest_kurs_id_uczest_fkey FOREIGN KEY (id_uczest)
    REFERENCES lab05.uczestnik(id_uczestnik)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE
) ;

--ALTER TABLE lab05.uczest_kurs OWNER TO andlem;
--ALTER TABLE ONLY "DB1lab01"."lab05"."uczest_kurs" ALTER COLUMN "ocena" TYPE NUMERIC(5,2), ALTER COLUMN "ocena" DROP NOT NULL;
--ALTER TABLE ONLY "DB1lab01"."lab05"."uczest_kurs" ALTER COLUMN "oplata" TYPE NUMERIC(8,2), ALTER COLUMN "oplata" DROP NOT NULL;



ALTER TABLE ONLY "lab05"."kurs" ALTER COLUMN "id_nazwa" TYPE INTEGER, ALTER COLUMN "id_nazwa" SET NOT NULL;

CREATE TABLE "lab05"."organizacja" (
                "id_organizacja" INTEGER NOT NULL,
                "nazwa" VARCHAR(250) NOT NULL,
                "strona_www" VARCHAR(150) NOT NULL,
                CONSTRAINT "organizacja_pk" PRIMARY KEY ("id_organizacja")
);


CREATE TABLE "lab05"."uczestnik_organizacja" (
                "id_organizacja" INTEGER NOT NULL,
                "id_wykladowca" INTEGER,
                "id_uczestnik" INTEGER
);


ALTER TABLE "lab05"."uczestnik_organizacja" ADD CONSTRAINT "organizacja_uczestnik_organizacja_fk"
FOREIGN KEY ("id_organizacja")
REFERENCES "lab05"."organizacja" ("id_organizacja")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "lab05"."uczestnik_organizacja" ADD CONSTRAINT "uczestnik_uczestnik_organizacja_fk"
FOREIGN KEY ("id_uczestnik")
REFERENCES "lab05"."uczestnik" ("id_uczestnik")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE "lab05"."uczestnik_organizacja" ADD CONSTRAINT "wykladowca_uczestnik_organizacja_fk"
FOREIGN KEY ("id_wykladowca")
REFERENCES "lab05"."wykladowca" ("id_wykladowca")
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

insert into lab05.uczestnik ( id_uczestnik, nazwisko, imie, email ) values 
( 1, 'Flisikowski', 'Jan', 'flisikowski@fis.agh.edu.pl'),
( 2, 'Olech', 'Andrzej', NULL),
( 3, 'Płochocki', 'Piotr', NULL    ),
( 4, 'Stachyra', 'Krzysztof', NULL ),
( 5, 'Sztuka', 'Stanisław', NULL   ),
( 6, 'Sosin', 'Tomasz', NULL       ),
( 7, 'Głowala', 'Paweł','glowala@fis.agh.edu.pl'),
( 8, 'Straszewski', 'Józef', NULL  ),
( 9, 'Dwojak', 'Marcin', NULL      ),
(10, 'Kotulski', 'Marek', NULL    ),
(11, 'Łaski', 'Michał','laski@fis.agh.edu.pl'       ),
(12, 'Iwanowicz', 'Grzegorz', NULL ),
(13, 'Barnaś', 'Jerzy', NULL       ),
(14, 'Stachera', 'Tadeusz', NULL   ),
(15, 'Gzik', 'Adam', NULL          ),
(16, 'Całus', 'Łukasz', NULL       ),
(17, 'Kołodziejek', 'Zbigniew', NULL),
(18, 'Bukowiecki', 'Ryszard', NULL ),
(19, 'Sielicki', 'Dariusz', NULL   ),
(20, 'Radziszewski', 'Henryk', NULL),
(21, 'Szcześniak', 'Mariusz', NULL ),
(22, 'Nawara', 'Kazimierz', NULL   ),
(23, 'Kęski', 'Wojciech', NULL     ),
(24, 'Rafalski', 'Robert', 'rafalski@fis.agh.edu.pl'),
(25, 'Hołownia', 'Mateusz', NULL   ),
(26, 'Niedziałek', 'Marian', NULL  ),
(27, 'Matuszczak', 'Rafał', NULL   ),
(28, 'Wolf', 'Jacek','wolf@fis.agh.edu.pl'),
(29, 'Kolczyński', 'Janusz', NULL  ),
(30, 'Chrobok', 'Mirosław', NULL   )  ;
--
-- wstawienie danych - tabela kurs_opis
insert into lab05.kurs_opis ( id_kurs, opis ) values
( 1, 'Język angielski, stopień 1'),
( 2, 'Język angielski, stopień 2'),
( 3, 'Język angielski, stopień 3'), 
( 4, 'Język angielski, stopień 4'),
( 5, 'Język angielski, stopień 5'),
( 6, 'Język niemiecki, stopień 1'),
( 7, 'Język niemiecki, stopień 2'),
( 8, 'Język niemiecki, stopień 3'),
( 9, 'Język niemiecki, stopień 4'),
(10, 'Język hiszpański, stopień 1'),
(11, 'Język hiszpański, stopień 2'),
(12, 'Język hiszpański, stopień 3') ;
--
-- wstawienie danych - tabela wykladowca
insert into lab05.wykladowca ( id_wykladowca, imie, nazwisko, email ) values 
( 1, 'Marcin','Szymczak', NULL),
( 2, 'Joanna','Baranowska','Baranowska@agh.edu.pl' ),
( 3, 'Maciej','Szczepański', NULL),
( 4, 'Czesław','Wróbel', NULL),
( 5, 'Grażyna','Górska', NULL),
( 6, 'Wanda','Krawczyk', 'Krawczyk@agh.edu.pl'),
( 7, 'Renata','Urbańska', NULL),
( 8, 'Wiesława','Tomaszewska', 'Tomaszewska@fis.agh.edu.pl'),
( 9, 'Bożena','Baranowska', NULL),
(10, 'Ewelina','Malinowska', 'Malinowska@fis.agh.edu.pl'),
(11, 'Anna','Krajewska', NULL),
(12, 'Mieczysław','Zając', NULL),
(13, 'Wiesław','Przybylski','Przybylski@agh.edu.pl'),
(14, 'Dorota','Tomaszewska', NULL),
(15, 'Jerzy','Wróblewski', NULL) ;
--
-- wstawienie danych - tabela kurs
insert into lab05.kurs ( id_kurs, id_grupa, id_nazwa, data_rozpoczecia,data_zakonczenia ) values
( 1, 1, 1, '2021-01-01','2021-03-31'),
( 2, 2, 1, '2021-01-01', '2021-03-31'),
( 3, 1, 2, '2021-04-01', '2021-06-30'),
( 4, 1, 3, '2021-08-01', '2021-10-10'),
( 5, 1, 4, '2021-11-01', '2021-12-23'),
( 6, 1, 6, '2021-01-01', '2021-03-31'),
( 7, 2, 6, '2021-01-01', '2021-03-31'),
( 8, 1, 7, '2021-04-01', '2021-06-30'),
( 9, 1, 8, '2021-07-01', '2021-07-31'),
(10, 1, 10, '2021-02-01', '2021-05-31'),
(11, 1, 11, '2021-09-01', '2021-11-30') ; 
--
-- wstawienie danych - tabela wykl_kurs - wykladowcy na kursach
insert into lab05.wykl_kurs ( id_kurs, id_wykl ) values
( 1, 1 ),
( 2, 2 ),
( 3, 1 ),
( 4, 1 ),
( 5, 3 ),
( 6, 4 ),
( 7, 5 ),
( 8, 4 ),
( 9, 4 ),
(10, 11 ),
(11, 11 ) ; 
--
-- wstawienie danych - tabela uczest_kurs - uczestnicy na kursach
insert into lab05.uczest_kurs ( id_kurs, id_uczest ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1 ),
( 1, 3 ),
( 1, 5 ),
( 1, 7 ),
( 1, 8 ),
( 1, 10 ),
( 1, 11 ),
( 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2 ),
( 2, 16 ),
( 2, 17 ),
( 2, 18 ),
( 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1 ),
( 3, 2 ),
( 3, 3 ),
( 3, 5 ),
( 3, 7 ),
( 3, 17 ),
( 3, 18 ),
( 3, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1 ),
( 4, 2 ),
( 4, 3 ),
( 4, 5 ),
( 4, 21 ),
( 4, 22 ),
( 4, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1 ),
( 5, 2 ),
( 5, 3 ),
( 5, 5 ),
( 5, 21 ),
( 5, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 8 ),
( 6, 9 ),
( 6, 13 ),
( 6, 15 ),
( 6, 19 ),
( 6, 24 ),
( 6, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 11 ),
( 7, 17 ),
( 7, 18 ),
( 7, 23 ),
( 7, 25 ),
( 7, 28 ),
( 7, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 8 ),
( 8, 9 ),
( 8, 13 ),
( 8, 15 ),
( 8, 19 ),
( 8, 24 ),
( 8, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 8 ),
( 9, 9 ),
( 9, 13 ),
( 9, 24 ),
( 9, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 6 ),
(10, 16 ),
(10, 18 ),
(10, 22 ),
(10, 24 ),
(10, 29 ),
(10, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 6 ),
(11, 16 ),
(11, 18 ),
(11, 22 ),
(11, 24 ),
(11, 29 ),
(11, 30 ) ;

-- wstawienie danych - tabela uczest_kurs - uczestnicy na kursach
-- kurs 1 - angielski 1 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=1 and id_uczest=1;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 4 )  where  id_kurs=1 and id_uczest=3;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 5 )  where  id_kurs=1 and id_uczest=5;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=1 and id_uczest=7;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 4 )  where  id_kurs=1 and id_uczest=8;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 4 )  where  id_kurs=1 and id_uczest=10;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 5 )  where  id_kurs=1 and id_uczest=11;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=1 and id_uczest=12;
-- kurs 2 - angielski 1 gr 2
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=2 and id_uczest=2;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=2 and id_uczest=16;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 5 )  where  id_kurs=2 and id_uczest=17;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 3 )  where  id_kurs=2 and id_uczest=18;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 500., 4 )  where  id_kurs=2 and id_uczest=20;
-- kurs 3 - angielski 2 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 3 )  where  id_kurs=3 and id_uczest=1;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=3 and id_uczest=2;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 5 )  where  id_kurs=3 and id_uczest=3;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 3 )  where  id_kurs=3 and id_uczest=5;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=3 and id_uczest=7;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=3 and id_uczest=17;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 5 )  where  id_kurs=3 and id_uczest=18;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 3 )  where  id_kurs=3 and id_uczest=20;
-- kurs 4 - angielski 3 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=4 and id_uczest=1;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=4 and id_uczest=2;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=4 and id_uczest=3;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 3 )  where  id_kurs=4 and id_uczest=5;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 3 )  where  id_kurs=4 and id_uczest=21;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 5 )  where  id_kurs=4 and id_uczest=22;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 5 )  where  id_kurs=4 and id_uczest=25;
-- kurs 5 - angielski 4 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 4 )  where  id_kurs=5 and id_uczest=1;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 4 )  where  id_kurs=5 and id_uczest=2;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 4 )  where  id_kurs=5 and id_uczest=3;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 3 )  where  id_kurs=5 and id_uczest=5;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 3 )  where  id_kurs=5 and id_uczest=21;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 850., 5 )  where  id_kurs=5 and id_uczest=22;
-- kurs 6 - niemiecki 1 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 4 )  where  id_kurs=6 and id_uczest=8;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=6 and id_uczest=9;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=6 and id_uczest=13;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=6 and id_uczest=15;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 5 )  where  id_kurs=6 and id_uczest=19;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 4 )  where  id_kurs=6 and id_uczest=24;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 4 )  where  id_kurs=6 and id_uczest=27;
-- kurs 7 - niemiecki 1 gr 2
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 4 )  where  id_kurs=7 and id_uczest=11;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 4 )  where  id_kurs=7 and id_uczest=17;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=7 and id_uczest=18;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=7 and id_uczest=23;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 5 )  where  id_kurs=7 and id_uczest=25;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=7 and id_uczest=28;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 600., 3 )  where  id_kurs=7 and id_uczest=30;
-- kurs 8 - niemiecki 2 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 4 )  where  id_kurs=8 and id_uczest=8;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 4 )  where  id_kurs=8 and id_uczest=9;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 3 )  where  id_kurs=8 and id_uczest=13;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 3 )  where  id_kurs=8 and id_uczest=15;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 5 )  where  id_kurs=8 and id_uczest=19;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 3 )  where  id_kurs=8 and id_uczest=24;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 650., 3 )  where  id_kurs=8 and id_uczest=27;
-- kurs 9 - niemiecki 3 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=9 and id_uczest=8;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=9 and id_uczest=9;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 4 )  where  id_kurs=9 and id_uczest=13;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 5 )  where  id_kurs=9 and id_uczest=24;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 800., 5 )  where  id_kurs=9 and id_uczest=27;
-- kurs 10 - hiszpanski 1 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=10 and id_uczest=6;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=10 and id_uczest=16;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=10 and id_uczest=18;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 4 )  where  id_kurs=10 and id_uczest=22;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 5 )  where  id_kurs=10 and id_uczest=24;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 3 )  where  id_kurs=10 and id_uczest=29;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 700., 3 )  where  id_kurs=10 and id_uczest=30;
-- kurs 11 - hiszpanski 2 gr 1
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 4 )  where  id_kurs=11 and id_uczest=6;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 4 )  where  id_kurs=11 and id_uczest=16;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 4 )  where  id_kurs=11 and id_uczest=18;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 4 )  where  id_kurs=11 and id_uczest=22;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 5 )  where  id_kurs=11 and id_uczest=24;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 3 )  where  id_kurs=11 and id_uczest=29;
update lab05.uczest_kurs set ( oplata, ocena ) = ( 900., 3 )  where  id_kurs=11 and id_uczest=30; 


insert into  lab05.organizacja( id_organizacja, nazwa, strona_www ) values
(1, 'Uniwersytet Jagielloński', 'www.uj.edu.pl'),
(2, 'Akademia Górniczo-Hutnicza', 'www.agh.edu.pl');

--
insert into lab05.uczestnik_organizacja ( id_organizacja, id_uczestnik)
VALUES( 1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6),(1, 7),(1, 8),(1, 9)
,(1,10),(1, 11),(1, 12),(1, 13),(1, 14)
,(2, 15),(2, 16),(2, 17),(2, 18),(2, 19),(2, 20),(2, 21),(2, 22)
,(2, 23),(2, 24),(2, 25),(2, 26),(2, 27),(2, 28)
,(2, 3),(2, 8),(1, 19),(1, 21),(1, 25);

--
insert into lab05.uczestnik_organizacja ( id_organizacja, id_wykladowca)
VALUES( 1, 1),(1, 2),(1, 3),(1, 4),(1, 5),(1, 6)
,(2, 7),(2, 8),(2, 9),(2, 10),(2, 11),(2, 12),(2, 13)
,(2, 5);




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




