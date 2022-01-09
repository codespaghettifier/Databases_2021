CREATE OR REPLACE FUNCTION lab11.get_table()
RETURNS SETOF lab11.uczestnik AS
$$
    SELECT * FROM lab11.uczestnik;
$$
LANGUAGE SQL; 
