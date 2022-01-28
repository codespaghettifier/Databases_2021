package com.example.bd_project;

import java.sql.*;
import java.util.ArrayList;

public class DatabaseController
{
    private static final String URL = "jdbc:postgresql://localhost:5432/db_project";
    private static final String USER = "db_project_role";
    private static final String PASSWORD = "password";
    private Connection connection = null;

    DatabaseController()
    {
        try
        {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connected to db");
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
    }

    public String insertAddress(String city, String postalCode, String street, String building)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_adres(?, ?, ?, ?)}");
            callable.setString(1, city);
            callable.setString(2, postalCode);
            callable.setString(3, street);
            callable.setInt(4, Integer.parseInt(building));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertVendor(String name, String idAddress)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_dostawca(?, ?)}");
            callable.setString(1, name);
            callable.setInt(2, Integer.parseInt(idAddress));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertClient(String firstName, String lastName, String idAddress, String email, String phone)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_klient(?, ?, ?, ?, ?)}");
            callable.setString(1, firstName);
            callable.setString(2, lastName);
            callable.setInt(3, Integer.parseInt(idAddress));
            callable.setString(4, email);
            callable.setString(5, phone);
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertEmployee(String firstName, String lastName, String role, String idAddress, String email, String phone, String account)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_pracownik(?, ?, ?, ?, ?, ?, ?)}");
            callable.setString(1, firstName);
            callable.setString(2, lastName);
            callable.setString(3, role);
            callable.setInt(4, Integer.parseInt(idAddress));
            callable.setString(5, email);
            callable.setString(6, phone);
            callable.setString(7, account);
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertProduct(String price, String vatRate, String name, String idVendor)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_produkt(?, ?, ?, ?)}");
            callable.setFloat(1, Float.parseFloat(price));
            callable.setFloat(2, Float.parseFloat(vatRate));
            callable.setString(3, name);
            callable.setInt(4, Integer.parseInt(idVendor));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertAvailability(String quantity, String idProduct)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_stan_magazynowy(?, ?)}");
            callable.setInt(1, Integer.parseInt(quantity));
            callable.setInt(2, Integer.parseInt(idProduct));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertPromoCode(String percent, String amount, String code, String limit, String used, String idEmployee)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_kod_rabatowy(?, ?, ?, ?, ?, ?)}");
            callable.setFloat(1, Float.parseFloat(percent));
            callable.setFloat(2, Float.parseFloat(amount));
            callable.setString(3, code);
            callable.setInt(4, Integer.parseInt(limit));
            callable.setInt(5, Integer.parseInt(used));
            callable.setInt(6, Integer.parseInt(idEmployee));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertCart(String idClient)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_koszyk(?)}");
            callable.setInt(1, Integer.parseInt(idClient));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertCartProduct(String idClient, String idProduct, String quantity)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_koszyk_produkt(?, ?, ?)}");
            callable.setInt(1, Integer.parseInt(idClient));
            callable.setInt(2, Integer.parseInt(idProduct));
            callable.setInt(3, Integer.parseInt(quantity));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public String insertPurchase(String quantity, String idProduct, String idClient, String idPromoCode, String orderNum, String idEmployee, java.util.Date date)
    {
        try
        {
            CallableStatement callable = connection.prepareCall("{call db_project.add_zakup(?, ?, ?, ?, ?, ?, ?)}");
            callable.setInt(1, Integer.parseInt(quantity));
            callable.setInt(2, Integer.parseInt(idProduct));
            callable.setInt(3, Integer.parseInt(idClient));
            if(idPromoCode.equals(""))
            {
                callable.setNull(4, Types.INTEGER);
            }
            else
            {
                callable.setInt(4, Integer.parseInt(idPromoCode));
            }
            callable.setInt(5, Integer.parseInt(orderNum));
            callable.setInt(6, Integer.parseInt(idEmployee));
            callable.setDate(7, new java.sql.Date(date.getTime()));
            callable.executeQuery();
            callable.close();
        }
        catch (SQLException | NumberFormatException exception)
        {
            System.out.println(exception);
            return exception.toString();
        }
        return "";
    }

    public <T> ArrayList<T> selectAll(Class<T> type)
    {
        if(type.equals(Address.class))
        {
            return (ArrayList<T>)selectAllAddress();
        }
        else if(type.equals(Vendor.class))
        {
            return (ArrayList<T>)selectAllVendor();
        }
        else if(type.equals(Client.class))
        {
            return (ArrayList<T>)selectAllClient();
        }
        else if(type.equals(Employee.class))
        {
            return (ArrayList<T>)selectAllEmployee();
        }
        else if(type.equals(Product.class))
        {
            return (ArrayList<T>)selectAllProduct();
        }
        else if(type.equals(Availability.class))
        {
            return (ArrayList<T>)selectAllAvailability();
        }
        else if(type.equals(PromoCode.class))
        {
            return (ArrayList<T>)selectAllPromoCode();
        }
        else if(type.equals(Cart.class))
        {
            return (ArrayList<T>)selectAllCart();
        }
        else if(type.equals(CartProduct.class))
        {
            return (ArrayList<T>)selectAllCartProduct();
        }
        else if(type.equals(Purchase.class))
        {
            return (ArrayList<T>)selectAllPurchase();
        }

        return null;
    }

    public ArrayList<Address> selectAllAddress()
    {
        ArrayList<Address> list = new ArrayList<Address>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_adres, miejscowosc, kod_pocztowy, ulica, nr_budynku FROM db_project.adres;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_adres");
                String city = resultSet.getString("miejscowosc");
                String postalCode = resultSet.getString("kod_pocztowy");
                String street = resultSet.getString("ulica");
                int building = resultSet.getInt("nr_budynku");
                Address address = new Address(id, city, postalCode, street, building);
                list.add(address);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Vendor> selectAllVendor()
    {
        ArrayList<Vendor> list = new ArrayList<Vendor>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_dostawca, nazwa, id_adres FROM db_project.dostawca;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_dostawca");
                String name = resultSet.getString("nazwa");
                int idAddress = resultSet.getInt("id_adres");
                Vendor vendor = new Vendor(id, name, idAddress);
                list.add(vendor);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Client> selectAllClient()
    {
        ArrayList<Client> list = new ArrayList<Client>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_klient, imie, nazwisko, id_adres, email, nr_telefonu FROM db_project.klient;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_klient");
                String firstName = resultSet.getString("imie");
                String lastName = resultSet.getString("nazwisko");
                int idAddress = resultSet.getInt("id_adres");
                String email = resultSet.getString("email");
                String phone = resultSet.getString("nr_telefonu");
                Client client = new Client(id, firstName, lastName, idAddress, email, phone);
                list.add(client);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Employee> selectAllEmployee()
    {
        ArrayList<Employee> list = new ArrayList<Employee>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_pracownik, imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta FROM db_project.pracownik;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_pracownik");
                String firstName = resultSet.getString("imie");
                String lastName = resultSet.getString("nazwisko");
                String role = resultSet.getString("stanowisko");
                int idAddress = resultSet.getInt("id_adres");
                String email = resultSet.getString("email");
                String phone = resultSet.getString("nr_telefonu");
                String account = resultSet.getString("nr_konta");
                Employee employee = new Employee(id, firstName, lastName, role, idAddress, email, phone, account);
                list.add(employee);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Product> selectAllProduct()
    {
        ArrayList<Product> list = new ArrayList<Product>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_produkt, cena_bazowa, stawka_vat, nazwa, id_dostawca FROM db_project.produkt;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_produkt");
                float price = resultSet.getFloat("cena_bazowa");
                float vatRate = resultSet.getFloat("stawka_vat");
                String name = resultSet.getString("nazwa");
                int idVendor = resultSet.getInt("id_dostawca");
                Product product = new Product(id, price, vatRate, name, idVendor);
                list.add(product);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Availability> selectAllAvailability()
    {
        ArrayList<Availability> list = new ArrayList<Availability>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_stan_magazynowy, ilosc, id_produkt FROM db_project.stan_magazynowy;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_stan_magazynowy");
                int quantity = resultSet.getInt("ilosc");
                int idProduct = resultSet.getInt("id_produkt");
                Availability availability = new Availability(id, quantity, idProduct);
                list.add(availability);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<PromoCode> selectAllPromoCode()
    {
        ArrayList<PromoCode> list = new ArrayList<PromoCode>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_kod_rabatowy, stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik FROM db_project.kod_rabatowy;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_kod_rabatowy");
                float percent = resultSet.getFloat("stawka_procentowa");
                float amount = resultSet.getFloat("kwota");
                String code = resultSet.getString("kod");
                int limit = resultSet.getInt("limit_uzyc");
                int used = resultSet.getInt("wykorzystano");
                int idEmployee = resultSet.getInt("id_pracownik");
                PromoCode promoCode = new PromoCode(id, percent, amount, code, limit, used, idEmployee);
                list.add(promoCode);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Cart> selectAllCart()
    {
        ArrayList<Cart> list = new ArrayList<Cart>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_koszyk, id_klient FROM db_project.koszyk;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_koszyk");
                int idClient = resultSet.getInt("id_klient");
                Cart cart = new Cart(id, idClient);
                list.add(cart);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<CartProduct> selectAllCartProduct()
    {
        ArrayList<CartProduct> list = new ArrayList<CartProduct>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_koszyk_produkt, id_koszyk, id_produkt, ilosc FROM db_project.koszyk_produkt;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_koszyk_produkt");
                int idClient = resultSet.getInt("id_koszyk");
                int idProduct = resultSet.getInt("id_produkt");
                int quantity = resultSet.getInt("ilosc");
                CartProduct cartProduct = new CartProduct(id, idClient, idProduct, quantity);
                list.add(cartProduct);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }

    public ArrayList<Purchase> selectAllPurchase()
    {
        ArrayList<Purchase> list = new ArrayList<Purchase>();
        try
        {
            PreparedStatement statement = connection.prepareCall("SELECT id_zakup, ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data FROM db_project.zakup;", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next())
            {
                int id = resultSet.getInt("id_zakup");
                int quantity = resultSet.getInt("ilosc");
                int idProduct = resultSet.getInt("id_produkt");
                int idClient = resultSet.getInt("id_klient");
                int idPromoCode = resultSet.getInt("id_kod_rabatowy");
                int orderNum = resultSet.getInt("nr_zamowienia");
                int idEmployee = resultSet.getInt("id_pracownik");
                Date date = resultSet.getDate("data");
                Purchase purchase = new Purchase(id, quantity, idProduct, idClient, idPromoCode, orderNum, idEmployee, date);
                list.add(purchase);
            }
        }
        catch (SQLException exception)
        {
            System.out.println(exception);
        }
        return list;
    }
}
