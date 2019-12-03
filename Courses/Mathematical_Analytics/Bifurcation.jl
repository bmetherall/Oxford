using DelimitedFiles
using Roots
using LinearAlgebra
using Statistics

function getx(N)
    return -rand(N)
end

function gety(eps)
    return x.^3 .- lambda(x, eps) .* x
end

function getA(x, eps)
    return [2 * lambda(x, eps) x -1 .* ones(length(x)) -x.^2]
end

function getcovar(N, sig = 1)
    return sig .* I
end

function Noise(m, n, sig)
    return sig * randn(m, n)
end

function lambda(x, eps)
    return (x.^3 .+ eps[3] + eps[4] .* x.^2) ./ (x .* (1 + eps[1]^2)) .- eps[2]
end

function geteps(A, C, y, e, mu, eta)
    f(sig) = (transpose(A) * A + sig^2 * inv(C)) \ (transpose(A) * y) - eps
    #eq2 = transpose(e) * e - sig^2 * (length(y) + 1 + (ln(sig) - mu) / eta^2)

    return find_zero(f, 1)

end


N = 25

eps = [0.02; 0.01; 0.02; 0.01]

eta = pi


x = getx(N)
y = gety(eps)
A = getA(x, eps)
C = getcovar(4)

err = y - A * eps

f = open("Bif.dat", "w");

e, s = geteps(A, C, y, err, log(var(y)) / 3, 3)

writedlm(f, [x y])

close(f)
