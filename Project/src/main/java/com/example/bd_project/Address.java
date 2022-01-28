package com.example.bd_project;

public class Address extends TableElement
{
    public int id;
    public String city;
    public String postalCode;
    public String street;
    public int building;

    public Address()
    {

    }

    public Address(int id, String city, String postalCode, String street, int building)
    {
        this.id = id;
        this.city = city;
        this.postalCode = postalCode;
        this.street = street;
        this.building = building;
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
                    case 1 -> "miejscowosc";
                    case 2 -> "kod_pocztowy";
                    case 3 -> "ulica";
                    case 4 -> "nr_budynku";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> city;
                    case 2 -> postalCode;
                    case 3 -> street;
                    case 4 -> Integer.toString(building);
                    default -> null;
                };
    }
}
