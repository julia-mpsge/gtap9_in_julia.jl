# GTAP 9 in Julia

This repository contains all code and data necessary to compute the GTAP9 canonical model.

## Create an Environment

I _highly_ recommend creating a new Julia environment. To create a new environment:

1. Open a Julia REPL in your desired working directory
2. Type "]" (without the quotes) to enter the package manager
3. Type "activate ." (without the quotes, but don't miss the dot).

Upon doing this you probably noticed your working directory is now to the left of your prompt instead of your Julia version. This is because you've activated an environment. 

You are going to be installing an experimental version of MPSGE.jl, it may have bugs or break all your other code. Having an environment seperates this experimental version from your other projects. 

Whenever I start a new project, the first thing I do is create an environment. It ensures my code will be reproducible if packages have breaking updates. [Here is the Julia documentation on environments](https://pkgdocs.julialang.org/v1/environments/). 

## PATH License

The PATH solver is licensed software. Fortunately, PATH has a free license for use with Julia. To obtain a license, please visit the [PATH website](https://pages.cs.wisc.edu/~ferris/path/julia/LICENSE). 

If you are unable to add environment variables to your system, you can use the `PATHSolver.jl` package to set the license in your code. [The PATHSolver.jl github has code to make this work](https://github.com/chkwon/PATHSolver.jl?tab=readme-ov-file#License). Just be sure to add `PATHSolver` to your environment.

## Using this code

To add this repository to your Julia environment run the following in the package manager:

```julia
pkg> add https://github.com/julia-mpsge/gtap9_in_julia.jl
```

Finally, here is an example running the code:

```julia
using gtap9_in_julia

using gtap9_in_julia.DataFrames
using gtap9_in_julia.MPSGE

data = load_data("g20_10")

gtap  = gtap9(data);

solve!(gtap, cumulative_iteration_limit=0)

set_value!.(gtap[:rtms], 0)

solve!(gtap)

df = generate_report(gtap)

```

