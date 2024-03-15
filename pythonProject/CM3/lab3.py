import rkf45
import forwardEuler
import numpy as np
import scipy.integrate as integrate
from scipy.optimize import fsolve

integratorName = 'dopri5'
eps = 1e-5
h_print = 0.1
intervalStart = 1
intervalEnd = 2


def preciseY(t):
    return t * t * t


def rk45(f, T, X0):
    r = integrate.ode(f).set_integrator(integratorName, atol=eps).set_initial_value(X0, T[0])

    X = np.zeros((len(T), len(X0)))
    X[0] = X0

    for i in range(1, len(T)):
        X[i] = r.integrate(T[i])

        if not r.successful():
            raise RuntimeError('Integration unsuccessful')

    return X


def backward_euler(f, T, Y0):
    Y = np.zeros((len(T), len(Y0)))
    Y[0] = Y0
    for i in range(1, len(T)):
        f1 = lambda Y: f(T[i], Y)

        def equations(X):
            return [
                #Y[i - 1][j] + (T[i] - T[i - 1]) * f1(X)[j] - X[j] for j in range(len(X))
                Y[i - 1][j] + (T[i] - T[i - 1]) * f1(X-1)[j] - X[j] for j in range(len(X))
            ]

        root = fsolve(equations, [0] * len(Y0), xtol=1e-14, maxfev=2 ** 30)
        for j in range(len(Y[i])):
            Y[i][j] = Y[i - 1][j] + (T[i] - T[i - 1]) * f1(root)[j]

    return Y


def f(t, X):
    dX = np.zeros(len(X))
    dX[0] = X[1]
    dX[1] = (6 * X[0]) / (t ** 2)
    return dX


for h in 0.1, 0.05, 0.025, 0.0125:
    print(f"{h = }:")
    rng = np.arange(1, 2 + h - 1e-9, h)
    n_steps = len(rng)
    X0 = [1, 3]
    res_rk45 = [i[0] for i in rk45(f, rng, X0)]
    res_be = [i[0] for i in backward_euler(f, rng, X0)]
    res_precise = [preciseY(rng[i]) for i in range(n_steps)]
    if h == 0.1:
        print("t\t\t rk45\t\t\t backward euler\t\t precise")
        for i in range(n_steps):
            print(f"{rng[i]:.8f}\t {res_rk45[i]:.16f}\t {res_be[i]:.16f}\t {res_precise[i]:.8f}")

    rk45_avg_error = sum([abs(res_rk45[i] - res_precise[i]) for i in range(n_steps)]) / n_steps
    be_avg_error = sum([abs(res_be[i] - res_precise[i]) for i in range(n_steps)]) / n_steps

    print(f"Avg. err.:\t {rk45_avg_error:.16f}\t {be_avg_error:.16f}")