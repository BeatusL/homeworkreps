from random import randint

tr = 50000000 # количество тестов
pos = 0 # счётчик положительных результатов

def occupied(x, y):
    if (y == 2) and (abs(x - wPos) < 2): # под ударом БК
        return True
    if (y == qPosY) and (x != qPosX): # под ударом Ф
        return True
    if (y != qPosY) and (abs(x - qPosX) < 2): # на одной диагонали с Ф
        return True
    return False

def check(x):
    for i in range (-1, 2):
        for j in range (1, 3): # клетки первой и второй диагонали
            curX = x + i # клетки слева, над, справа от ЧК
            if 0 < curX < 9:
                if not occupied(curX, j): return False
    return True


for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    fl = False
    wPos = randint(1, 8)
    bPos = randint(1, 8)
    qPosY = randint(1, 2)
    qPosX = randint(1, 8)
    while (qPosY == 1 & qPosX == bPos): # переопределяем коорд ферзя, если совпадают с ЧК
        qPosY = randint(1, 2)
        qPosX = randint(1, 8)

    if check(bPos): pos += 1


print("---------------------------")
print(pos/tr)
