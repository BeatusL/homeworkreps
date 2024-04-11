def message():
    a, b = input().split()
    print("Здравствуйте, ", a, " ", b, "! Вы верно выполнили задание!", sep="")


def sum_numbers():
    n = int(input())
    sum = 0
    for i in range(1, n + 1):
        sum += i
    print("Сумма чисел от 0 до", n, "=", sum)


def e3():
    n = int(input())
    if n % 2 == 0:
        print(n * n)
    else:
        print(n)

def is_long():
    print(len(input()) >= 20)

def get_statistics(a):
    print("Самое большое число: ", max(a), "; Самое маленькое число: ", min(a), "; Сумма всех чисел: ", sum(a), sep="")
