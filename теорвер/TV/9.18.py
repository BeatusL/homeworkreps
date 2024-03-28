from random import randint

tr = 100000 # количество тестов
pos = 0 # счётчик положительных результатов

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    p1 = 0
    p2 = 0
    while True:
        res = randint(1, 10)

        if res <= 2:
            p1 += 1
        elif res >= 9:
            p2 += 1
        else:
            p1 += 0.5
            p2 += 0.5

        if (p1 == 12 and p2 == 8) or (p2 == 12 and p1 == 8):
            pos += 1
        elif p1 > 12 or p2 > 12:
            break


print("--------------")
print(pos/tr)