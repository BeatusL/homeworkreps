import re
import matplotlib.pyplot as plt
import numpy as np

threshold = 0.05
PAHi = [1] * 7
balls = [[0] * 5 for _ in range(2)]
boxes = [[0] * 5 for _ in range(7)]
expProfiles = []

results = np.zeros((100, 7))  # Предположим максимальное количество строк в файле

def get_PAHi(boxes, balls):
    res = (boxes[0] ** balls[0]) * (boxes[1] ** balls[1]) * (boxes[2] ** balls[2]) * (boxes[3] ** balls[3]) // (sum(boxes) ** 4)
    return res

with open('task_1_ball_boxes.txt', 'r') as fid:
    i = 1
    b = 0
    for line in fid:
        line = line.strip()
        if re.match(r'(\w+(: | = )\d+(.\d+)?(, )?)+', line):
            param = re.findall(r'\d+(?:\.\d+)?', line)
            expProfiles = [[0] * int(param[1]) for _ in range(int(param[4]))]
        elif re.match(r'\w+ \d+. \w+: \d+.([\w+ :,]+)', line):
            temp = [int(x) for x in re.findall(r'\d+', line)]
            for c in range(int(param[1])):
                boxes[b][c] = temp[2 + c]
            b += 1
        elif line.startswith('#'):
            colors = re.findall(r'Red|White|Black|Green|Blue', line)
            for color in colors:
                if color == 'Red':
                    balls[0][0] += 1
                    balls[1][0] += 1
                elif color == 'White':
                    balls[0][1] += 1
                    balls[1][1] += 1
                elif color == 'Black':
                    balls[0][2] += 1
                    balls[1][2] += 1
                elif color == 'Green':
                    balls[0][3] += 1
                    balls[1][3] += 1
                elif color == 'Blue':
                    balls[0][4] += 1
                    balls[1][4] += 1

            for j in range(5):
                expProfiles[i-1][j] = balls[1][j] / (i * 5)

            for j in range(7):
                m = get_PAHi(boxes[j], balls[0]) * 9 // 10
                for k in range(7):
                    if k != j:
                        m += get_PAHi(boxes[k], balls[0]) // 70
                PAHi[j] *= m

            preval_count = 0
            sum_PAHi = sum(PAHi)
            if sum_PAHi != 0:
                preval_count = sum(1 for val in PAHi if val / sum_PAHi > threshold)

            if i > 0 and not any(val is None for val in results[i-1][:6]):
                results[i-1][6] = preval_count
            i += 1

# Plotting
def plot_histogram(data, title):
    plt.hist(data, bins=10)
    plt.title(title)
    plt.show()

def plot_results(results):
    fig, axes = plt.subplots(3, 1, figsize=(8, 12))
    axes[0].plot(results[:, :7])
    axes[0].legend(["box1", "box2", "box3", "box4", "box5", "box6", "box7"])
    axes[0].set_title('1a')

    max_indices = np.unravel_index(np.argmax(results[:, :7], axis=None), results[:, :7].shape)
    axes[1].plot(results[:, max_indices[1]])
    axes[1].set_title('1b')

    axes[2].plot(results[:i, 6])
    axes[2].set_title('1c')

    plt.tight_layout()
    plt.show()

def plot_profiles(profiles, exp_profiles):
    colors = ['Red', 'White', 'Black', 'Green', 'Blue']
    fig, axes = plt.subplots(2, 1, figsize=(8, 8))

    for idx, profile in enumerate(profiles):
        axes[0].bar(colors, profile)
        axes[0].set_title(f'Box #{idx + 1}')

    axes[1].bar(colors, exp_profiles)
    axes[1].set_title('Experimental Profiles')

    plt.tight_layout()
    plt.show()

plot_results(results)
plot_profiles(boxes, expProfiles)
plot_histogram(results[:i, 6], 'Preval Count Histogram')

