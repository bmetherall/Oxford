@everywhere using Random
@everywhere using LinearAlgebra
@everywhere using Statistics
@everywhere using DelimitedFiles
using Distributed
using SharedArrays

# Generate different types of matrix
@everywhere function FullRank(m::Int64, n::Int64) # Full rank matrix
	return randn(m, n)
end

@everywhere function PartRank(m::Int64, n::Int64, r::Int64) # Rank-r matrix
	return randn(m, r) * randn(r, n) # Product of two rank-r matrices
end

@everywhere function GeoSig(m::Int64, n::Int64; base = 10, coeff = 1) # Geometrically decaying sigma
	# Create two orthogonal matrices from QR of random matrices
	Q1 = Array(qr(randn(m, n)).Q)
	Q2 = Array(qr(randn(n, n)).Q)
	S = Diagonal(coeff .* convert(Float64, base).^(-(0:n-1))) # Prescribe sigmas
	return Q1 * S * Q2
end

@everywhere function AlgSig(m::Int64, n::Int64; pow = 2, coeff = 1) # Algebraically decaying sigma
	# Create two orthogonal matrices from QR of random matrices
	Q1 = Array(qr(randn(m, n)).Q)
	Q2 = Array(qr(randn(n, n)).Q)
	S = Diagonal(coeff .* (1:n).^(-pow)) # Prescribe sigmas
	return Q1 * S * Q2
end

# Compute the two SVDs
@everywhere function RandSVD(A, r::Int64, l::Int64 = 5) # Randomized SVD
	m, n = size(A)
	Omega = randn(n, r + l)
	Q = Array(qr(A * Omega).Q)
	C = svd(transpose(Q) * A)
	U, V = Array(C.U), Array(C.Vt) # Take leading parts
	return (Q * U)[:,1:r] * Diagonal(Array(C.S[1:r])) * V[1:r,:]
end

@everywhere function TruncSVD(A, r::Int64) # Truncated SVD
	Fact = svd(A)
	return Fact.U[:,1:r] * Diagonal(Fact.S[1:r]) * Fact.Vt[1:r,:]
end

# Main function to compute errors
function Solve(m::Int64, n::Int64, N::Int64 = 25, l::Int64 = 5, rmax::Int64 = n - l; fname = "Norm.dat")
	f = open(fname, "w");
	for i in 1:rmax # Loop over ranks
		res = SharedArray{Float64, 2}((N, 3)) # Results array (shared between all workers)
		println(i)
		# Perform the decomposition N times to get average errors
		@sync @distributed for j in 1:N # Parallel for loop
			#A = FullRank(m, n)
			#A = PartRank(m, n, i)
			#A = GeoSig(m, n; coeff = 10, base = 0.9)
			A = AlgSig(m, n; coeff = 10, pow = 1.5)
			
			Arand = RandSVD(A, i, l)
			Atrunc = TruncSVD(A, i)
			
			# 2 norm, F norm, trace norm
			res[j,:] = [opnorm(A - Arand) / opnorm(A - Atrunc) norm(A - Arand) / norm(A - Atrunc) opnorm(A - Arand, 1) / opnorm(A - Atrunc, 1)]
		end
		# Compute means and standard deviations for the three norms
		avg2 = mean(res[:,1])
		sd2 = std(res[:,1])
		avgF = mean(res[:,2])
		sdF = std(res[:,2])
		avgT = mean(res[:,3])
		sdT = std(res[:,3])
		writedlm(f, [i avg2 sd2 avgF sdF avgT sdT])
	end
	close(f)
end

# Main function to compute errors for rankr
function SolveR(m::Int64, n::Int64, N::Int64 = 25, l::Int64 = 5, rmax::Int64 = n - l; fname = "RankConverge.dat")
	f = open(fname, "w");
	for i in 1:rmax # Loop over ranks
		res = SharedArray{Float64, 2}((N, 6)) # Results array (shared between all workers)
		println(i)
		# Perform the decomposition N times to get average errors
		@sync @distributed for j in 1:N # Parallel for loop
			A = PartRank(m, n, i)
			
			Arand = RandSVD(A, i, l)
			Atrunc = TruncSVD(A, i)
			
			# 2 norm, F norm, trace norm
			res[j,:] = [opnorm(A - Arand) opnorm(A - Atrunc) norm(A - Arand) norm(A - Atrunc) opnorm(A - Arand, 1) opnorm(A - Atrunc, 1)]
		end
		# Compute means and standard deviations for the three norms
		avg2 = mean(res[:,1])
		avgtrunc2 = mean(res[:,2])
		avgF = mean(res[:,3])
		avgtruncF = mean(res[:,4])
		avgT = mean(res[:,5])
		avgtruncT = mean(res[:,6])
		writedlm(f, [i avg2 avgtrunc2 avgF avgtruncF avgT avgtruncT])
	end
	close(f)
end

# Compile
RandSVD(randn(8, 5), 4, 2)
TruncSVD(randn(8, 5), 4)
Solve(2, 2, 2, 1)
SolveR(2, 2, 2, 1)

m = 500
n = 250
l = 5

N = 1000

#Solve(m, n, N, l; fname = "FullRankBig.dat")
#Solve(m, n, N, l; fname = "PartRankBig.dat")
#Solve(m, n, N, l; fname = "GeoBig.dat")
#Solve(m, n, N, l; fname = "AlgBig.dat")

SolveR(m, n, N, l; fname = "RankConverge.dat")
