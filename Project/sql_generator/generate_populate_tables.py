import random
from datetime import datetime


cities = ["Kraków", "Szczebrzeszyn", "Szczecin", "Gdańsk", "Katowice", "Wadowice", "Rzeszów", "Warszawa", "Łódź", "Wrocław", "Pcim", "Koszalin", "Poznań", "Rzeszów", "Kielce", "Bydgoszcz", "Toruń", "Zielona góra", "Opole", "Nowy Sącz"]
streets = ["Bazowadanowa", "Czarnowiejska", "Reymonta", "Górnicza", "Hutnicza", "Programistów", "Devopsów", "Sieciowców", "Jana Pawła II", "Dziekańska", "Rektorska", "Kawowa", "Studencka", "Testerów", "Kernelowa", "Moździeżowa", "Fizyczna", "Informatyczna", "Papieżowa", "Kremówkowa"]
city_codes = [str(random.randrange(1, 100)) + "-" + str(random.randrange(1, 1000)) for _ in range(100)]
vendor_names = ['ASDF z o.o.', 'Qwerty S.A.', 'Januszex z o.o', 'Nosaczpol S.A', 'Wodociągi Kieleckie S.A.', 'Delko S.A', 'Interkarton z o.o.', 'Mirex z o.o']
first_names = ['Jan', 'Andrzej', 'Piotr', 'Krzysztof', 'Stanisław', 'Tomasz', 'Paweł', 'Marcin', 'Marek', 'Michał', 'Grzegorz', 'Adam', 'Zbigniew', 'Ryszard', 'Dariusz', 'Mariusz', 'Rafał']
last_names = ['Abacki', 'Babacki', 'Cabacki', 'Dadacki', 'Januszewski', 'Sosnowski', 'Mróz', 'Tomaszewski', 'Chrabąszczaja', 'Zawadzki', 'Kowalski', 'Nowak', 'Szewczyk']
email_domains = ['example.com', 'gmail.com', 'januszex.pl', 'asdf.pl', 'qwerty.com']
employee_role = ['sprzedawca', 'manager', 'kierownik sklepu']
products = ['bulbulator', 'błotnik do czołgu', 'kabel od internetu', 'kawa', 'woda Vytautas', 'pralka Haier', 'terrarium dla żółwia', 'karma dla gekona', 'lodówka Haier']
promo_codes = ['letmein', 'cheaperplease', 'gonnacallmanager', 'imkaren', 'glovoxd']
vat_rate = [5, 8, 23]


def generate_addresses(num_addresses):
    print("INSERT INTO db_project.adres (miejscowosc, kod_pocztowy, ulica, nr_budynku) VALUES")
    for i in range(num_addresses):
        city = cities[random.randrange(0, len(cities))]
        street = streets[random.randrange(0, len(streets))]
        code = city_codes[random.randrange(0, len(city_codes))]
        building = random.randrange(0, 1000)
        building = 2137 if street == "Jana Pawła II" else building
        print(f"('{city}', '{code}', '{street}', {building}){';' if i == num_addresses - 1 else ','}")


def generate_vendors(num_vendors, num_addresses):
    print("INSERT INTO db_project.dostawca (nazwa, id_adres) VALUES")
    for i in range(num_vendors):
        name = vendor_names[random.randrange(0, len(vendor_names))]
        id_address = random.randrange(1, num_addresses)
        print(f"('{name}', {id_address}){';' if i == num_vendors - 1 else ','}")


def generate_clients(num_clients, num_addresses):
    print("INSERT INTO db_project.klient (imie, nazwisko, id_adres, email, nr_telefonu) VALUES")
    for i in range(num_clients):
        first = first_names[random.randrange(0, len(first_names))]
        last = last_names[random.randrange(0, len(last_names))]
        email = f"{last.lower()}@{email_domains[random.randrange(0, len(email_domains))]}"
        id_address = random.randrange(1, num_addresses)
        phone = ''.join([str(random.randrange(0, 10)) for _ in range(9)])
        print(f"('{first}', '{last}', {id_address}, '{email}', '{phone}'){';' if i == num_clients - 1 else ','}")


def generate_employees(num_employees, num_addresses):
    print("INSERT INTO db_project.pracownik (imie, nazwisko, stanowisko, id_adres, email, nr_telefonu, nr_konta) VALUES")
    for i in range(num_employees):
        first = first_names[random.randrange(0, len(first_names))]
        last = last_names[random.randrange(0, len(last_names))]
        role = employee_role[random.randrange(0, len(employee_role))]
        email = f"{last.lower()}@{email_domains[random.randrange(0, len(email_domains))]}"
        id_address = random.randrange(1, num_addresses)
        phone = ''.join([str(random.randrange(0, 10)) for _ in range(9)])
        account =  ''.join([str(random.randrange(0, 10)) for _ in range(26)])
        print(f"('{first}', '{last}', '{role}', {id_address}, '{email}', '{phone}', '{account}'){';' if i == num_employees - 1 else ','}")


def generate_products(num_products, num_vendors):
    print("INSERT INTO db_project.produkt (nazwa, cena_bazowa, stawka_vat, id_dostawca) VALUES")
    for i in range(num_products):
        name = products[random.randrange(0, len(products))]
        price = random.randrange(0, 10000)
        vat = vat_rate[random.randrange(0, len(vat_rate))]
        vendor = random.randrange(1, num_vendors + 1)
        print(f"('{name}', {price}, {vat}, {vendor}){';' if i == num_products - 1 else ','}")


def generate_availability(num_products):
    print("INSERT INTO db_project.stan_magazynowy (id_produkt, ilosc) VALUES")
    for i in range(num_products):
        availability = random.randrange(0, 43)
        print(f"({i + 1}, {availability}){';' if i == num_products - 1 else ','}")


def generate_promo_codes(num_employees):
    print("INSERT INTO db_project.kod_rabatowy (stawka_procentowa, kwota, kod, limit_uzyc, wykorzystano, id_pracownik) VALUES")
    for i in range(len(promo_codes)):
        if random.randrange(0, 2):
            percent = random.randrange(1, 10) * 5
            amount = 0
        else:
            percent = 0
            amount = random.randrange(1, 10) * 10
        code = promo_codes[random.randrange(0, len(promo_codes))]
        limit = random.randrange(1, 1000)
        used = random.randrange(0, limit + 1)
        employee = random.randrange(1, num_employees + 1)
        print(f"({percent}, {amount}, '{code}', {limit}, {used}, {employee}){';' if i == len(promo_codes) - 1 else ','}")


def generate_carts(num_carts, num_clients):
    print("INSERT INTO db_project.koszyk (id_klient) VALUES")
    clients = [i + 1 for i in range(num_clients)]
    random.shuffle(clients)
    clients = clients[:num_carts]
    for i in range(len(clients)):
        print(f"({clients[i]}){';' if i == num_carts - 1 else ','}")


def generate_cart_products(num_carts, num_products):
    print("INSERT INTO db_project.koszyk_produkt (id_koszyk, id_produkt, ilosc) VALUES")
    first = True
    for i in range(num_carts):
        products_in_cart = []
        for _ in range(random.randrange(1, 10)):
            product = random.randrange(1, num_products + 1)
            quantity = random.randrange(1, 43)
            if product not in products_in_cart:
                products_in_cart.append(product)
                print(('' if first else ',\n') + f"({i + 1}, {product}, {quantity})", end='')
                first = False
    print(';')


def generate_purchases(num_orders, num_products, num_clients, num_promo_codes, num_employees):
    print("INSERT INTO db_project.zakup (ilosc, id_produkt, id_klient, id_kod_rabatowy, nr_zamowienia, id_pracownik, data) VALUES")
    first = True
    for order in range(1, num_orders + 1):
        purchased_products = []
        for _ in range(random.randrange(1, 10)):
            product = random.randrange(1, num_products + 1)
            quantity = random.randrange(1, 43)
            client = random.randrange(1, num_clients + 1)
            code = random.randrange(1, num_promo_codes + 1) if random.randrange(0, 2) else 'NULL'
            employee = random.randrange(1, num_employees + 1)
            time_min = datetime.strptime('01.01.2000', '%d.%m.%Y').timestamp()
            time_max = datetime.strptime('01.01.2022', '%d.%m.%Y').timestamp()
            timestamp = random.randrange(time_min, time_max)
            date = datetime.fromtimestamp(timestamp).strftime('%Y-%m-%d')
            if product not in purchased_products:
                purchased_products.append(product)
                print(('' if first else ',\n') + f"({quantity}, {product}, {client}, {code}, {order}, {employee}, '{date}')", end='')
                first = False
    print(';')


def main():
    num_addresses = 5
    num_vendors = 5
    num_clients = 5
    num_employees = 5
    num_products = 5
    num_carts = 5
    num_orders = 5

    generate_addresses(num_addresses)
    print('')

    generate_vendors(num_vendors, num_addresses)
    print('')

    generate_clients(num_clients, num_addresses)
    print('')

    generate_employees(num_employees, num_addresses)
    print('')

    generate_products(num_products, num_vendors)
    print('')

    generate_availability(num_products)
    print('')

    generate_promo_codes(num_employees)
    print('')

    generate_carts(num_carts, num_clients)
    print('')

    generate_cart_products(num_carts, num_products)
    print('')

    generate_purchases(num_orders, num_products, num_clients, len(promo_codes), num_employees)
    print('')


if __name__ == '__main__':
    main()
