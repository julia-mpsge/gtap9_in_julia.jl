using gtap9_in_julia

using DataFrames
using MPSGE

data = load_data("g20_10")

gtap  = gtap9(data);

fix(gtap[:RA]["mic"], data[:param][:vom]["c", "mic"])

solve!(gtap, cumulative_iteration_limit=0)

df = generate_report(gtap)


X = df |> 
    x -> subset(x, 
        :margin => ByRow(y -> abs(y) > .001)
    ) |>
    x -> sort(x, :margin)


aggregate_countries = ["reu","mic","chn","oex","anz","lic"]

margin_values = Dict(r => value(income_balance(gtap[:RA][r], virtual=true)) for r in aggregate_countries)

for r in aggregate_countries
    val = 2*(sum([vxmd[i, r,r] for i in I]) + sum(vtwr[j,i, r,r] for i in I, j in J))
    println("$r -> $(val +margin_values[r])")
end


r = "mic"
1 .+ [-rtxs0[i, r,r] for i in I] .+ [rtms0[i,r,r]*(1-rtxs0[i,r,r]) for i in I]
[pvxmd[i, r,r] for i in I]


P = production(gtap[:M]["oil", "mic"])




for r in R
    val = 2*(sum([vxmd[i, r,r] for i in I]) + sum(vtwr[j,i, r,r] for i in I, j in J))
    println("$r -> $(val)")
end

production(M["oil", "mic"])

# Solve as is

solve!(gtap)

df = generate_report(gtap)

df |>
    x -> subset(x,
        :value => ByRow(==(1))
    )


production(gtap[:M]["oil", "mic"])






############## Testing ####################

begin

    gtap9_in_julia.@extract_to_local_scope(data[:sets], begin
        g => G
        r => R
        i => I
        i => J
        f => F
        sf => SF
        mf => MF
        rnum => RNUM
    end)

    gtap9_in_julia.@extract_to_local_scope(data[:param], begin
        esub
        esubva
        esubdm
        etaf
        evom
        pvtwr
        pvxmd
        rtf0
        rtfd0
        rtfi0
        rto0
        rtxs0
        rtms0
        sdd
        sdi
        vb
        vdfm
        vfm
        vifm
        vim
        vom
        vst
        #vtfm # not used in the model, but present in the data file.
        vtw
        vtwr
        vxmd
    end)
end


function _total_tax_expr(consumer)

    M = MPSGE.model(consumer)
    jm = jump_model(M)
    value_function = ifelse(
        MPSGE.termination_status(jm) == MPSGE.OPTIMIZE_NOT_CALLED,
        start_value,
        x -> is_fixed(x) ? MPSGE.fix_value(x) : value(x)
    )

    return Dict(S => MPSGE.tax_revenue(S,consumer;virtual = true) for S∈MPSGE.production_sectors(M) if MPSGE.tax_revenue(S,consumer;virtual = true)!=0)

end


function _total_tax_revenue(consumer)

    M = MPSGE.model(consumer)
    jm = jump_model(M)
    value_function = ifelse(
        MPSGE.termination_status(jm) == MPSGE.OPTIMIZE_NOT_CALLED,
        start_value,
        x -> is_fixed(x) ? MPSGE.fix_value(x) : value(x)
    )

    return sum(value(value_function,MPSGE.tax_revenue(S,consumer;virtual = true)) for S∈MPSGE.production_sectors(M); init=0)

end



function _total_endowment(consumer)

    M = MPSGE.model(consumer)
    jm = jump_model(M)
    value_function = ifelse(
        MPSGE.termination_status(jm) == MPSGE.OPTIMIZE_NOT_CALLED,
        start_value,
        x -> is_fixed(x) ? MPSGE.fix_value(x) : value(x)
    )

    return sum(value(value_function,get_variable(MPSGE.endowment(consumer,C))* get_variable(C)) for C∈commodities(M); init=0)

end

function _consumer_income(consumer)
    return _total_endowment(consumer) - _total_tax_revenue(consumer)
end

c = "c"
r = "lic"

H = gtap[:RA][r]
C = gtap[:P][c,r]
_total_tax_revenue(H)
_total_endowment(H)
_consumer_income(H)

vom[c,r]


market_clearance(C)


pvxmd