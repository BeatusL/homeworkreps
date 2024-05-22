import random
from math import sqrt
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from scipy import stats
from scipy.special import comb
from sklearn.neighbors import KernelDensity
from scipy.stats import (arcsine, triang, cauchy, invgauss, laplace, chi2, expon, norm,
                         uniform, t, lognorm, gamma, rayleigh, pareto)



def random_color():
    r = random.randint
    # exclude white
    return '#%02X%02X%02X' % (r(0, 200), r(0, 200), r(0, 200))


# 1.1
with open('Task_2a.txt') as file:
    N = int(file.readline().split('=')[1])
    values = np.fromstring(file.readline(), dtype=float, sep=' ')

parts = 10
np.random.shuffle(values)
selections = np.array_split(np.copy(values), parts)
m = 50

step_function = np.zeros(m)
values_step = (max(values) + 0.001 * max(values) - min(values)) / m
columns_values = []
for t in range(1, m + 1):
    columns_values.append(min(values) + t * values_step)
for selection in selections + [values]:
    selection.sort()

linespace = np.linspace(values[0], values[-1], 100, dtype=float)
colors = [random_color() for _ in range(parts)]


def hist_prob(sample, plot, density=True, cumulative=False, **kwargs):
    kwargs['edgecolor'] = kwargs.get('edgecolor', 'k')
    kwargs['linewidth'] = kwargs.get('linewidth', 1.2)

    plot.hist(sample, 50, density=density, cumulative=cumulative, **kwargs)


def kde(sample, x, kernel='gaussian', bandwidth=0.15) -> np.ndarray:
    kde = KernelDensity(kernel=kernel, bandwidth=bandwidth)
    kde.fit(sample[:, np.newaxis])
    log_pdf = kde.score_samples(x[:, np.newaxis])
    return np.exp(log_pdf)


def kde_prob(sample, plot, kernel='gaussian', bandwidth=0.15, **kwargs):
    kwargs['label'] = kwargs.get('label', 'kde')
    density = kde(sample, linespace, kernel, bandwidth)
    plot.plot(linespace, density, **kwargs)


# 1.2.1

fig_1_1, chart = plt.subplots(1, 1)
chart.set_title("Рис.1 Ступенчатая выборочная функция распределения")
index = 0
for value in values:
    if value > columns_values[index]:
        p = int(abs(columns_values[index] - value) / values_step) + 1
        for i in range(1, p):
            step_function[index + i] = step_function[index]
        index += p
        step_function[index] = step_function[index - 1]
    step_function[index] += 1
chart.bar(columns_values, step_function / N, values_step)

fig_1_2, chart = plt.subplots(1, 1)
cdf = np.arange(0, 1, 1 / N)
chart.set_title("Рис.2 Выборочная функция распределения")
chart.plot(values, cdf)

# 1.2.2
fig_2, chart = plt.subplots(1, 2)
chart = chart.reshape(2)

hist_prob(values, chart[0], density=False)
chart[0].set_title("Рис.3 Абс. гистограмма")

hist_prob(values, chart[1])
chart[1].set_title("Рис.4 Отн. гистограмма и KDE")
kde_prob(values, chart[1], kernel="epanechnikov", bandwidth=0.4, label="Епанечниково")
kde_prob(values, chart[1], kernel="linear", bandwidth=0.4, label="Треугольное")
kde_prob(values, chart[1], kernel="gaussian",
         bandwidth=0.4, label="Гауссово")
fig_2.legend()


def point_estimations(sample):
    data = {}
    data['mean'] = np.mean(sample)
    data['median'] = np.median(sample)
    data['middle'] = (max(sample) + min(sample)) / 2
    data['variance'] = np.var(sample, ddof=1)
    data['moment 3'] = stats.moment(sample, 3)
    data['moment 4'] = stats.moment(sample, 4)
    data['kurtosis'] = stats.kurtosis(sample)
    data['skewness'] = stats.skew(sample)
    return data


fig_3_1, chart = plt.subplots(4, 2)
fig_3_1.subplots_adjust(hspace=1, left=.07, bottom=.05, right=.85)
chart = chart.reshape(8)


def var_interval(sample, q):
    var = np.var(sample, ddof=1)
    n = len(sample)

    left = var * (n - 1) / stats.chi2.ppf((1 + q) / 2, n - 1)
    right = var * (n - 1) / stats.chi2.ppf((1 - q) / 2, n - 1)
    return np.array([left, right])


def mean_interval(sample, q):
    mean = np.mean(sample)
    std = np.std(sample, ddof=1)
    n = len(sample)

    x = std / sqrt(n) * stats.t.ppf(0.5 + q / 2, n - 1)
    return np.array([mean - x, mean + x])


for selection_index, selection in enumerate(selections):
    selection_info = point_estimations(selection)
    print(selection_info)
    for i, data in enumerate(selection_info.keys()):
        chart[i].set_title(data)
        chart[i].set_yticklabels([])

        # adds labels
        if i == 0:
            chart[i].scatter(selection_info[data], 0, color=colors[selection_index],
                             marker='+', s=35, label='Выборка {0}'.format(selection_index + 1))
        else:
            chart[i].scatter(selection_info[data], 0,
                             color=colors[selection_index], marker='+', s=35)

main_selection_info = point_estimations(values)
print(main_selection_info)
for i, data in enumerate(main_selection_info):
    # adds labels
    if i == 0:
        #data['mean'], data['variance'], data['skewness'], data['kurtosis'] = stats.laplace.stats(moments='mvsk')
        chart[i].scatter(main_selection_info[data], 0,
                         color='r', marker='.', s=100, label='Глав. выборка')
    else:
        chart[i].scatter(main_selection_info[data], 0,
                         color='r', marker='.', s=100)
fig_3_1.legend()

fig_3_2, chart = plt.subplots(11)
fig_3_3, chart1 = plt.subplots(11)
fig_3_2.subplots_adjust(hspace=1, left=.07, bottom=.05, right=.85)
fig_3_3.subplots_adjust(hspace=1, left=.07, bottom=.05, right=.85)
chart1 = chart1.reshape(11)
chart = chart.reshape(11)

q = 0.8
p = 0.95
lp = stats.laplace

for selection_index, selection in enumerate(selections):
    mean = mean_interval(selection, q)
    print("Mean L: " + str(mean[0]) + " R: " + str(mean[-1]))
    var = var_interval(selection, q)
    print("Var L: " + str(var[0]) + " R: " + str(var[-1]))
    chart[selection_index].fill_between(
        mean, 0, 1, color=colors[selection_index], alpha=0.8, label='Выборка {0}'.format(selection_index + 1))
    chart1[selection_index].fill_between(
        var, 0, 1, color=colors[selection_index], alpha=0.8, label='Выборка {0}'.format(selection_index + 1))

mean = mean_interval(values, q)
print("Mean L: " + str(mean[0]) + " R: " + str(mean[-1]))
var = var_interval(values, q)
print("Var L: " + str(var[0]) + " R: " + str(var[-1]))
chart[10].fill_between(mean, 0, 1, color='r', alpha=0.8, label='Глав. выборка')
chart1[10].fill_between(var, 0, 1, color='r', alpha=0.8, label='Глав. выборка')
fig_3_2.legend()
fig_3_3.legend()


# 1.4
def equivalent_k(n):
    def get_sum(k):
        return sum(comb(n, m) * p ** m * (1 - p) ** (n - m)
                   for m in range(n - k, n + 1))

    k = 0
    while get_sum(k) < 1 - q:
        k += 1

    return k


def interval_plot(plot, l_q, l_p, r_p, r_q):
    plot.scatter(l_q, 0, color='r', marker='>', label="Толерантный предел")
    plot.scatter(l_p, 0, color='k', marker='>', s=40, label="Интерквантильный промежуток")
    plot.scatter(r_p, 0, color='k', marker='<', s=40)
    plot.scatter(r_q, 0, color='r', marker='<')
    #plot.legend()


fig_4, chart = plt.subplots(1, 1)
chart.set_yticklabels([])
chart.set_title('Рис.8 Пределы интерквантильного промежутка для глав. выборки')
k = equivalent_k(N)
print(k)

if k % 2:
    k -= 1

left_q = values[k // 2]
right_q = values[N - k // 2]
left_q_zero = -values[N - k + 1]
right_q_zero = values[N - k + 1]
left_p = np.quantile(values, 0.5 - p / 2)
right_p = np.quantile(values, 0.5 + p / 2)
print(left_q, right_q)
print(left_p, right_p)
print(left_q_zero, right_q_zero)
interval_plot(chart, left_q, left_p, right_p, right_q)
fig_4_2, chart1 = plt.subplots(1)
chart1.scatter(left_q_zero, 0, color='r', marker='>')
chart1.scatter(right_q_zero, 0, color='r', marker='<')
chart1.set_title("Рис.9 Толерантные пределы симметричные отн. нуля")

fig_5, chart = plt.subplots(5, 2)
fig_5.subplots_adjust(hspace=1, wspace=0.3)
chart = chart.reshape(10)

for i, selection in enumerate(selections):
    chart[i].set_title("Выборка {0}".format(i + 1))
    chart[i].set_yticklabels([])
    mean = np.mean(selection)
    std = np.std(selection, ddof=1)
    k = 1.65
    left_p = np.quantile(selection, 0.5 - p / 2)
    right_p = np.quantile(selection, 0.5 + p / 2)
    interval_plot(chart[i], mean - k * std, left_p,
                  right_p, mean + k * std)


series = pd.Series(values)
IQR = series.quantile(0.75) - series.quantile(0.25)
print(IQR / 2)

a, b = stats.norm.fit(values)
print("n ", a, b)
a, b = stats.cauchy.fit(values)
print("c ", a, b)
a, b, c = stats.t.fit(values)
print("t ", a, b, c)

values.sort()

fig_6, chart = plt.subplots(1, 1)
chart.set_title("Рис.10 Функции плотностей нормального распределения")
hist_prob(values, chart)
x = np.linspace(values.min(), values.max(), 13000)
chart.plot(x, stats.norm.pdf(x, 1.8390, 0.4234), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.norm.pdf(x, 1.8364, 0.4206), 'y-', lw=2, alpha=0.6, label='ММП')
fig_6.legend()

fig_7, chart = plt.subplots(1, 1)
chart.set_title("Рис.11 Функции плотностей распределения Коши")
hist_prob(values, chart)
x = np.linspace(values.min(), values.max(), 13000)
chart.plot(x, stats.cauchy.pdf(x, 1.8452, 0.2848), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.cauchy.pdf(x, 1.8689, 0.2583), 'y-', lw=2, alpha=0.6, label='ММП')
fig_7.legend()

fig_8, chart = plt.subplots(1, 1)
chart.set_title("Рис.12 Функции плотностей распределения Стьюдента")
hist_prob(values, chart)
x = np.linspace(values.min(), values.max(), 13000)
chart.plot(x, stats.t.pdf(x, 601624759, 1.8390, 0.4234), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.t.pdf(x, 601624759, 1.8364, 0.4206), 'y-', lw=2, alpha=0.6, label='ММП')
fig_8.legend()

fig_9, chart = plt.subplots(1, 1)
chart.set_title("Рис.13 Функции нормального распределения")
chart.bar(columns_values, step_function / N, values_step)
stats.ecdf(values).cdf.plot()
chart.plot(x, stats.norm.cdf(x, 1.8390, 0.4234), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.norm.cdf(x, 1.8364, 0.4206), 'y-', lw=2, alpha=0.6, label='ММП')
fig_9.legend()

fig_10, chart = plt.subplots(1, 1)
chart.set_title("Рис.14 Функции распределения Коши")
chart.bar(columns_values, step_function / N, values_step)
chart.plot(x, stats.cauchy.cdf(x, 1.8452, 0.2848), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.cauchy.cdf(x, 1.8689, 0.2583), 'y-', lw=2, alpha=0.6, label='ММП')
fig_10.legend()

fig_11, chart = plt.subplots(1, 1)
chart.set_title("Рис.15 Функции распределения Стьюдента")
chart.bar(columns_values, step_function / N, values_step)
chart.plot(x, stats.t.cdf(x, 601624759, 1.8390, 0.4234), 'r-', lw=2, alpha=0.6, label='ММ')
chart.plot(x, stats.t.cdf(x, 601624759, 1.8364, 0.4206), 'y-', lw=2, alpha=0.6, label='ММП')
fig_11.legend()

# Нормальное распределение
ks_stat, ks_p_value = stats.kstest(values, 'norm', args=(1.8390, 0.4234))
print('Колмогоров-Смирнов n ММ', ks_stat, ks_p_value)
ks_stat, ks_p_value = stats.kstest(values, 'norm', args=(1.8364, 0.4206))
print('Колмогоров-Смирнов n ММП', ks_stat, ks_p_value)

# Распределение Коши
ks_stat_cauchy, ks_p_value_cauchy = stats.kstest(values, 'cauchy', args=(1.8452, 0.2848))
print('Колмогоров-Смирнов c ММ', ks_stat_cauchy, ks_p_value_cauchy)
ks_stat_cauchy, ks_p_value_cauchy = stats.kstest(values, 'cauchy', args=(1.8689, 0.2583))
print('Колмогоров-Смирнов c ММП', ks_stat_cauchy, ks_p_value_cauchy)

# t-распределение
ks_stat_t, ks_p_value_t = stats.kstest(values, 't', args=(601624759, 1.8390, 0.4234))
print('Колмогоров-Смирнов t ММ', ks_stat_t, ks_p_value_t)
ks_stat_t, ks_p_value_t = stats.kstest(values, 't', args=(601624759, 1.8364, 0.4206))
print('Колмогоров-Смирнов t ММП', ks_stat_t, ks_p_value_t)


def chi_square_test(data, distribution, params, bins=114):
    observed_freq, bin_edges = np.histogram(data, bins=bins, density=False)
    cdf = distribution.cdf(bin_edges, *params)
    expected_freq = len(data) * np.diff(cdf)

    # Ensure the sums are the same
    scale_factor = observed_freq.sum() / expected_freq.sum()
    expected_freq *= scale_factor

    chi_stat, chi_p_value = stats.chisquare(observed_freq, expected_freq)
    return chi_stat, chi_p_value


# Нормальное распределение
ks_stat, ks_p_value = chi_square_test(values, stats.norm, (1.8390, 0.4234))
print('Хи-квадрат n ММ', ks_stat, ks_p_value)
ks_stat, ks_p_value = chi_square_test(values, stats.norm, (1.8364, 0.4206))
print('Хи-квадрат n ММП', ks_stat, ks_p_value)

# Распределение Коши
ks_stat_cauchy, ks_p_value_cauchy = chi_square_test(values, stats.cauchy, (1.8452, 0.2848))
print('Хи-квадрат c ММ', ks_stat_cauchy, ks_p_value_cauchy)
ks_stat_cauchy, ks_p_value_cauchy = chi_square_test(values, stats.cauchy, (1.8689, 0.2583))
print('Хи-квадрат c ММП', ks_stat_cauchy, ks_p_value_cauchy)

# t-распределение
ks_stat_t, ks_p_value_t = chi_square_test(values, stats.t, (601624759, 1.8390, 0.4234))
print('Хи-квадрат t ММ', ks_stat_t, ks_p_value_t)
ks_stat_t, ks_p_value_t = chi_square_test(values, stats.t, (601624759, 1.8364, 0.4206))
print('Хи-квадрат t ММП', ks_stat_t, ks_p_value_t)


# Нормальное распределение
cvm_stat = stats.cramervonmises(values, 'norm', args=(1.8390, 0.4234))
print('Мизес n ММ:', cvm_stat)
cvm_stat = stats.cramervonmises(values, 'norm', args=(1.8363647545384614, 0.42058517731132417))
print('Мизес n ММП:', cvm_stat)

# Распределение Коши
cvm_stat_cauchy = stats.cramervonmises(values, 'cauchy', args=(1.8452, 0.2848))
print('Мизес c ММ:', cvm_stat_cauchy)
cvm_stat_cauchy = stats.cramervonmises(values, 'cauchy', args=(1.8689, 0.2583))
print('Мизес c ММП:', cvm_stat_cauchy)

# t-распределение
cvm_stat_t = stats.cramervonmises(values, 't', args=(601624759, 1.8390, 0.4234))
print('Мизес t ММ:', cvm_stat_t)
cvm_stat_t = stats.cramervonmises(values, 't', args=(6.01624760e+08, 1.83636478e+00, 4.20585177e-01))
print('Мизес t ММП:', cvm_stat_t)

# Уровень значимости
alpha = 0.0001
df = 114

# Критическое значение
ks_critical_value = stats.kstwo.ppf(1 - alpha / 2, 13000)
print('Критическое значение Колмогорова-Смирнова:', ks_critical_value)


# Критическое значение
chi_critical_value = stats.chi2.ppf(1 - alpha, df)
print('Критическое значение хи-квадрат:', chi_critical_value)

print('Критическое значение Cramér-von Mises:', 0.4614)


a, b, c = stats.gamma.fit(values)
print("g ", a, b, c)


fig_11, chart = plt.subplots(1, 1)
chart.set_title("Рис. 16 Функция гамма распределения")
chart.bar(columns_values, step_function / N, values_step)
chart.plot(x, stats.gamma.cdf(x, 359.2836728552438, -6.204869331992612, 0.0223779807198273), 'r-', lw=2, alpha=0.6)

fig_12, chart = plt.subplots(1, 1)
chart.set_title("Рис. 17 Функция плотности гамма распределения")
hist_prob(values, chart)
x = np.linspace(values.min(), values.max(), 13000)
chart.plot(x, stats.gamma.pdf(x, 359.2836728552438, -6.204869331992612, 0.0223779807198273), 'r-', lw=2, alpha=0.6)


ks_stat_t, ks_p_value_t = stats.kstest(values, 'gamma', args=(359.2836728552438, -6.204869331992612, 0.0223779807198273))
print('Колмогоров-Смирнов г', ks_stat_t, ks_p_value_t)
cvm_stat_gamma = stats.cramervonmises(values, 'gamma', args=(359.2836728552438, -6.204869331992612, 0.0223779807198273))
print('Мизес г :', cvm_stat_gamma)
ks_stat_t, ks_p_value_t = chi_square_test(values, stats.gamma, (359.2836728552438, -6.204869331992612, 0.0223779807198273))
print('Хи-квадрат г', ks_stat_t, ks_p_value_t)




# Генерируем случайные данные для примера (можно заменить на свои данные)
data = values

# Функция для вычисления критерия Омега-квадрат
def omega_squared(data, dist, params):
    # Получаем эмпирическую функцию распределения данных
    ecdf = np.arange(1, len(data) + 1) / len(data)
    # Сортируем данные
    sorted_data = np.sort(data)
    # Получаем теоретическую функцию распределения
    cdf = dist.cdf(sorted_data, *params)
    # Вычисляем Омега-квадрат
    omega2 = np.sum((cdf - ecdf)**2) + 1 / (12 * len(data))
    return omega2

# Определяем распределения, которые хотим проверить
distributions = {
    'arcsine': arcsine,
    'triang': triang,
    'cauchy': cauchy,
    'invgauss': invgauss,
    'laplace': laplace,
    'chi2': chi2,
    'expon': expon,
    'norm': norm,
    'uniform': uniform,
    't': t,
    'lognorm': lognorm,
    'gamma': gamma,
    'rayleigh': rayleigh,
    'pareto': pareto
}

# Выбираем наилучшее распределение и его параметры
best_distribution = None
best_params = None
best_omega2 = np.inf

for name, dist in distributions.items():
    try:
        # Оцениваем параметры распределения
        params = dist.fit(data)
        # Вычисляем критерий Омега-квадрат
        omega2 = omega_squared(data, dist, params)
        if omega2 < best_omega2:
            best_distribution = dist
            best_params = params
            best_omega2 = omega2
    except Exception as e:
        print(f"Ошибка при обработке распределения {name}: {e}")

# Выводим результаты
if best_distribution:
    print("Ближайшее распределение:", best_distribution.name)
    print("Параметры:", best_params)
else:
    print("Не удалось определить наилучшее распределение")


plt.show()
