from random import randint

tr = 1000000 # количество тестов
pos = 0 # счётчик положительных результатов

def occupied(x, y):
    if y == 2 & (abs(x - wPos) < 2): # под ударом БК
        return True
    if y == qPosY & (abs(x - qPosX) > 1): # под ударом Ф, но его нельзя срубить
        return True
    if y != qPosY & (abs(x - qPosX) == 1): # на одной диагонали с Ф
        return True
    return False

def check(x):
    for i in range (-1, 1):
        for j in range (1, 3):
            curX = x + i
            if 0 <= curX < 9 and (curX != x or j != 1):
                if not occupied(curX, j): return False
    return True

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    fl = False
    wPos = randint(1, 8)
    bPos = randint(1, 8)
    qPosY = randint(1, 2)
    qPosX = randint(1, 8)
    while (qPosY == 1 & qPosX == bPos):
        qPosY = randint(1, 2)
        qPosX = randint(1, 8)

    if not check(bPos): pos += 1



print("---------------------------")
print(pos/tr)

