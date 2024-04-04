import random
import math
import time
from datetime import datetime

def random_char(input_str):
    if len(input_str) == 0:
        return None
    else:
        return random.choice(input_str)



def area_and_length(radius):
    if radius <= 0:
        return None

    area = round(math.pi * radius ** 2, 2)
    length = round(2 * math.pi * radius, 2)
    print("Площадь круга:", area)
    print("Длина окружности:", length)
    return area, length

def timer(seconds):
    print(f"Таймер запущен на {seconds} секунд.")
    time.sleep(seconds)
    print("Время истекло! Таймер завершен.")

def time_to_seconds(time_str):
    try:
        time_obj = datetime.strptime(time_str, '%H:%M:%S')
        total_seconds = time_obj.second + time_obj.minute * 60 + time_obj.hour * 3600
        print(total_seconds)
        return total_seconds
    except ValueError:
        return "Неверный формат времени. Используйте ЧЧ:ММ:СС."

def discriminant_root(coefficients_str):
    try:
        a, b, c = map(int, coefficients_str.split())
        discriminant = b**2 - 4*a*c
        if discriminant < 0:
            return "Дискриминант меньше нуля"
        else:
            root = discriminant**0.5
            print(root)
            return root
    except ValueError:
        return "Неверный формат коэффициентов. Используйте три целых числа через пробел."