import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import CubicSpline
import ctypes
from math import sin

# Load the shared library
lib = ctypes.CDLL('./quanc8.dll')

# Define the argument types and return type of the quanc8 function
lib.quanc8.argtypes = [ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double),
                       ctypes.c_double, ctypes.c_double, ctypes.c_double,
                       ctypes.c_double, ctypes.POINTER(ctypes.c_double),
                       ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int),
                       ctypes.POINTER(ctypes.c_double), ctypes.POINTER(ctypes.c_int)]
lib.quanc8.restype = ctypes.c_int


def quanc8_wrapper(fun, a, b, abserr, relerr):
    resultR = ctypes.c_double()
    errestR = ctypes.c_double()
    nofunR = ctypes.c_int()
    posnR = ctypes.c_double()
    flag = ctypes.c_int()

    lib.quanc8(fun, a, b, abserr, relerr, resultR, errestR, nofunR, posnR, flag)

    return resultR.value, errestR.value, nofunR.value, posnR.value, flag.value


def my_func(t):
    return abs(t) ** 0.5 * sin(t)


def my_fun(t):
    result, errest, nofun, posn, flag = quanc8_wrapper(
        ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double)(my_func), 0.0, t, 1e-6, 1e-6
    )
    return result
    #print(result, end = ", ")



def lagrange_polynomial(x, y):
    def L(k):
        return lambda x_val: np.prod([(x_val - x[j]) / (x[k] - x[j]) for j in range(len(x)) if j != k])

    return lambda x_val: np.sum(y[k] * L(k)(x_val) for k in range(len(x)))



x = np.array([i / 10 for i in range(10, 30, 2)])
y = np.array([my_fun(x) for x in x])

poly = lagrange_polynomial(x, y)
spline = CubicSpline(x, y)

#points = np.linspace(0.05, 0.95, 10)
points = np.array([i / 10 for i in range(11, 30, 2)])
# Plot data points
plt.scatter(points, [0.5] * 10, color='red', label='Data Points')

# Plot given function interpolation
plt.plot(points, [my_fun(x) for x in points], label='f(x)')

# Plot Lagrange polynomial interpolation
plt.plot(points, [poly(x) for x in points], label='Lagrange Interpolation')

# Plot cubic spline interpolation
plt.plot(points, [spline(x) for x in points], label='Cubic Spline Interpolation')

plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.title('Lagrange vs. Cubic Spline Interpolation')
plt.grid(True)
plt.figure()

# Plot data points
plt.scatter(points, [0.0] * 10, color='red', label='Data Points')

# Plot Lagrange polynomial errors
plt.plot(points, [1000*(my_fun(x) - poly(x)) for x in points], label='1000х Lagrange Errors')

# Plot cubic spline errors
plt.plot(points, [my_fun(x) - spline(x) for x in points], label='Cubic Spline Errors')

plt.xlabel('x')
plt.ylabel('y')
plt.legend()
plt.title('Lagrange vs. Cubic Spline Interpolation Errors')
plt.grid(True)
plt.show()