package com.example.bd_project;

public class Availability extends TableElement
{
    public int id;
    public int quantity;
    public int idProduct;

    public Availability()
    {

    }

    public Availability(int id, int quantity, int idProduct)
    {
        this.id = id;
        this.quantity = quantity;
        this.idProduct = idProduct;
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
                    case 1 -> "ilosc";
                    case 2 -> "id_produkt";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> Integer.toString(quantity);
                    case 2 -> Integer.toString(idProduct);
                    default -> null;
                };
    }
}