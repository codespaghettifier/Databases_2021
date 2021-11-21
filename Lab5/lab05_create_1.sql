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