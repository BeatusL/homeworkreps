import numpy as np

# Параметры задачи
sheet_width = 4  # ширина листа фанеры (в метрах)
sheet_height = 5  # высота листа фанеры (в метрах)

# Размеры деталей
size_A = (2, 2)  # размер детали A
size_B = (1, 3)  # размер детали B


# Создание пустого листа фанеры (сеточная модель)
def create_sheet(width, height):
    return np.zeros((height, width), dtype=int)


# Проверка, может ли деталь быть размещена на листе с учетом свободных мест
def can_place_piece(sheet, piece_size, top_left):
    piece_height, piece_width = piece_size
    sheet_height, sheet_width = sheet.shape
    r, c = top_left

    # Проверка, не выходит ли деталь за границы листа
    if r + piece_height > sheet_height or c + piece_width > sheet_width:
        return False

    # Проверка, что все клетки в месте размещения детали свободны
    for i in range(r, r + piece_height):
        for j in range(c, c + piece_width):
            if sheet[i, j] != 0:  # ячейка занята
                return False
    return True


# Размещение детали на листе (заполняем клетки значением)
def place_piece(sheet, piece_size, top_left, piece_id):
    piece_height, piece_width = piece_size
    r, c = top_left
    for i in range(r, r + piece_height):
        for j in range(c, c + piece_width):
            sheet[i, j] = piece_id


# Функция для попытки разместить детали A и B на одном листе
def try_to_place(sheet, num_A, num_B):
    placed_A = 0
    placed_B = 0

    # Попробуем сначала разместить детали A
    for r in range(sheet.shape[0]):
        for c in range(sheet.shape[1]):
            if placed_A < num_A and can_place_piece(sheet, size_A, (r, c)):
                place_piece(sheet, size_A, (r, c), 1)  # размещаем деталь A (1)
                placed_A += 1

    # Затем размещаем детали B
    for r in range(sheet.shape[0]):
        for c in range(sheet.shape[1]):
            if placed_B < num_B and can_place_piece(sheet, size_B, (r, c)):
                place_piece(sheet, size_B, (r, c), 2)  # размещаем деталь B (2)
                placed_B += 1

    # Если удалось разместить нужное количество деталей A и B
    return placed_A == num_A and placed_B == num_B


# Функция для поиска нескольких лучших схем раскроя
def find_best_cuts():
    best_solutions = []

    # Перебираем возможные раскрои
    for num_A in range(1, 9):  # максимум 8 деталей A
        for num_B in range(1, 9):  # максимум 8 деталей B
            # Создаем лист фанеры
            sheet = create_sheet(sheet_width, sheet_height)

            # Пробуем разместить детали на листе
            if try_to_place(sheet, num_A, num_B):
                # Считаем отходы
                used_area = num_A * (size_A[0] * size_A[1]) + num_B * (size_B[0] * size_B[1])
                waste = sheet_width * sheet_height - used_area

                # Проверяем условие, что деталей A >= деталей B
                if num_A >= num_B:
                    best_solutions.append((num_A, num_B, waste))

    # Сортируем схемы по минимальным отходам
    best_solutions.sort(key=lambda x: x[2])
    return best_solutions[:3]  # возвращаем три лучшие схемы раскроя


# Функция для чередования схем раскроя
def alternating_cut(num_sheets=5000):
    best_cuts = find_best_cuts()

    total_A = 0
    total_B = 0
    total_waste = 0

    # Чередуем схемы раскроя
    for i in range(num_sheets):
        current_cut = best_cuts[i % len(best_cuts)]  # чередуем схемы
        num_A, num_B, waste = current_cut

        total_A += num_A
        total_B += num_B
        total_waste += waste

    return total_A, total_B, total_waste


# Поиск решения с чередованием раскроев
total_A, total_B, total_waste = alternating_cut()

# Вывод результатов
print(f'Общее количество деталей A: {total_A}')
print(f'Общее количество деталей B: {total_B}')
print(f'Общая площадь отходов: {total_waste} м²')
