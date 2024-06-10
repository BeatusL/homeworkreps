import numpy as np
from scipy.special import erf

def generate_random_point(rho, E1, E2, E3, mu1=0, mu2=0, mu3=0):
    x = np.random.rand(2)

    z0 = np.sqrt(-2 * np.log(x[0])) * np.cos(2 * np.pi * x[1])
    z1 = np.sqrt(-2 * np.log(x[0])) * np.sin(2 * np.pi * x[1])
    z2 = np.sqrt(-2 * np.log(np.random.rand())) * np.cos(2 * np.pi * np.random.rand())

    x_A = rho * z0 * E1 + mu1
    y_A = rho * z1 * E2 + mu2
    z_A = rho * z2 * E3 + mu3
    return np.array([x_A, y_A, z_A])

def is_inside_ellipsoid(point, k, E1, E2, E3):
    return (point[0]**2 / (k*E1)**2 + point[1]**2 / (k*E2)**2 + point[2]**2 / (k*E3)**2) <= 1

rho = 1.0
E1 = 1.0
E2 = 1.0
E3 = 1.0


k = 4.0


num_points = 100000


count_inside = 0


for _ in range(num_points):
    point = generate_random_point(rho, E1, E2, E3)
    if is_inside_ellipsoid(point, k, E1, E2, E3):
        count_inside += 1


probability = count_inside / num_points

analytical_result = erf(k) - (2 * rho * k / np.sqrt(np.pi)) * np.exp(-(rho * k)**2)

print("Экспериментальная вероятность:", probability)
print("Аналитическая вероятность:", analytical_result)
