from random import randint

tr = 100000
pos = 0

for i in range(tr):
    if i / tr * 100 % 1 == 0: print(i / tr * 100)

    c = randint(0, 100)
    d = randint(0, 100)

    if 20 <= d <= 40 or 65 <= d <= 90:
        if abs(c - d) <= 10:
            pos += 1

print("--------------")
print(pos / tr)