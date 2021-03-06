#  Copyright 2017, Iain Dunning, Joey Huchette, Miles Lubin, and contributors
#  This Source Code Form is subject to the terms of the Mozilla Public
#  License, v. 2.0. If a copy of the MPL was not distributed with this
#  file, You can obtain one at http://mozilla.org/MPL/2.0/.
using JuMP, Ipopt
# rosenbrock

let

    m = Model(with_optimizer(Ipopt.Optimizer, print_level=0))

    @variable(m, x)
    @variable(m, y)

    @NLobjective(m, Min, (1-x)^2 + 100(y-x^2)^2)

    JuMP.optimize!(m)

    println("x = ", JuMP.result_value(x), " y = ", JuMP.result_value(y))

end
