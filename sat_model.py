import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


x_ang_vel = 0.2
x_seconds_per_rot = 1./x_ang_vel

x = 50
A = 1.0
mu = x / 2
sigma = x / 6

N = 500  # Total timesteps
total_periods = N / x

periodic_ones = np.zeros(int(total_periods))
for i in range(0, int(total_periods)):
    if i % int(x_seconds_per_rot) == 0:
        periodic_ones[i] = 1
t2 = np.repeat(periodic_ones, x)[:N]
t = np.arange(N)


phase = t % x

signal = A * np.exp(-(phase - mu)**2 / (2 * sigma**2)) * t2

# Plot
plt.plot(t, signal)
plt.xlabel("Timestep")
plt.ylabel("Value")
plt.title("Pulse over time simulating photoresistor")
plt.show()




