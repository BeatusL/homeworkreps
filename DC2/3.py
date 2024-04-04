def e1():
    num = int(input("Enter number: "))
    print("Number", num, "is", end=" ")
    if num % 2 == 0:
        print("even")
    else:
        print("odd")

def e2():
    age = int(input("Введите возраст: "))
    if 0 <= age <= 17:
        print("Детский возраст")
    elif 18 <= age <= 44:
        print("Молодой возраст")
    elif 45 <= age <= 59:
        print("Средний возраст")
    elif 60 <= age <= 74:
        print("Пожилой возраст")
    elif 75 <= age <= 90:
        print("Старческий возраст")
    elif age > 90:
        print("Долгожители")
    else:
        print("Ошибочка")

def e3():
    str = input("Enter string: ")
    for s in str:
        print(s)

def e4():
    num = int(input("Enter number: "))
    for i in range(1, 11):
        print(num, "x", i, "=", num * i)

def e5():
    num = int(input("Enter number: "))
    for i in range(11, num + 1):
        if str(i) == str(i)[::-1]:
            print(i, end=" ")
