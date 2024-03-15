from random import randint

tr = 100000 # количество тестов
pos = 0 # счётчик положительных результатов
n = 12
k = 13

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    a = [0] * n

    for j in range(k):
        a[randint(0, n - 1)] += 1

    if not 0 in a: pos += 1

print(pos/tr)