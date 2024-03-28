from random import randint

tr = 10000000
pos = 0

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)
    cPos = randint(0, 100000)
    hPos = randint(0, 100000)
    if (20000 <= cPos <= 40000 or 65000 <= cPos <= 90000) and (abs(cPos - hPos) <= 5000):
        pos += 1

print("--------------")
print(pos / tr)
