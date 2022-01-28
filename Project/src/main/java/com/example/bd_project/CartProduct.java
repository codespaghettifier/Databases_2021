package com.example.bd_project;

public class CartProduct extends TableElement
{
    public int id;
    public int idClient;
    public int idProduct;
    public int quantity;

    public CartProduct()
    {

    }

    public CartProduct(int id, int idClient, int idProduct, int quantity)
    {
        this.id = id;
        this.idClient = idClient;
        this.idProduct = idProduct;
        this.quantity = quantity;
    }
    @Override
    public int getColumnCount()
    {
        return 4;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "id_koszyk";
                    case 2 -> "id_produkt";
                    case 3 -> "ilosc";
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
                    case 2 -> Integer.toString(idProduct);
                    case 3 -> Integer.toString(quantity);
                    default -> null;
                };
    }
}