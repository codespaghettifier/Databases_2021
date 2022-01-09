CREATE OR REPLACE FUNCTION lab11.get_cursor() 
RETURNS refcursor AS
$$ 
DECLARE cursor_uczestnik refcursor;
BEGIN
    OPEN cursor_uczestnik FOR SELECT id_uczestnik, imie, nazwisko  FROM lab11.uczestnik;
    RETURN cursor_uczestnik ;
END;
$$ LANGUAGE plpgsql;
