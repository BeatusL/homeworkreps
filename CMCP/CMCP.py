import matplotlib.pyplot as plt
from scipy import integrate


R = 40
R1 = 40
R2 = 20
R3 = 40
L = 0.04
E1 = 6
E2 = 1
C = 1e-6

tList = [i / 1000 for i in range(0, 16)]

def f(t, x):           #0 - i1, 1 - i3, 2 - uc
    return [(E1 - E2 - x[2] + x[1] * R2 - x[0] * (R1 + R2)) / L,
    (E2 + x[2] + x[0] * R2 - x[1] * (R2 + R3)) / L,
    (x[0] - x[1]) / C]


def solve():
    global C
    pairs = []

    r = integrate.ode(f).set_integrator('dopri5', nsteps=10000, atol=1e-9)
    x = [[0.1, 0, 1]]
    r.set_initial_value(x[0], tList[0])

    for i in range(1, len(tList)):
        res = r.integrate(tList[i])
        x += [res]

    for i in range(0, len(tList)):
        print(x[i][0])

    x_values = tList
    y_values = [r[0] for r in x]
    plt.plot(x_values, y_values, linestyle='-')
    plt.xlabel('t')
    plt.ylabel('i1')
    plt.grid(True)
    #plt.show()

    x_values = tList
    y_values = [r[1] for r in x]
    plt.plot(x_values, y_values, linestyle='-')
    plt.xlabel('t')
    plt.ylabel('i3')
    plt.grid(True)
    #plt.show()

    x_values = tList
    y_values = [r[2] for r in x]
    plt.plot(x_values, y_values, linestyle='-')
    plt.xlabel('t')
    plt.ylabel('Uc')
    plt.grid(True)
   #plt.show()

solve()