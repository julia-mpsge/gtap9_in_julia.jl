# GTAP 9 in Julia

This repository contains all code and data necessary to compute the GTAP9 canonical model.

## Using this Code

Download or clone the repository. The file `main.jl` will download the project dependencies and run an example simulation with a counterfactual.

There are two primary functions provided in this example, `load_data` and `gtap9`. Each of these functions is has a docstring that describes its inputs and outputs in full detail. To view the docstring for a function, simply type `?function_name` in the Julia REPL. For example, to view the docstring for `load_data`, type `?load_data`.

## PATH License

The file `main.jl` includes a PATH license string. This license is valid until December 31, 2035.

The PATH solver is licensed software. Fortunately, PATH has a free license for use with Julia. To obtain a license, please visit the [PATH website](https://pages.cs.wisc.edu/~ferris/path/julia/LICENSE). 

If you are unable to add environment variables to your system, you can use the `PATHSolver.jl` package to set the license in your code. [The PATHSolver.jl github has code to make this work](https://github.com/chkwon/PATHSolver.jl?tab=readme-ov-file#License). Just be sure to add `PATHSolver` to your environment.



