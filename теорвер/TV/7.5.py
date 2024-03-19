from random import randint

tr = 100000 # количество тестов
pos = 0 # счётчик положительных результатов

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)


print("--------------")
print(pos/tr)