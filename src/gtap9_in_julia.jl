module gtap9_in_julia


using JLD2
using MPSGE
using DataStructures
using DataFrames



function load_data(data_name::String = "g20_43")
    out = JLD2.load_object(joinpath(@__DIR__, "data", "$data_name.jld2"))

    for (name, value) in out[:param]
        out[:param][name] = DefaultDict(0, value)
    end

    return out

end

export load_data


include("load_data.jl")


include("model.jl")

export gtap9

end # module gtap9_in_julia
