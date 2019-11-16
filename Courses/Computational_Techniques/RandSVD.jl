@everywhere using Random
@everywhere using LinearAlgebra
using Distributed
@everywhere using SharedArrays


@everywhere function RandSVD(A, r, l)
	m, n = size(A)
	Omega = randn((n, r + l))
	Q = Array(qr(A * Omega).Q)
	C = svd(transpose(Q) * A)
	U, V = Array(C.U), Array(C.Vt)

	return (Q * U) * Diagonal(Array(C.S)) * V

end


RandSVD(randn((2, 2)), 2, 2) # Compile

m = 1000
n = 800
r = 600
l = 5

N = 100

@time @sync @distributed for i in 1:N
	A = randn((m, n))
	Ar = RandSVD(A, r, l)
end


#@time U2, S2, V2 = svd(A)

#Ar2 = U2[:,1:r] * Diagonal(S2[1:r]) * transpose(V2)[1:r,:]



#display("text/plain", Ar - A)
#println()

#println(opnorm(A - Ar) / opnorm(A - Ar2))
