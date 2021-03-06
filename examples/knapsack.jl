#  Copyright 2017, Iain Dunning, Joey Huchette, Miles Lubin, and contributors
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
#############################################################################
# JuMP
# An algebraic modeling langauge for Julia
# See http://github.com/JuliaOpt/JuMP.jl
#############################################################################
# knapsack.jl
#
# Solves a simple knapsack problem:
# max sum(p_j x_j)
#  st sum(w_j x_j) <= C
#     x binary
#############################################################################

using JuMP, GLPK, LinearAlgebra

# Maximization problem
m = Model(with_optimizer(GLPK.Optimizer))

@variable(m, x[1:5], Bin)

profit = [ 5, 3, 2, 7, 4 ]
weight = [ 2, 8, 4, 2, 5 ]
capacity = 10

# Objective: maximize profit
@objective(m, Max, dot(profit, x))

# Constraint: can carry all
@constraint(m, dot(weight, x) <= capacity)

# Solve problem using MIP solver
JuMP.optimize!(m)

println("Objective is: ", JuMP.objective_value(m))
println("Solution is:")
for i = 1:5
    print("x[$i] = ", JuMP.result_value(x[i]))
    println(", p[$i]/w[$i] = ", profit[i]/weight[i])
end
