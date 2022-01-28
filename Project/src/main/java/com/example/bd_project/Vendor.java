package com.example.bd_project;

public class Vendor extends TableElement
{
    public int id;
    public String name;
    public int idAddress;

    public Vendor()
    {

    }

    public Vendor(int id, String name, int idAddress)
    {
        this.id = id;
        this.name = name;
        this.idAddress = idAddress;
    }
    @Override
    public int getColumnCount()
    {
        return 3;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "nazwa";
                    case 2 -> "id_adres";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> name;
                    case 2 -> Integer.toString(idAddress);
                    default -> null;
                };
    }
}