package com.example.bd_project;

public class Employee extends TableElement
{
    public int id;
    public String firstName;
    public String lastName;
    public String role;
    public int idAddress;
    public String email;
    public String phone;
    public String account;

    public Employee()
    {

    }

    public Employee(int id, String firstName, String lastName, String role, int idAddress, String email, String phone, String account)
    {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.role = role;
        this.idAddress = idAddress;
        this.email = email;
        this.phone = phone;
        this.account = account;
    }
    @Override
    public int getColumnCount()
    {
        return 8;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "imie";
                    case 2 -> "nazwisko";
                    case 3 -> "stanowisko";
                    case 4 -> "id_adres";
                    case 5 -> "email";
                    case 6 -> "nr_telefonu";
                    case 7 -> "nr_konta";
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
                    case 3 -> role;
                    case 4 -> Integer.toString(idAddress);
                    case 5 -> email;
                    case 6 -> phone;
                    case 7 -> account;
                    default -> null;
                };
    }
}