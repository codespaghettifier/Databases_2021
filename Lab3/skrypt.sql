
CREATE TABLE lab03.Wykladowca (
                id_wykladowca INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT wykladowca_pk PRIMARY KEY (id_wykladowca)
);


CREATE TABLE lab03.Kurs_opis (
                id_kurs INTEGER NOT NULL,
                opis VARCHAR(200) NOT NULL,
                CONSTRAINT kurs_opis_pk PRIMARY KEY (id_kurs)
);


CREATE TABLE lab03.Kurs (
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL,
                id_kurs_nazwa INTEGER NOT NULL,
                CONSTRAINT kurs_pk PRIMARY KEY (id_kurs, id_grupa)
);


CREATE TABLE lab03.wykl_kurs (
                id_wykl INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


CREATE TABLE lab03.Uczestnik (
                id_uczestnik INTEGER NOT NULL,
                nazwisko VARCHAR(60) NOT NULL,
                imie VARCHAR(50) NOT NULL,
                CONSTRAINT uczestnik_pk PRIMARY KEY (id_uczestnik)
);


CREATE TABLE lab03.uczest_kurs (
                id_uczest INTEGER NOT NULL,
                id_kurs INTEGER NOT NULL,
                id_grupa INTEGER NOT NULL
);


ALTER TABLE lab03.wykl_kurs ADD CONSTRAINT wykladowca_wykl_kurs_fk
FOREIGN KEY (id_wykl)
REFERENCES lab03.Wykladowca (id_wykladowca)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab03.Kurs ADD CONSTRAINT kurs_opis_kurs_fk
FOREIGN KEY (id_kurs)
REFERENCES lab03.Kurs_opis (id_kurs)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab03.uczest_kurs ADD CONSTRAINT kurs_uczest_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES lab03.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab03.wykl_kurs ADD CONSTRAINT kurs_wykl_kurs_fk
FOREIGN KEY (id_kurs, id_grupa)
REFERENCES lab03.Kurs (id_kurs, id_grupa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lab03.uczest_kurs ADD CONSTRAINT uczestnik_uczest_kurs_fk
FOREIGN KEY (id_uczest)
REFERENCES lab03.Uczestnik (id_uczestnik)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


insert into lab03.kurs_opis ( id_kurs, opis ) values
( 1, 'Jêzyk angielski, stopieñ 1'),
( 2, 'Jêzyk angielski, stopieñ 2'),
( 3, 'Jêzyk angielski, stopieñ 3'), 
( 4, 'Jêzyk angielski, stopieñ 4'),
( 5, 'Jêzyk angielski, stopieñ 5'),
( 6, 'Jêzyk niemiecki, stopieñ 1'),
( 7, 'Jêzyk niemiecki, stopieñ 2'),
( 8, 'Jêzyk niemiecki, stopieñ 3'),
( 9, 'Jêzyk niemiecki, stopieñ 4'),
(10, 'Jêzyk hiszpañski, stopieñ 1'),
(11, 'Jêzyk hiszpañski, stopieñ 2'),
(12, 'Jêzyk hiszpañski, stopieñ 3') ;


insert into lab03.uczestnik ( id_uczestnik, nazwisko, imie ) values 
( 1, 'Flisikowski', 'Jan'),
( 2, 'Olech', 'Andrzej'       ),
( 3, 'P³ochocki', 'Piotr'    ),
( 4, 'Stachyra', 'Krzysztof' ),
( 5, 'Sztuka', 'Stanis³aw'   ),
( 6, 'Sosin', 'Tomasz'       ),
( 7, 'G³owala', 'Pawe³'      ),
( 8, 'Straszewski', 'Józef'  ),
( 9, 'Dwojak', 'Marcin'      ),
(10, 'Kotulski', 'Marek'    ),
(11, '£aski', 'Micha³'       ),
(12, 'Iwanowicz', 'Grzegorz' ),
(13, 'Barna¶', 'Jerzy'       ),
(14, 'Stachera', 'Tadeusz'   ),
(15, 'Gzik', 'Adam'          ),
(16, 'Ca³us', '£ukasz'       ),
(17, 'Ko³odziejek', 'Zbigniew'),
(18, 'Bukowiecki', 'Ryszard' ),
(19, 'Sielicki', 'Dariusz'   ),
(20, 'Radziszewski', 'Henryk'),
(21, 'Szcze¶niak', 'Mariusz' ),
(22, 'Nawara', 'Kazimierz'   ),
(23, 'Kêski', 'Wojciech'     ),
(24, 'Rafalski', 'Robert'    ),
(25, 'Ho³ownia', 'Mateusz'   ),
(26, 'Niedzia³ek', 'Marian'  ),
(27, 'Matuszczak', 'Rafa³'   ),
(28, 'Wolf', 'Jacek'         ),
(29, 'Kolczyñski', 'Janusz'  ),
(30, 'Chrobok', 'Miros³aw'   )  ;


alter table lab03.Kurs add termin VARCHAR;
insert into lab03.kurs ( id_kurs, id_grupa, id_kurs_nazwa, termin ) values
( 1, 1, 1, '1.01.2017-31.03.2017'),
( 2, 2, 1, '1.01.2017-31.03.2017'),
( 3, 1, 2, '1.04.2017-30.06.2017'),
( 4, 1, 3, '1.08.2017-10.10.2017'),
( 5, 1, 4, '1.11.2017-23.12.2017'),
( 6, 1, 6, '1.01.2017-31.03.2017'),
( 7, 2, 6, '1.01.2017-31.03.2017'),
( 8, 1, 7, '1.04.2017-30.06.2017'),
( 9, 1, 8, '1.07.2017-31.07.2017'),
(10, 1, 10, '1.02.2017-31.05.2017'),
(11, 1, 11, '1.09.2017-30.11.2017') ; 


insert into lab03.uczest_kurs ( id_kurs, id_grupa, id_uczest ) values
-- kurs 1 - angielski 1 gr 1
( 1, 1,  1 ),
( 1, 1,  3 ),
( 1, 1,  5 ),
( 1, 1,  7 ),
( 1, 1,  8 ),
( 1, 1, 10 ),
( 1, 1, 11 ),
( 1, 1, 12 ),
-- kurs 2 - angielski 1 gr 2
( 2, 2,  2 ),
( 2, 2, 16 ),
( 2, 2, 17 ),
( 2, 2, 18 ),
( 2, 2, 20 ),
-- kurs 3 - angielski 2 gr 1
( 3, 1,  1 ),
( 3, 1,  2 ),
( 3, 1,  3 ),
( 3, 1,  5 ),
( 3, 1,  7 ),
( 3, 1, 17 ),
( 3, 1, 18 ),
( 3, 1, 20 ),
-- kurs 4 - angielski 3 gr 1
( 4, 1,  1 ),
( 4, 1,  2 ),
( 4, 1,  3 ),
( 4, 1,  5 ),
( 4, 1, 21 ),
( 4, 1, 22 ),
( 4, 1, 25 ),
-- kurs 5 - angielski 4 gr 1
( 5, 1,  1 ),
( 5, 1,  2 ),
( 5, 1,  3 ),
( 5, 1,  5 ),
( 5, 1, 21 ),
( 5, 1, 22 ),
-- kurs 6 - niemiecki 1 gr 1
( 6, 1,  8 ),
( 6, 1,  9 ),
( 6, 1, 13 ),
( 6, 1, 15 ),
( 6, 1, 19 ),
( 6, 1, 24 ),
( 6, 1, 27 ),
-- kurs 7 - niemiecki 1 gr 2
( 7, 2, 11 ),
( 7, 2, 17 ),
( 7, 2, 18 ),
( 7, 2, 23 ),
( 7, 2, 25 ),
( 7, 2, 28 ),
( 7, 2, 30 ),
-- kurs 8 - niemiecki 2 gr 1
( 8, 1,  8 ),
( 8, 1,  9 ),
( 8, 1, 13 ),
( 8, 1, 15 ),
( 8, 1, 19 ),
( 8, 1, 24 ),
( 8, 1, 27 ),
-- kurs 9 - niemiecki 3 gr 1
( 9, 1,  8 ),
( 9, 1,  9 ),
( 9, 1, 13 ),
( 9, 1, 24 ),
( 9, 1, 27 ),
-- kurs 10 - hiszpanski 1 gr 1
(10, 1,  6 ),
(10, 1, 16 ),
(10, 1, 18 ),
(10, 1, 22 ),
(10, 1, 24 ),
(10, 1, 29 ),
(10, 1, 30 ),
-- kurs 11 - hiszpanski 2 gr 1
(11, 1,  6 ),
(11, 1, 16 ),
(11, 1, 18 ),
(11, 1, 22 ),
(11, 1, 24 ),
(11, 1, 29 ),
(11, 1, 30 ) ; 


insert into lab03.wykladowca ( id_wykladowca, imie, nazwisko ) values 
( 1, 'Marcin','Szymczak'),
( 2, 'Joanna','Baranowska'),
( 3, 'Maciej','Szczepa駍ki'),
( 4, 'Czes砤w','Wr骲el'),
( 5, 'Gra縴na','G髍ska'),
( 6, 'Wanda','Krawczyk'),
( 7, 'Renata','Urba駍ka'),
( 8, 'Wies砤wa','Tomaszewska'),
( 9, 'Bo縠na','Baranowska'),
(10, 'Ewelina','Malinowska'),
(11, 'Anna','Krajewska'),
(12, 'Mieczys砤w','Zaj眂'),
(13, 'Wies砤w','Przybylski'),
(14, 'Dorota','Tomaszewska'),
(15, 'Jerzy','Wr骲lewski') ;
--
insert into lab03.wykl_kurs ( id_kurs, id_grupa, id_wykl ) values
( 1, 1, 1 ),
( 2, 2, 2 ),
( 3, 1, 1 ),
( 4, 1, 1 ),
( 5, 1, 3 ),
( 6, 1, 4 ),
( 7, 2, 5 ),
( 8, 1, 4 ),
( 9, 1, 4 ),
(10, 1, 11 ),
(11, 1, 11 ) ; 

