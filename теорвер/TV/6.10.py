from random import randint

tr = 10000000
pos = 0

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    cPos = randint(0, 100000)
    hPos = randint(0, 100000)
    if (20000 <= cPos <= 40000 or 65000 <= cPos <= 90000) and (abs(cPos - hPos) <= 10000):
        pos += 1

    c = randint(0, 100)
    d = randint(0, 100)

    if 20 <= d <= 40 or 65 <= d <= 90:
        if abs(c - d) <= 10:
            pos += 1

print("--------------")
print(pos / tr)