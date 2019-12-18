import numpy as np
#import matplotlib.pyplot as plt

def sigma(t, alpha):
	return 3 * (t * np.sin(alpha) / 12)**(1.0 / 3) - 0.5

def h1(x, t, alpha):
	if x < -0.5:
		return 0
	elif -0.5 <= x and x < -0.5 + t * np.sin(alpha):
		return np.sqrt((x + 0.5) / (t * np.sin(alpha)))
	elif -0.5 + t * np.sin(alpha) <= x and x <= 0.5 + t * np.sin(alpha) / 3:
		return 1
	else:
		return 0

def h2(x, t, alpha):
	if x < -0.5:
		return 0
	elif -0.5 <= x and x <= sigma(t, alpha):
		return np.sqrt((x + 0.5) / (t * np.sin(alpha)))
	else:
		return 0

def h(x, t, alpha):
	if t < 3.0 / (2 * np.sin(alpha)):
		return h1(x, t, alpha)
	else:
		return h2(x, t, alpha)

#x = np.linspace(-1,2,10**3)

#y = np.zeros(10**3)

#for i in range(10**3):
#	y[i] = h(x[i],0.5,1.0)

#plt.plot(x, y)
#plt.show()

a = np.pi / 6

z = np.zeros((10**6,3))
counter = 0

#for x in np.linspace(-1,2,10**3):
#	for t in np.linspace(0,6,10**3):
#		z[counter] = [x, t, h(x, t, a)]
#		counter += 1

#np.savetxt('Char.dat', z)



z = np.zeros((10**2,2))
counter = 0

for t in np.linspace(3,6,10**2):
	z[counter] = [sigma(t, a), t]
	counter += 1

np.savetxt('Shock2.dat', z)





