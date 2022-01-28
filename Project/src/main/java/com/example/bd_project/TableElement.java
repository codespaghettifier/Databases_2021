package com.example.bd_project;

public abstract class TableElement
{
    public abstract int getColumnCount();
    public abstract String getColumnName(int column);
    public abstract String getColumn(int column);
}
