using Pkg
Pkg.activate(".")
Pkg.instantiate()

using gtap9_in_julia

using DataFrames
using MPSGE

import MPSGE.PATHSolver
PATHSolver.c_api_License_SetString("1259252040&Courtesy&&&USR&GEN2035&5_1_2026&1000&PATH&GEN&31_12_2035&0_0_0&6000&0_0")

data = load_data("g20_10")

gtap  = gtap9(data);

solve!(gtap, cumulative_iteration_limit=0)

set_value!.(gtap[:rtms], 0)

solve!(gtap)

df = generate_report(gtap)