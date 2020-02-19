#*******************************************************/
#* Copyright(c) 2018 by Artelys                        */
#* This source code is subject to the terms of the     */
#* MIT Expat License (see LICENSE.md)                  */
#*******************************************************/

# Adapted from qcqp1.jl

using KNITRO
using Test
using DelimitedFiles

n = 6
gamma = 0.8

m = 1.0
g = 1.0
L = 10.0

# Create a new Knitro solver instance.
kc = KNITRO.KN_new()

# Illustrate how to override default options by reading from
# the knitro.opt file.
options = joinpath(dirname(@__FILE__), "knitro.opt")
KNITRO.KN_load_param_file(kc, options)

# Initialize Knitro with the problem definition.

# Add the variables and set their bounds and initial values.
# Note: unset bounds assumed to be infinite.
KNITRO.KN_add_vars(kc, 2n) # Number of variables in problem
KNITRO.KN_set_var_primal_init_values(kc,  ones(2n)) # Initial starting point

# Add the constraints and set their bounds.
KNITRO.KN_add_cons(kc, n + 3) # Number of constraints
# Boundary constraints
KNITRO.KN_set_con_eqbnds(kc, 0, 0.0)
KNITRO.KN_set_con_eqbnds(kc, 1, 0.0)
KNITRO.KN_set_con_eqbnds(kc, 2, gamma * (n - 1) * L)
KNITRO.KN_set_con_eqbnds(kc, 3, 0.0)
# Middle constraints
for i in 4:(n+2)
	KNITRO.KN_set_con_eqbnds(kc, i, L^2)
end

# Add coefficients for boundary constraints
KNITRO.KN_add_con_linear_struct(kc, 0, Int32[0], [1.0])
KNITRO.KN_add_con_linear_struct(kc, 1, Int32[n], [1.0])
KNITRO.KN_add_con_linear_struct(kc, 2, Int32[n-1], [1.0])
KNITRO.KN_add_con_linear_struct(kc, 3, Int32[2n-1], [1.0])

# Add coefficients for middle constraints
for i in 0:(n-2)
	qconIndexVars1 = Int32[i, i, i+1, n+i, n+i, n+i+1]
	qconIndexVars2 = Int32[i, i+1, i+1, n+i, n+i+1, n+i+1]
	qconCoefs      = [1.0, -2.0, 1.0, 1.0, -2.0, 1.0]
	KNITRO.KN_add_con_quadratic_struct(kc, 4+i, qconIndexVars1, qconIndexVars2, qconCoefs)
end

# Set minimize or maximize(if not set, assumed minimize)
KNITRO.KN_set_obj_goal(kc, KNITRO.KN_OBJGOAL_MINIMIZE) # Minimize objective

# Set quadratic objective structure.
lobjIndexVars1 = convert(Array{Int32, 1}, collect(n:(2n-1)))
lobjCoefs      = ones(n)
lobjCoefs[1] = 0.5
lobjCoefs[end] = 0.5

KNITRO.KN_add_obj_linear_struct(kc, lobjIndexVars1, lobjCoefs) # Element-wise product for the objective

# Solve the problem.
#
# Return status codes are defined in "knitro.h" and described
# in the Knitro manual.
nStatus = KNITRO.KN_solve(kc)

println()
println("Knitro converged with final status = ", nStatus)

# An example of obtaining solution information.
nStatus, objSol, x, lambda_ =  KNITRO.KN_get_solution(kc)
println("  optimal objective value  = ", objSol)
println("  optimal primal values x  = ", x)
println("  feasibility violation    = ", KNITRO.KN_get_abs_feas_error(kc))
println("  KKT optimality violation = ", KNITRO.KN_get_abs_opt_error(kc))

# Delete the Knitro solver instance.
KNITRO.KN_free(kc)

# @testset "Example QCQP1" begin
#     @test nStatus == 0
#     @test objSol ≈ 936.
#     @test x ≈ [0., 0., 8.]
# end

# Write solution to file for plotting
writedlm("./Sol.dat", [x[1:n] x[n+1:end]])