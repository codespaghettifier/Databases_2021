import random
from datetime import datetime


def generate_insert_sql(name, params):
    params_str = ''.join([f"{name} {variable_type}, " for name, variable_type in params.items()])[:-2]
    print(f"CREATE OR REPLACE FUNCTION db_project.add_{name}({params_str})")
    print("RETURNS VOID AS")
    print('$$')
    params_str = ''.join([f"{name}, " for name in params.keys()])[:-2]
    print(f"\tINSERT INTO db_project.{name} ({params_str}) VALUES")
    print(f"\t({params_str});")
    print('$$')
    print('LANGUAGE SQL;')


def generate_insert_java(name, sql_name, params):
    params_str = ''.join([f"String {name}, " for name, variable_type in params.items()])[:-2]
    print(f"public String insert{name}({params_str})")
    print('{')
    print('\ttry')
    print('\t{')
    question_marks = ''.join('?, ' for _ in range(len(params)))[:-2]
    print('\t\tCallableStatement callable = connection.prepareCall("{' + f"call db_project.add_{sql_name}({question_marks})" + '}");')
    param_num = 1
    for name, variable_type in params.items():
        second_param = name
        second_param = f"Integer.parseInt({name})" if variable_type == 'int' else second_param
        second_param = f"Float.parseFloat({name})" if variable_type == 'float' else second_param
        print(f"\t\tcallable.set{variable_type[0].upper() + variable_type[1:]}({param_num}, {second_param});")
        param_num += 1
    print('\t\tcallable.executeQuery();')
    print('\t\tcallable.close();')
    print('\t}')
    print('\tcatch (SQLException | NumberFormatException exception)')
    print('\t{')
    print('\t\tSystem.out.println(exception);')
    print('\t\treturn exception.toString();')
    print('\t}')
    print('\treturn "";')
    print('}')


def generate_text_and_table_fields(name, params):
    for param in params.keys():
        print('@FXML')
        print(f"private TextField add{name}{param[0].upper() + param[1:]};")
        print('')
    print('@FXML')
    print(f"private Label {name[0].lower() + name[1:]}ErrorLabel;")
    print('')
    print('@FXML')
    print(f"private TableView<{name}> {name[0].lower() + name[1:]}Table;")
    print('')


def generate_on_action(name, params):
    print('@FXML')
    print(f"protected void add{name}ButtonOnAction()")
    print('{')
    for param, variable_type in params.items():
        print(f"\tString {param} = add{name}{param[0].upper() + param[1:]}.getText();" )
    params_str = ''.join([f"{param}, " for param in params.keys()])[:-2]
    print('')
    print(f"\tString result = db.insert{name}({params_str});")
    print(f"\t{name[0].lower() + name[1:]}ErrorLabel.setText(result);")
    print(f"\t{name[0].lower() + name[1:]}ErrorLabel.setVisible(!result.equals(" + '""' + "));")
    print('}')


def generate_data_class(name, params, sql_params):
    print('package com.example.bd_project;')
    print('')
    print(f"public class {name} extends TableElement")
    print('{')
    print(f"\tpublic int id;")
    for param, variable_type in params.items():
        print(f"\tpublic {variable_type} {param};")
    print('')
    print(f"\tpublic {name}()")
    print('\t{')
    print('')
    print('\t}')
    print('')
    params_str = ''.join([f"{variable_type} {name}, " for name, variable_type in params.items()])[:-2]
    print(f"\tpublic {name}(int id, {params_str})")
    print('\t{')
    print(f"\t\tthis.id = id;")
    for param, variable_type in params.items():
        print(f"\t\tthis.{param} = {param};")
    print('\t}')
    print('\t@Override')
    print('\tpublic int getColumnCount()')
    print('\t{')
    print(f"\t\treturn {len(params) + 1};")
    print('\t}')
    print('')
    print('\t@Override')
    print('\tpublic String getColumnName(int column)')
    print('\t{')
    print('\t\treturn switch (column)')
    print('\t\t{')
    print(f'\t\t\tcase 0 -> "ID";')
    for i in range(len(sql_params)):
        print(f'\t\t\tcase {i + 1} -> "{[j for j in sql_params.keys()][i]}";')
    print('\t\t\tdefault -> null;')
    print('\t\t};')
    print('\t}')
    print('')
    print('\t@Override')
    print('\tpublic String getColumn(int column)')
    print('\t{')
    print('\t\treturn switch (column)')
    print('\t\t{')
    print(f'\t\t\tcase 0 -> Integer.toString(id);')
    param_num = 1
    for name, variable_type in params.items():
        second_param = name
        second_param = f"Integer.toString({name})" if variable_type == 'int' else second_param
        second_param = f"Float.toString({name})" if variable_type == 'float' else second_param
        print(f'\t\t\tcase {param_num} -> {second_param};')
        param_num += 1
    print('\t\t\tdefault -> null;')
    print('\t\t};')
    print('\t}')
    print('}')


def generate_select_all(name, sql_name, sql_params, params):
    print(f"public ArrayList<{name}> selectAll{name}()")
    print('{')
    print(f"\tArrayList<{name}> list = new ArrayList<{name}>();")
    print('\ttry')
    print('\t{')

    params_str = ''.join([f"{name}, " for name in sql_params.keys()])[:-2]
    print(f'\t\tPreparedStatement statement = connection.prepareCall("SELECT id_{sql_name}, {params_str} FROM db_project.{sql_name};", ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);')
    print('\t\tResultSet resultSet = statement.executeQuery();')
    print('\t\twhile(resultSet.next())')
    print('\t\t{')
    print('\t\t\tint id = resultSet.getInt("id_' + sql_name + '");')
    sql_param_names = [i for i in sql_params.keys()]
    param_names = [i for i in params.keys()]
    for i in range(len(sql_param_names)):
        print(f"\t\t\t{params[param_names[i]]} {param_names[i]} = resultSet.get{params[param_names[i]][0].upper() + params[param_names[i]][1:]}(" + '"' + sql_param_names[i] + '"' + ");")
    params_str = ''.join([f"{name}, " for name in params.keys()])[:-2]
    print(f"\t\t\t{name} {name[0].lower() + name[1:]} = new {name}(id, {params_str});")
    print(f"\t\t\tlist.add({name[0].lower() + name[1:]});")
    print('\t\t}')
    print('\t}')
    print('\tcatch (SQLException exception)')
    print('\t{')
    print('\t\tSystem.out.println(exception);')
    print('\t}')
    print('\treturn list;')
    print('}')


def generate_show_table(name):
    print('@FXML')
    print(f"protected void show{name}TableOnAction()")
    print('{')
    print(f"\tpopulateTable({name[0].lower() + name[1:]}Table, new {name}());")
    print('}')


def generate_sql():
    address_params = {'miejscowosc': 'varchar', 'kod_pocztowy': 'varchar', 'ulica': 'varchar', 'nr_budynku': 'int'}
    vendor_params = {'nazwa': 'varchar', 'id_adres': 'int'}
    client_params = {'imie': 'varchar', 'nazwisko': 'varchar', 'id_adres': 'int', 'email': 'varchar', 'nr_telefonu': 'varchar'}
    employee_params = {'imie': 'varchar', 'nazwisko': 'varchar', 'stanowisko': 'varchar', 'id_adres': 'int', 'email': 'varchar', 'nr_telefonu': 'varchar', 'nr_konta': 'varchar'}
    product_params = {'cena_bazowa': 'float', 'stawka_vat': 'float', 'nazwa': 'varchar', 'id_dostawca': 'int'}
    availability_params = {'ilosc': 'int', 'id_produkt': 'int'}
    promo_codes_params = {'stawka_procentowa': 'float', 'kwota': 'float', 'kod': 'varchar', 'limit_uzyc': 'int', 'wykorzystano': 'int', 'id_pracownik': 'int'}
    cart_params = {'id_koszyk': 'int'}
    cart_product_params = {'id_klient': 'int', 'id_produkt': 'int', 'ilosc': 'int'}
    purchase_params = {'ilosc': 'int', 'id_produkt': 'int', 'id_klient': 'int', 'id_kod_rabatowy': 'int', 'nr_zamowienia': 'int', 'id_pracownik': 'int', 'data': 'date'}

    generate_insert_java('adres', address_params)
    print('')

    generate_insert_java('dostawca', vendor_params)
    print('')

    generate_insert_java('klient', client_params)
    print('')

    generate_insert_java('pracownik', employee_params)
    print('')

    generate_insert_java('produkt', product_params)
    print('')

    generate_insert_java('stan_magazynowy', availability_params)
    print('')

    generate_insert_java('kod_rabatowy', promo_codes_params)
    print('')

    generate_insert_java('koszyk', cart_params)
    print('')

    generate_insert_java('koszyk_produkt', cart_product_params)
    print('')

    generate_insert_java('zakup', purchase_params)
    print('')


def generate_java():
    address_params_sql = {'miejscowosc': 'varchar', 'kod_pocztowy': 'varchar', 'ulica': 'varchar', 'nr_budynku': 'int'}
    vendor_params_sql = {'nazwa': 'varchar', 'id_adres': 'int'}
    client_params_sql = {'imie': 'varchar', 'nazwisko': 'varchar', 'id_adres': 'int', 'email': 'varchar', 'nr_telefonu': 'varchar'}
    employee_params_sql = {'imie': 'varchar', 'nazwisko': 'varchar', 'stanowisko': 'varchar', 'id_adres': 'int', 'email': 'varchar', 'nr_telefonu': 'varchar', 'nr_konta': 'varchar'}
    product_params_sql = {'cena_bazowa': 'float', 'stawka_vat': 'float', 'nazwa': 'varchar', 'id_dostawca': 'int'}
    availability_params_sql = {'ilosc': 'int', 'id_produkt': 'int'}
    promo_codes_params_sql = {'stawka_procentowa': 'float', 'kwota': 'float', 'kod': 'varchar', 'limit_uzyc': 'int', 'wykorzystano': 'int', 'id_pracownik': 'int'}
    cart_params_sql = {'id_koszyk': 'int'}
    cart_product_params_sql = {'id_klient': 'int', 'id_produkt': 'int', 'ilosc': 'int'}
    purchase_params_sql = {'ilosc': 'int', 'id_produkt': 'int', 'id_klient': 'int', 'id_kod_rabatowy': 'int', 'nr_zamowienia': 'int', 'id_pracownik': 'int', 'data': 'date'}

    address_params = {'city': 'String', 'postalCode': 'String', 'street': 'String', 'building': 'int'}
    vendor_params = {'name': 'String', 'idAddress': 'int'}
    client_paras = {'firstName': 'String', 'lastName': 'String', 'idAddress': 'int', 'email': 'String', 'phone': 'String'}
    employee_params = {'firstName': 'String', 'lastName': 'String', 'role': 'String', 'idAddress': 'int', 'email': 'String', 'phone': 'String', 'account': 'String'}
    product_params = {'price': 'float', 'vatRate': 'float', 'name': 'String', 'idVendor': 'int'}
    availability_params = {'quantity': 'int', 'idProduct': 'int'}
    promo_codes_params = {'percent': 'float', 'amount': 'float', 'code': 'String', 'limit': 'int', 'used': 'int', 'idEmployee': 'int'}
    cart_params = {'idClient': 'int'}
    cart_product_params = {'idClient': 'int', 'idProduct': 'int', 'quantity': 'int'}
    purchase_params = {'quantity': 'int', 'idProduct': 'int', 'idClient': 'int', 'idPromoCode': 'int', 'orderNum': 'int', 'idEmployee': 'int', 'date': 'Date'}

    def generate_fields():
        generate_text_and_table_fields('Address', address_params)

        generate_text_and_table_fields('Vendor', vendor_params)

        generate_text_and_table_fields('Client', client_paras)

        generate_text_and_table_fields('Employee', employee_params)

        generate_text_and_table_fields('Product', product_params)

        generate_text_and_table_fields('Availability', availability_params)

        generate_text_and_table_fields('PromoCode', promo_codes_params)

        generate_text_and_table_fields('Cart', cart_params)

        generate_text_and_table_fields('CartProduct', cart_product_params)

        generate_text_and_table_fields('Purchase', purchase_params)

    def generate_on_actions():
        generate_on_action('Address', address_params)
        print('')

        generate_on_action('Vendor', vendor_params)
        print('')

        generate_on_action('Client', client_paras)
        print('')

        generate_on_action('Employee', employee_params)
        print('')

        generate_on_action('Product', product_params)
        print('')

        generate_on_action('Availability', availability_params)
        print('')

        generate_on_action('PromoCode', promo_codes_params)
        print('')

        generate_on_action('Cart', cart_params)
        print('')

        generate_on_action('CartProduct', cart_product_params)
        print('')

        generate_on_action('Purchase', purchase_params)
        print('')

    def generate_inserts():
        generate_insert_java('Address', 'adres', address_params)
        print('')

        generate_insert_java('Vendor', 'dostawca', vendor_params)
        print('')

        generate_insert_java('Client', 'klient', client_paras)
        print('')

        generate_insert_java('Employee', 'pracownik', employee_params)
        print('')

        generate_insert_java('Product', 'produkt', product_params)
        print('')

        generate_insert_java('Availability', 'stan_magazynowy', availability_params)
        print('')

        generate_insert_java('PromoCode', 'kod_rabatowy', promo_codes_params)
        print('')

        generate_insert_java('Cart', 'koszyk', cart_params)
        print('')

        generate_insert_java('CartProduct', 'koszyk_produkt', cart_product_params)
        print('')

        generate_insert_java('Purchase', 'zakup', purchase_params)
        print('')

    def generate_data_classes():
        generate_data_class('Address', address_params, address_params_sql)
        print('')

        generate_data_class('Vendor', vendor_params, vendor_params_sql)
        print('')

        generate_data_class('Client', client_paras, client_params_sql)
        print('')

        generate_data_class('Employee', employee_params, employee_params_sql)
        print('')

        generate_data_class('Product', product_params, product_params_sql)
        print('')

        generate_data_class('Availability', availability_params, availability_params_sql)
        print('')

        generate_data_class('PromoCode', promo_codes_params, promo_codes_params_sql)
        print('')

        generate_data_class('Cart', cart_params, cart_params_sql)
        print('')

        generate_data_class('CartProduct', cart_product_params, cart_product_params_sql)
        print('')

        generate_data_class('Purchase', purchase_params, purchase_params_sql)
        print('')

    def generate_select_alls():
        generate_select_all('Address', 'adres', address_params_sql, address_params)
        print('')

        generate_select_all('Vendor', 'dostawca', vendor_params_sql, vendor_params)
        print('')

        generate_select_all('Client', 'klient', client_params_sql, client_paras)
        print('')

        generate_select_all('Employee', 'pracownik', employee_params_sql, employee_params)
        print('')

        generate_select_all('Product', 'produkt', product_params_sql, product_params)
        print('')

        generate_select_all('Availability', 'stan_magazynowy', availability_params_sql, availability_params)
        print('')

        generate_select_all('PromoCode', 'kod_rabatowy', promo_codes_params_sql, promo_codes_params)
        print('')

        generate_select_all('Cart', 'koszyk', cart_params_sql, cart_params)
        print('')

        generate_select_all('CartProduct', 'koszyk_produkt', cart_product_params_sql, cart_product_params)
        print('')

        generate_select_all('Purchase', 'zakup', purchase_params_sql, purchase_params)
        print('')

    def generate_show_tables():
        generate_show_table('Address')
        print('')

        generate_show_table('Vendor')
        print('')

        generate_show_table('Client')
        print('')

        generate_show_table('Employee')
        print('')

        generate_show_table('Product')
        print('')

        generate_show_table('Availability')
        print('')

        generate_show_table('PromoCode')
        print('')

        generate_show_table('Cart')
        print('')

        generate_show_table('CartProduct')
        print('')

        generate_show_table('Purchase')
        print('')

    # generate_fields()
    generate_on_actions()
    # generate_inserts()
    # generate_data_classes()
    # generate_select_alls()
    # generate_show_tables()


def main():
    # generate_sql()
    generate_java()


if __name__ == '__main__':
    main()
