using gtap9_in_julia

using gtap9_in_julia.DataFrames
using gtap9_in_julia.MPSGE

import PATHSolver
PATHSolver.c_api_License_SetString("2830898829&Courtesy&&&USR&45321&5_1_2021&1000&PATH&GEN&31_12_2025&0_0_0&6000&0_0")


data = load_data("g20_10")

gtap  = gtap9(data);

# View available Parameters
MPSGE.raw_parameters(gtap)

solve!(gtap, cumulative_iteration_limit=0)


set_value!.(gtap[:rtms], 0);

solve!(gtap)


df = generate_report(gtap)


