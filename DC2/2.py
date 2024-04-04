def e1():
    name = input("Enter name: ")
    print("Hello, ", name, "!", sep="")

def e2():
    price = int(input("Enter price: "))
    print(price * 1.1)

def e3():
    p, q = map(int, input("Enter price and quantity: ").split())
    print(p * q)

def e4():
    income = int(input("Enter income: "))
    print (income / 4 * 12)

def e5():
    print(max(input().split()))

