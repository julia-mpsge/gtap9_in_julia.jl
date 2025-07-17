module gtap9_in_julia


using JLD2
using MPSGE
using DataStructures
using DataFrames





include("load_data.jl")
export load_data

include("model.jl")

export gtap9

end # module gtap9_in_julia
