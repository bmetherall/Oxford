using Random
using LinearAlgebra
#using Distributed
#using SharedArray

function FullRank(m, n)
	return randn((m, n))
end

function PartRank(m, n, r)
	return randn((m, r)) * randn((r, n))
end

function GeoSig(m, n; base = 10, coeff = 1)
	Q1 = Array(qr(randn(m, n)).Q)
	Q2 = Array(qr(randn(n, n)).Q)
	S = Diagonal(coeff .* convert(Float64, base).^(-(0:n-1)))
	return Q1 * S * Q2
end

function RandSVD(A, r, l)
	m, n = size(A)
	Omega = randn((n, r + l))
	Q = Array(qr(A * Omega).Q)
	C = svd(transpose(Q) * A)
	U, V = Array(C.U), Array(C.Vt)

	return (Q * U) * Diagonal(Array(C.S)) * V
end

function Solve(m, n, N = 25, l = 5, rmax = n)
	for i in 1:rmax
		for j in 1:N
			RandSVD(FullRank(m, n), i, l)
		end
	end

end


RandSVD(randn((2, 2)), 2, 2) # Compile

m = 1000
n = 800
r = 600
l = 5

N = 1000

GeoSig(4,3)

A = GeoSig(15,11; coeff = 67)

println(svdvals(A))
println(size(A))





