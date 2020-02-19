#*******************************************************/
#* Copyright(c) 2018 by Artelys                        */
#* This source code is subject to the terms of the     */
#* MIT Expat License (see LICENSE.md)                  */
#*******************************************************/

# Adapted from qcqp1.jl

using KNITRO
using Test

# Create a new Knitro solver instance.
kc = KNITRO.KN_new()

# Illustrate how to override default options by reading from
# the knitro.opt file.
options = joinpath(dirname(@__FILE__), "knitro.opt")
KNITRO.KN_load_param_file(kc, options)

# Initialize Knitro with the problem definition.

# Add the variables and set their bounds and initial values.
# Note: unset bounds assumed to be infinite.
KNITRO.KN_add_vars(kc, 3) # Three variables in problem
KNITRO.KN_set_var_lobnds(kc, [0., 0., 0.]) # Set lower bound for each variable
KNITRO.KN_set_var_primal_init_values(kc,  [2.0, 2.0, 2.0]) # Initial starting point

# Add the constraints and set their bounds.
KNITRO.KN_add_cons(kc, 2) # Two constraints
KNITRO.KN_set_con_eqbnds(kc, 0, 56.0) # First constraint: equality of 56
KNITRO.KN_set_con_lobnds(kc, 1, 25.0) # Second constraint: lower bound of 25

# Add coefficients for linear (first) constraint.
lconIndexVars = Int32[0, 1, 2] # Identify variables
lconCoefs     = [8.0, 14.0, 7.0] # Coefficients of constraint
KNITRO.KN_add_con_linear_struct(kc, 0, lconIndexVars, lconCoefs)

# Add coefficients for quadratic (second) constraint
qconIndexVars1 = Int32[0, 1, 2]
qconIndexVars2 = Int32[0, 1, 2]
qconCoefs      = [1.0, 1.0, 1.0]
KNITRO.KN_add_con_quadratic_struct(kc, 1, qconIndexVars1, qconIndexVars2, qconCoefs) # Element-wise product for the second constraint

# Set minimize or maximize(if not set, assumed minimize)
KNITRO.KN_set_obj_goal(kc, KNITRO.KN_OBJGOAL_MINIMIZE) # Minimize objective

# Add constant value to the objective.
KNITRO.KN_add_obj_constant(kc, 1000.0) # Add constant to objective

# Set quadratic objective structure.
qobjIndexVars1 = Int32[0, 1, 2, 0, 0]
qobjIndexVars2 = Int32[0, 1, 2, 1, 2]
qobjCoefs      = [-1.0, -2.0, -1.0, -1.0, -1.0]

KNITRO.KN_add_obj_quadratic_struct(kc, qobjIndexVars1, qobjIndexVars2, qobjCoefs) # Element-wise product for the objective

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

@testset "Example QCQP1" begin
    @test nStatus == 0
    @test objSol ≈ 936.
    @test x ≈ [0., 0., 8.]
end
