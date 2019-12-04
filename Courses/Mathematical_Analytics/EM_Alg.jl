#using Statistcs
#using LinearAlgebra
using DelimitedFiles
using Distributions

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

function iterate(lambda, pis, tol = 10^-6, Nmax = 10^3)
    lambdaold = 10^10 .* ones(length(lambda))
    i = 0
    while sum(abs.(lambda - lambdaold)) > tol
        lambdaold = lambda
        tau = get_tau(x, lambda, pis)
        lambda = get_lambda(x, tau)
        pis = get_pi(tau)
        i += 1
        if i > Nmax
            println("problem")
            break
        end
    end
    return lambda, pis
end

#x = vec(readdlm("Sale_Data.dat", Int64))

dat_lam = [10, 40, 70]
dat_pi = [1, 1, 1]

x = get_data(dat_lam, dat_pi, 10^5)

writedlm("Poisson.dat", sort(x))

lambda0 = (maximum(x) - minimum(x)) / (length(dat_lam)) .* collect(1:length(dat_lam)) .+ minimum(dat_lam)

#lambda0 = [15, 45, 60]

pis0 = rand(length(lambda0))
pis0 /= sum(pis0)

iterate(lambda0, pis0, 1) # Compile

@time iterate(lambda0, pis0)
