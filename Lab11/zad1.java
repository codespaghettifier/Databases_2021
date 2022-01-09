import java.sql.*;

public class zad1
{
    public static void main(String[] argv)
    {
        Connection c = null;

        try
        {
//            c = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u9libucha", "u9libucha", "9libucha");
            c = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:2137/u9libucha", "u9libucha", "9libucha");
        }
        catch (SQLException se)
        {
            System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
            se.printStackTrace();
            System.exit(1);
        }
        if (c != null)
        {
            System.out.println("Polaczenie z baza danych OK ! ");
            try
            {
                //  Wykonanie zapytania SELECT do bazy danych
                //  Wykorzystane elementy: prepareStatement(), executeQuery()
                String query = "SELECT imie, nazwisko, opis FROM lab11.uczestnik "
                        + "JOIN lab11.uczest_kurs ON uczest_kurs.id_uczest = uczestnik.id_uczestnik "
                        + "JOIN lab11.kurs ON kurs.id_kurs = uczest_kurs.id_kurs "
                        + "JOIN lab11.kurs_opis ON kurs_opis.id_kurs = kurs.id_kurs;";
                PreparedStatement pst = c.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
                ResultSet rs = pst.executeQuery();
                while (rs.next())
                {
                    String imie = rs.getString("imie") ;
                    String nazwisko = rs.getString("nazwisko") ;
                    String opis = rs.getString("opis") ;
                    System.out.println(opis + "\t" + nazwisko + "\t" + imie) ;
                }
                rs.close();
                pst.close();
            }
            catch(SQLException e)
            {
                System.out.println("Blad podczas przetwarzania danych:"+e) ;
            }
        }
        else System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");
    }
} 

