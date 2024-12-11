class Ring:
    # Создание
    def __init__(self, coefficients):
        self.coefficients = coefficients
        self.reduce()
    # Сложение
    def __add__(self, other):
        max_len = max(len(self.coefficients), len(other.coefficients))
        padded_self = self.coefficients + [0] * (max_len - len(self.coefficients))
        padded_other = other.coefficients + [0] * (max_len - len(other.coefficients))
        result_coeffs = [a + b for a, b in zip(padded_self, padded_other)]
        return Ring(result_coeffs)
    # Умножение
    def __mul__(self, other):
        result_coeffs = [0] * (len(self.coefficients) + len(other.coefficients) - 1)
        for i, a in enumerate(self.coefficients):
            for j, b in enumerate(other.coefficients):
                result_coeffs[i + j] += a * b
        return Ring(result_coeffs)
    # Преобразование в строку
    def __str__(self):
        terms = []
        for i, coeff in enumerate(self.coefficients):
            if coeff != 0:
                if coeff == 1 and i > 0:
                    coeff_str = ""
                elif coeff == -1 and i > 0:
                    coeff_str = "-"
                else:
                    coeff_str = str(coeff)
                if i == 0:
                    terms.append(coeff_str)
                elif i == 1:
                    terms.append(f"{coeff_str}x")
                else:
                    terms.append(f"{coeff_str}x^{i}")
        if not terms:
            return "0"
        return " + ".join(terms)
    # Сравнение
    def __eq__(self, other):
        # Приводим коэффициенты к одинаковой длине
        max_len = max(len(self.coefficients), len(other.coefficients))
        padded_self = self.coefficients + [0] * (max_len - len(self.coefficients))
        padded_other = other.coefficients + [0] * (max_len - len(other.coefficients))
        return padded_self == padded_other

    # Убирает лишние нули если есть
    def reduce(self):
        while self.coefficients and self.coefficients[-1] == 0:
            self.coefficients.pop()
        return self


p1 = Ring([1, 2])  # x + 2
p2 = Ring([-1, -2])  # 3x + 1
p3 = p1 + p2
p4 = p1 * p2
print(f"p1 = {p1}")
print(f"p2 = {p2}")
print(f"p1 + p2 = {p3}")
print(f"p1 * p2 = {p4}")