package com.example.bd_project;

public class PromoCode extends TableElement
{
    public int id;
    public float percent;
    public float amount;
    public String code;
    public int limit;
    public int used;
    public int idEmployee;

    public PromoCode()
    {

    }

    public PromoCode(int id, float percent, float amount, String code, int limit, int used, int idEmployee)
    {
        this.id = id;
        this.percent = percent;
        this.amount = amount;
        this.code = code;
        this.limit = limit;
        this.used = used;
        this.idEmployee = idEmployee;
    }
    @Override
    public int getColumnCount()
    {
        return 7;
    }

    @Override
    public String getColumnName(int column)
    {
        return switch (column)
                {
                    case 0 -> "ID";
                    case 1 -> "stawka_procentowa";
                    case 2 -> "kwota";
                    case 3 -> "kod";
                    case 4 -> "limit_uzyc";
                    case 5 -> "wykorzystano";
                    case 6 -> "id_pracownik";
                    default -> null;
                };
    }

    @Override
    public String getColumn(int column)
    {
        return switch (column)
                {
                    case 0 -> Integer.toString(id);
                    case 1 -> Float.toString(percent);
                    case 2 -> Float.toString(amount);
                    case 3 -> code;
                    case 4 -> Integer.toString(limit);
                    case 5 -> Integer.toString(used);
                    case 6 -> Integer.toString(idEmployee);
                    default -> null;
                };
    }
}