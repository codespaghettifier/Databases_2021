package com.example.bd_project;

public class Purchase extends TableElement
{
    public int id;
    public int quantity;
    public int idProduct;
    public int idClient;
    public int idPromoCode;
    public int orderNum;
    public int idEmployee;
    public java.util.Date date;

    public Purchase()
    {

    }

    public Purchase(int id, int quantity, int idProduct, int idClient, int idPromoCode, int orderNum, int idEmployee, java.util.Date date)
    {
        this.id = id;
        this.quantity = quantity;
        this.idProduct = idProduct;
        this.idClient = idClient;
        this.idPromoCode = idPromoCode;
        this.orderNum = orderNum;
        this.idEmployee = idEmployee;
        this.date = date;
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
                    case 1 -> "ilosc";
                    case 2 -> "id_produkt";
                    case 3 -> "id_klient";
                    case 4 -> "id_kod_rabatowy";
                    case 5 -> "nr_zamowienia";
                    case 6 -> "id_pracownik";
                    case 7 -> "data";
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
                    case 3 -> Integer.toString(idClient);
                    case 4 -> Integer.toString(idPromoCode);
                    case 5 -> Integer.toString(orderNum);
                    case 6 -> Integer.toString(idEmployee);
                    case 7 -> date.toString();
                    default -> null;
                };
    }
}