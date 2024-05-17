import numpy as np
import re
import matplotlib.pyplot as plt

threshold = 0.05
PAHi = np.ones(7)


def getPAHi(boxes, balls):
    log_res = np.sum(balls * np.log(boxes)) - 5 * np.log(np.sum(boxes))
    return np.exp(log_res)


with open('task_1_ball_boxes.txt', 'r') as fid:
    i = 0
    b = 0
    balls = np.zeros((2, 5))
    results = []
    expProfiles = []
    boxes = []

    for tline in fid:
        tline = tline.strip()

        # Parse parameters
        if re.match(r'(\w+(: | = )\d+(\.\d+)?(, )?)+', tline):
            fblocks = re.split(r'[A-Za-z_: ,=]+', tline)
            param = list(map(float, fblocks[1:6]))
            param = [int(p) if p.is_integer() else p for p in param]
            expProfiles = np.zeros((int(param[4]), int(param[1])))
            boxes = np.zeros((int(param[4]), int(param[1])))

        elif re.match(r'\w+ \d+\. \w+: \d+\.([\w+ :,]+)', tline):
            temp = re.split(r'[A-Za-z_: ,=.]+', tline)
            boxes[b] = list(map(float, temp[3:3 + int(param[1])]))
            b += 1

        elif tline.startswith('#'):
            balls[1, :] = 0
            fblocks = re.split(r', ', tline[1:])
            for color in fblocks:
                color = color.strip()
                if color == "Red":
                    balls[1, 0] += 1
                    balls[0, 0] += 1
                elif color == "White":
                    balls[1, 1] += 1
                    balls[0, 1] += 1
                elif color == "Black":
                    balls[1, 2] += 1
                    balls[0, 2] += 1
                elif color == "Green":
                    balls[1, 3] += 1
                    balls[0, 3] += 1
                elif color == "Blue":
                    balls[1, 4] += 1
                    balls[0, 4] += 1

            # Update experimental profiles
            expProfiles[i] = balls[1] / (i * 5 + 5)

            for j in range(7):
                m = getPAHi(boxes[j], balls[0]) * 0.9
                for k in range(7):
                    if k != j:
                        m += getPAHi(boxes[k], balls[0]) * 0.1 / 7
                PAHi[j] *= m

            prevalCount = 0
            result_row = []
            PAHi_sum = np.sum(PAHi)
            if PAHi_sum == 0:
                PAHi_sum = 1e-10  # Avoid division by zero

            for j in range(7):
                result = PAHi[j] / PAHi_sum
                result_row.append(result)
                if result > threshold:
                    prevalCount += 1
            result_row.append(prevalCount)
            results.append(result_row)
            i += 1

results = np.array(results)

# Plotting
plt.figure(figsize=(12, 8))
plt.subplot(3, 1, 1)
plt.plot(results[:, :7])
plt.legend(["box1", "box2", "box3", "box4", "box5", "box6", "box7"])
plt.title('1a')

plt.subplot(3, 1, 2)
max_box = np.argmax(results[:, :7], axis=1)
plt.plot(results[:, max_box])
plt.title('1b')

plt.subplot(3, 1, 3)
plt.plot(results[:, 7])
plt.title('1c')
plt.show()

# Plotting profiles
color_names = ['Red', 'White', 'Black', 'Green', 'Blue']
for box in range(param[0]):
    plt.figure()
    profile = boxes[box] / np.sum(boxes[box])
    plt.bar(color_names, profile)
    plt.title(f'Box № {box + 1}')
    plt.show()

# Experimental profiles plot
plt.figure()
plt.bar(color_names, expProfiles[-1])
plt.title('Experimental Profiles')
plt.show()

plt.figure()
for color in range(5):
    plt.plot(expProfiles[:, color], label=color_names[color])
plt.legend(color_names)
plt.show()
