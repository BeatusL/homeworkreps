from random import randint

tr = 500000 # количество тестов
pos = 0 # счётчик положительных результатов
count = 0

for i in range(tr):
    fl = True
    if i / tr * 100 % 1 == 0:
        print(i / tr * 100)

    c = randint(0, 5)
    ar = []
    for _ in range(c):
        place = randint(1, 1000)
        while place in ar: place = randint(1, 1000)
        ar.append(place)
    ar2 = []
    for _ in range(1, 100):
        place = randint(1, 1000)
        while place in ar2: place = randint(1, 1000)
        ar2.append(place)
        if place in ar:
            fl = False
            break

    if fl:
        count += 1
        if c == 0:
            pos += 1


print("--------------")
print(pos/count)
print(count)
