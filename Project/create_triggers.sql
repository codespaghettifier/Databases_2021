CREATE OR REPLACE FUNCTION db_project.validate_adres()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.miejscowosc !~ '^[A-Z][a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa miejscowości';
    END IF;
    IF NEW.kod_pocztowy !~ '^[0-9]{2}-[0-9]{3}$' THEN
        RAISE EXCEPTION 'Nieprawidłowy kod pocztowy';
    END IF;
    IF NEW.ulica !~ '^[A-Z][a-z]*$' THEN
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
    IF NEW.nazwa !~ '^[A-Za-z\.\-0-9[:space:]]*$' THEN
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
    IF NEW.imie !~ '^[A-Z][a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe imię';
    END IF;
    IF NEW.nazwisko !~ '^[A-Z][a-z]*$' THEN
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
    IF NEW.imie !~ '^[A-Z][a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe imię';
    END IF;
    IF NEW.nazwisko !~ '^[A-Z][a-z]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowe nazwisko';
    END IF;
    IF NEW.stanowisko !~ '^[a-z]*$' THEN
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
    IF NEW.nazwa !~ '^[A-Za-z0-9\-@[:space:]]*$' THEN
        RAISE EXCEPTION 'Nieprawidłowa nazwa';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_produkt ON db_project.produkt;
CREATE TRIGGER trigger_validate_produkt
    BEFORE INSERT OR UPDATE ON db_project.produkt
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_produkt();


CREATE OR REPLACE FUNCTION db_project.validate_stan_magazynowy()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.ilosc <= 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
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
    IF NEW.ilosc < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_koszyk_produkt ON db_project.koszyk_produkt;
CREATE TRIGGER trigger_validate_koszyk_produkt
    BEFORE INSERT OR UPDATE ON db_project.koszyk_produkt
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_koszyk_produkt();

DROP TRIGGER trigger_validate_kod_rabatowy ON db_project.kod_rabatowy;
CREATE TRIGGER trigger_validate_kod_rabatowy
    BEFORE INSERT OR UPDATE ON db_project.kod_rabatowy
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_kod_rabatowy();


CREATE OR REPLACE FUNCTION db_project.validate_zakup()
RETURNS TRIGGER AS
$$ BEGIN
    IF NEW.ilosc < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowa ilość';
    END IF;
    IF NEW.ilosc < 0 THEN
        RAISE EXCEPTION 'Nieprawidłowy numer zamówienia';
    END IF;
    RETURN NEW;
END $$ LANGUAGE 'plpgsql';

DROP TRIGGER trigger_validate_zakup ON db_project.zakup;
CREATE TRIGGER trigger_validate_zakup
    BEFORE INSERT OR UPDATE ON db_project.zakup
    FOR EACH ROW EXECUTE PROCEDURE db_project.validate_zakup();