package com.example.bd_project;

import java.util.ArrayList;

public class SelectResultRecord extends TableElement
{
    private final ArrayList<String> names = new ArrayList<String>();
    private final ArrayList<String> values = new ArrayList<String>();
    private final int columnCount;

    public SelectResultRecord(int columnCount)
    {
        this.columnCount = columnCount;
    }

    public void addColumn(String name, String value)
    {
        names.add(name);
        values.add(value);
    }

    @Override
    public int getColumnCount()
    {
        return columnCount;
    }

    @Override
    public String getColumnName(int column)
    {
        return names.get(column);
    }

    @Override
    public String getColumn(int column)
    {
        return values.get(column);
    }
}
