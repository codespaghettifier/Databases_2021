import java.sql.*;

public class zad4
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
                String query = "UPDATE lab11.uczestnik SET (email) = (?) "
                        + "WHERE uczestnik.id_uczestnik = (?);";
                PreparedStatement pst = c.prepareStatement(query, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

                pst.setString(1, "olech@example.com");
                pst.setInt(2, 2);
                int rows = pst.executeUpdate();
                System.out.println("Zmienionych rekordów: " + rows);

                pst.setString(1, "plochacki@example.com");
                pst.setInt(2, 3);
                rows = pst.executeUpdate();
                System.out.println("Zmienionych rekordów: " + rows);

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

