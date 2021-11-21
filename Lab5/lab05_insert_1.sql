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


