#using Statistcs
#using LinearAlgebra
using DelimitedFiles
using Distributions
using Random

function get_data(lambda, pis, N = 10^4)
    pis /= sum(pis)
    return collect(Iterators.flatten(map((x, y) -> rand(Poisson(x), y), lambda, round.(Int64, pis .* N))))
end

function get_tau(x, lambda, pis)
    tau = pis .* broadcast(^, lambda, transpose(x)) .* exp.(-lambda)
    return tau ./ sum(tau, dims = 1)
end

function get_lambda(x, tau)
    return tau * x ./ sum(tau, dims = 2)
end

function get_pi(tau)
    return sum(tau, dims = 2) ./ size(tau, 2)
end

function iterate(x, lambda, pis, tol = 10^-4, Nmax = 10^3; output = false)
    lambdaold = 10^10 .* ones(length(lambda))
    i = 0
    while sum(abs.(lambda - lambdaold)) > tol
        lambdaold = lambda
        tau = get_tau(x, lambda, pis)
        lambda = get_lambda(x, tau)
        pis = get_pi(tau)

        if output
            writedlm("./Animate/Fake$i.dat", sum(transpose(length(x) .* pis .* broadcast(pdf, Poisson.(lambda), transpose(0:100))), dims = 2))
        end

        i += 1
        if i > Nmax
            println("problem")
            break
        end
    end
    println(i)
    return lambda, pis
end

Random.seed!(5050)

#x = vec(readdlm("SaleData.dat", Int64))

dat_lam = [12, 20, 40, 65]
dat_pi = [1, 2, 3, 2]

x = get_data(dat_lam, dat_pi, 10^4)

writedlm("FakeData.dat", sort(x))

K = 4

#lambda0 = (maximum(x) - minimum(x)) / (length(dat_lam) + 1) .* collect(1:K) .+ minimum(dat_lam)

lambda0 = [10, 25, 50, 80]

pis0 = rand(length(lambda0))
pis0 /= sum(pis0)

iterate(x, lambda0, pis0, 10^2) # Compile

@time println(iterate(x, lambda0, pis0; output = true))
