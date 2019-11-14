import numpy as np

def rand_SVD(A, r, l):
	m, n = A.shape
	Omega = np.random.normal(size = (n, r + l))
	Q, R = np.linalg.qr(np.matmul(A, Omega))
	U, Sigma, V = np.linalg.svd(np.matmul(Q.T, A), full_matrices = False)
	return np.matmul(Q, U)[:, :r], Sigma[:r], V[:r]

r = 140
A = np.random.normal(size = (250, 150))

u, s, v = rand_SVD(A, r, 5)
Arand = np.matmul((u * s), v)


ur, sr, vr = np.linalg.svd(A, full_matrices = False)
Ar = np.matmul((ur[:, :r] * sr[:r]), vr[:r])

print sr[r]
print np.linalg.norm(A - Ar, ord = 2)
print np.linalg.norm(A - Arand, ord = 2)

print np.linalg.norm(A - Arand, ord = 2) / np.linalg.norm(A - Ar, ord = 2)


