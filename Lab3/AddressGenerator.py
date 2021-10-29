import random

def main():
    codes = [str(random.randrange(1, 100)) + "-" + str(random.randrange(1, 1000)) for _ in range(100)]
    streets = ["Bazowadanowa", "Czarnowiejska", "Reymonta", "Górnicza", "Hutnicza", "Programistów", "Devopsów", "Sieciowców", "Jana Pawła II", "Dziekańska", "Rektorska", "Kawowa", "Studencka", "Testerów", "Kernelowa", "Moździeżowa", "Fizyczna", "Informatyczna", "Papieżowa", "Kremówkowa"]
    places = ["Kraków", "Szczebrzeszyn", "Szczecin", "Gdańsk", "Katowice", "Wadowice", "Rzeszów", "Warszawa", "Łódź", "Wrocław", "Pcim", "Koszalin", "Poznań", "Rzeszów", "Kielce", "Bydgoszcz", "Toruń", "Zielona góra", "Opole", "Nowy Sącz"]

    print("INSERT INTO lab03.temp_adres (id_uczestnik, kod_pocztowy, adres, miejscowosc) VALUES")
    for i in range(1, 31):
        print("(" + str(i) + ", '" + codes[random.randrange(0, len(codes))] + "', '" + streets[random.randrange(0, len(streets))] + " " + str(random.randrange(1, 100)) + "', '" + places[random.randrange(0, len(places))] + "')" + (";" if i == 30 else ","))

if __name__ == '__main__':
    main()

