package com.example.bd_project;

public class Product extends TableElement
{
    public int id;
    public float price;
    public float vatRate;
    public String name;
    public int idVendor;

    public Product()
    {

    }

    public Product(int id, float price, float vatRate, String name, int idVendor)
    {
        this.id = id;
        this.price = price;
        this.vatRate = vatRate;
        this.name = name;
        this.idVendor = idVendor;
    }
    @Override
    public int getColumnCount()
    {
        return 5;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "cena_bazowa";
                    case 2 -> "stawka_vat";
                    case 3 -> "nazwa";
                    case 4 -> "id_dostawca";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> Float.toString(price);
                    case 2 -> Float.toString(vatRate);
                    case 3 -> name;
                    case 4 -> Integer.toString(idVendor);
                    default -> null;
                };
    }
}
