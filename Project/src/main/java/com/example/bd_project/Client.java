package com.example.bd_project;

public class Client extends TableElement
{
    public int id;
    public String firstName;
    public String lastName;
    public int idAddress;
    public String email;
    public String phone;

    public Client()
    {

    }

    public Client(int id, String firstName, String lastName, int idAddress, String email, String phone)
    {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.idAddress = idAddress;
        this.email = email;
        this.phone = phone;
    }
    @Override
    public int getColumnCount()
    {
        return 6;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "imie";
                    case 2 -> "nazwisko";
                    case 3 -> "id_adres";
                    case 4 -> "email";
                    case 5 -> "nr_telefonu";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> firstName;
                    case 2 -> lastName;
                    case 3 -> Integer.toString(idAddress);
                    case 4 -> email;
                    case 5 -> phone;
                    default -> null;
                };
    }
}
