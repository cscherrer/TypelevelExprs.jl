# TypelevelExprs

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://cscherrer.github.io/TypelevelExprs.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://cscherrer.github.io/TypelevelExprs.jl/dev)
[![Build Status](https://github.com/cscherrer/TypelevelExprs.jl/workflows/CI/badge.svg)](https://github.com/cscherrer/TypelevelExprs.jl/actions)
[![Coverage](https://codecov.io/gh/cscherrer/TypelevelExprs.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/cscherrer/TypelevelExprs.jl)



# Named tuples as contexts

We can do this with `@with`, similar to [StaticModules.jl](https://github.com/MasonProtter/StaticModules.jl) (and identical syntax):

```julia
julia> @with((x=1, y=2), x+y)
3
```

These can also be nested, with good performance:
```julia
julia> nt = (x=1, y=(a=2, b=3))
(x = 1, y = (a = 2, b = 3))

julia> @with nt begin
           x + @with y (a+b)
       end
6

julia> @btime @with $nt begin
              x + @with y (a + b)
              end
  0.010 ns (0 allocations: 0 bytes)
6
```
