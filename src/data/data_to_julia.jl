using JLD2
using CSV
using DataFrames



data_type = "data_10"


out = Dict(:sets => Dict(), :param => Dict())

sets_to_extract = [
    :g,
    :r,
    :i,
    :f,
    :sf,
    :mf,
    :rnum
]

for s in sets_to_extract
    df = CSV.read(joinpath(@__DIR__,data_type,"sets","$s.csv"), DataFrame, stringtype=String)
    out[:sets][s] = lowercase.(df[:, 1])
end

parameters = [

    :esub,
    :esubdm,
    :esubva,
    :etaf,
    :evom,
    :pvtwr,
    :pvxmd,
    :rtf0,
    :rtfd0,
    :rtfi0,
    :rtms0,
    :rtxs0,
    :rto0,
    :sdd,
    :sdi,
    :vb,
    :vdfm,
    :vfm,
    :vifm,
    :vim,
    :vom,
    :vst,
    :vtw,
    :vtwr,
    :vxmd,
    #:vtfm,
]


function dict_index(C, row)
    if length(C) > 1
        return Tuple(lowercase(row[c]) for c in C)
    else
        return lowercase(row[C[1]])
    end
end

for param in parameters
    df = CSV.read(joinpath(@__DIR__,data_type,"params","$param.csv"), DataFrame, stringtype=String)

    C = names(df)[1:end-1]
    out[:param][param] = Dict( dict_index(C, row) => row[:value] for row in eachrow(df))
   
end

jldsave(joinpath(@__DIR__, "g20_10.jld2"); data=out)