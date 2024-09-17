from scipy.optimize import linprog

c = [1, 0]
A = [[-3, 2]]
b = [0]

A_eq = [[1, 1]]
b_eq = [5000]
x_bounds = [(0, 5000), (0, 5000)]

result = linprog(c, A_ub=A, b_ub=b, A_eq=A_eq, b_eq=b_eq, bounds=x_bounds, method='highs')

print(result.x, result.fun)
