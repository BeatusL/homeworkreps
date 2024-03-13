from random import randint

tr = 10000000 # количество тестов
pos = 0 # счётчик положительных результатов

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    counter = 0
    ar = ["w", "b"]
    while counter < 50:
        if ar[randint(0, len(ar) - 1)] == "w":
            ar.append("w")
            ar.append("w")
            counter += 1
        else: break
    if counter >= 50: pos += 1

print(pos / tr)