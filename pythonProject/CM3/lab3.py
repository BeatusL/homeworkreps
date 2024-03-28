import rkf45
import forwardEuler
import numpy as np
import scipy.integrate as integrate
from scipy.optimize import fsolve

def preciseY(t):
    return t * t * t

integratorName = 'dopri5'
eps = 1e-5
h_print = 0.1
intervalStart = 1
intervalEnd = 2

def RKF45(f, T, X0):
    r = integrate.ode(f).set_integrator(integratorName, atol=eps).set_initial_value(X0, T[0])

    X = np.zeros((len(T), len(X0)))
    X[0] = X0

    for i in range(1, len(T)):
        X[i] = r.integrate(T[i])

        if not r.successful():
            raise RuntimeError('Integration unsuccessful')

    return X


def euler(f, T, X0):
    X = np.zeros((len(T), len(X0)))
    X[0] = X0
    for i in range(1, len(T)):
        f1 = lambda Y: f(T[i], Y)

        def equations(Y):
            return [
                X[i - 1][j] + (T[i] - T[i - 1]) * f1(Y-1)[j] - Y[j] for j in range(len(Y))
            ]

        root = fsolve(equations, [0] * len(X0), xtol=1e-14, maxfev=2 ** 30)
        for j in range(len(X[i])):
            X[i][j] = X[i - 1][j] + (T[i] - T[i - 1]) * f1(root)[j]

    return X


def f(t, X):
    dX = np.zeros(len(X))
    dX[0] = X[1]
    dX[1] = (6 * X[0]) / (t ** 2)
    return dX


for h in 0.1, 0.05, 0.025, 0.0125:
    print(f"{h = }:")
    rng = np.arange(intervalStart, intervalEnd + h - 1e-9, h)
    steps = len(rng)
    X0 = [1, 3]

    res_rk45 = [i[0] for i in RKF45(f, rng, X0)]
    res_be = [i[0] for i in euler(f, rng, X0)]
    res_precise = [preciseY(rng[i]) for i in range(steps)]

    if h == 0.1:
        print("t\t\t rk45\t\t\t\t euler\t\t\t\t precise")
        for i in range(steps):
            print(f"{rng[i]:.4f}\t {res_rk45[i]:.16f}\t {res_be[i]:.16f}\t {res_precise[i]:.6f}")
    else:
        print(f"{rng[1]:.4f}\t {res_rk45[1]:.16f}\t {res_be[1]:.16f}\t {res_precise[1]:.6f}")
        print(f"{rng[-1]:.4f}\t {res_rk45[-1]:.16f}\t {res_be[-1]:.16f}\t {res_precise[-1]:.6f}")

    rk45Error = sum([abs(res_rk45[i] - res_precise[i]) for i in range(steps)]) / steps
    eulerError = sum([abs(res_be[i] - res_precise[i]) for i in range(steps)]) / steps

    print(f"Local    {abs(res_rk45[1] - res_precise[1]):.16f}\t {abs(res_be[1] - res_precise[1]):.16f}")
    print(f"Average  {rk45Error:.16f}\t {eulerError:.16f}")
    print("\n")