function gtap9(data)

    @extract_to_local_scope(data[:sets], begin
        g => G
        r => R
        i => I
        i => J
        f => F
        sf => SF
        mf => MF
        rnum => RNUM
    end)

    @extract_to_local_scope(data[:param], begin
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
        vtw
        vtwr
        vxmd
    end)



    gtap = MPSGEModel()

    @parameters(gtap, begin
        rtfd[i=I,g=G,r=R], rtfd0[i,g,r], (description = "Firms' domestic tax rates")
        rtfi[i=I,g=G,r=R], rtfi0[i,g,r]
        rtf[f=F,g=G,r=R], rtf0[f,g,r]
        rto[g=G,r=R], rto0[g,r]
        rtxs[i=I, rr=R, r=R], rtxs0[i,rr,r]
        rtms[i=I, rr=R, r=R], rtms0[i,rr,r]
    end)

    @sectors(gtap, begin
        Y[g=G,r=R], (description = "Supply")
        M[i=I, r=R], (description = "Imported inputs")
        FT[f=F, r=R], (description = "Specific factor tranformation")
        YT[j=J], (description = "Transportation Services")
    end)

    @commodities(gtap, begin
        P[g=G,r=R]		, (description =  "Domestic output price")
        PM[i=I,r=R]		, (description =  "Import price")
        PT[j=J]	        , (description =  "Transportation services")
        PF[f=F,r=R]		, (description =  "Primary factors rent")
        PS[f=F,g=G,r=R]
    end)

    @consumer(gtap, RA[r=R], description = "Representative agent")



    for g∈G,r∈R
        @production(gtap, Y[g,r], [t=0,s=0, m=>s=esub[g], va=>s=esubva[g], nest[i=I]=>m=esubdm[i]], begin
            @output(P[g,r],         vom[g,r]   , t,       taxes = [Tax(RA[r], rto[g,r])])
            @input(P[i=I,r],        vdfm[i,g,r], nest[i], taxes = [Tax(RA[r], rtfd[i,g,r])],    reference_price = (1+rtfd0[i,g,r]))
            @input(PM[i=I,r],       vifm[i,g,r], nest[i], taxes = [Tax(RA[r], rtfi[i,g,r])],    reference_price = (1+rtfi0[i,g,r]))
            @input(PS[sf=SF, g, r], vfm[sf,g,r], va,      taxes = [Tax(RA[r], rtf[sf,g,r])],    reference_price = (1+rtf0[sf,g,r]))
            @input(PF[mf=MF, r],    vfm[mf,g,r], va,      taxes = [Tax(RA[r], rtf[mf,g,r])],    reference_price = (1+rtf0[mf,g,r]))
        end)
    end


    for i∈I, r∈R
        @production(gtap, M[i,r], [t=0, s=2*esubdm[i], nest[rr=R]=>s=0], begin
            @output(PM[i,r],   vim[i,r], t)
            @input(P[i, rr=R], vxmd[i,rr,r],   nest[rr], taxes = [Tax(RA[rr], -rtxs[i,rr,r]), Tax(RA[r], rtms[i,rr,r]*(1-rtxs[i,rr,r]))], reference_price = pvxmd[i,rr,r])
            [@input(PT[j=J],   vtwr[j,i,rr,r], nest[rr], taxes = [Tax(RA[r],   rtms[i,rr,r])],                                            reference_price = pvtwr[i,rr,r]) for rr∈R]...
        end)
    end

    for j∈J
        @production(gtap, YT[j], [t=0, s=1], begin
            @output(PT[j],   vtw[j],   t)
            @input(P[j,r=R], vst[j,r], s)
        end)
    end

    for sf∈SF,r∈R
        @production(gtap, FT[sf,r], [t=etaf[sf], s=0], begin
            @output(PS[sf,j=J,r], vfm[sf,j,r], t)
            @input(PF[sf,r],      evom[sf,r],  s)
        end)
    end


    for r∈R
        @demand(gtap, RA[r], begin
            @final_demand(P["c", r], vom["c", r])
            [@endowment(P[i, r], -sdd[i,r]) for i∈I]...
            [@endowment(PM[i,r], -sdi[i,r]) for i∈I]...
            [@endowment(PF[f,r], evom[f,r]) for f∈F]...
            @endowment(P["g",r], -vom["g", r])
            @endowment(P["i",r], -vom["i", r])
            [@endowment(P["i", rnum], vb[r]) for rnum∈RNUM]...
        end)
    end

    return gtap


end