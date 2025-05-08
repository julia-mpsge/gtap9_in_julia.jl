using gtap9_in_julia

using gtap9_in_julia.DataFrames
using gtap9_in_julia.MPSGE

data = load_data("g20_10")

gtap  = gtap9(data);

# View available Parameters
MPSGE.raw_parameters(gtap)

solve!(gtap, cumulative_iteration_limit=0)


set_value!.(gtap[:rtms], 0);

solve!(gtap)


df = generate_report(gtap)


