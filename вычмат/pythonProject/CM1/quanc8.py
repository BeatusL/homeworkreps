import ctypes
from math import cos

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
    return 1 / (t + cos(t))



result, errest, nofun, posn, flag = quanc8_wrapper(
    ctypes.CFUNCTYPE(ctypes.c_double, ctypes.c_double)(my_func), 0.0, 3.14159265, 1e-8, 1e-8)
print(result)
