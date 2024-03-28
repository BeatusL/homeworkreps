from random import randint

tr = 100000 # количество тестов
pos1 = 0
pos2 = 0

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    p1 = 0
    p2 = 0
    while True:
        if randint(1, 5) <= 2: p1 += 1
        else: p2 += 1

        if (p1 == 4) and (p2 <= 2):
            pos1 += 1
            break
        elif (p2 == 4) and (p1 <= 2):
            pos2 += 1
            break
        elif p1 == 5:
            pos1 += 1
            break
        elif p2 == 5:
            pos2 += 1
            break

print("--------------")
print(pos1/tr)
print(pos2/tr)