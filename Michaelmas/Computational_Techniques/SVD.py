import numpy as np
import matplotlib.pyplot as plt

def Full_Rank(m, n):
	# Random mxn with full rank (P = 1)
	return np.random.normal(size = (m, n))

def Part_Rank(m, n, r):
	# Random mxn with rank r (P = 1)
	return np.matmul(np.random.normal(size = (m, r)), np.random.normal(size = (r, n)))

# Randomized Truncated SVD
def Rand_SVD(A, r, l, full = False):
	m, n = A.shape
	Omega = np.random.normal(size = (n, r + l))
	Q, R = np.linalg.qr(np.matmul(A, Omega))
	U, Sigma, V = np.linalg.svd(np.matmul(Q.T, A), full_matrices = False)
	if full:
		return np.matmul(Q, U)[:, :r], Sigma[:r], V[:r] # Return individual matrices
	else:
		return np.matmul((np.matmul(Q, U)[:, :r] * Sigma[:r]), V[:r]) # Return the approximation


# Dimensions
m = 500
n = 100
#r = 50
l = 1

err = np.zeros(n)

for r in range(n):
	# Full Rank
	A = Full_Rank(m, n)

	# Rank r
	#A = Part_Rank(m, n, r)

	Arand = Rand_SVD(A, r, l)

	ur, sr, vr = np.linalg.svd(A, full_matrices = False)
	Ar = np.matmul((ur[:, :r] * sr[:r]), vr[:r])

	err[r] = np.linalg.norm(A - Arand, ord = 2) / np.linalg.norm(A - Ar, ord = 2)

plt.plot(range(n), err)
plt.show()
