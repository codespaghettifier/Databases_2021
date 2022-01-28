package com.example.bd_project;

public class Cart extends TableElement
{
    public int id;
    public int idClient;

    public Cart()
    {

    }

    public Cart(int id, int idClient)
    {
        this.id = id;
        this.idClient = idClient;
    }
    @Override
    public int getColumnCount()
    {
        return 2;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "id_klient";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> Integer.toString(idClient);
                    default -> null;
                };
    }
}