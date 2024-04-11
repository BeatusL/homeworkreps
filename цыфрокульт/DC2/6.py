import pandas as pd

def data_shape(file_name):
    try:
        data = pd.read_csv(file_name)
        shape = data.shape
        print(shape)
        return shape
    except FileNotFoundError:
        return "Файл не найден"
    except pd.errors.EmptyDataError:
        return "Файл пустой"