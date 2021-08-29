# TypelevelExprs

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://cscherrer.github.io/TypelevelExprs.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://cscherrer.github.io/TypelevelExprs.jl/dev)
[![Build Status](https://github.com/cscherrer/TypelevelExprs.jl/workflows/CI/badge.svg)](https://github.com/cscherrer/TypelevelExprs.jl/actions)
[![Coverage](https://codecov.io/gh/cscherrer/TypelevelExprs.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/cscherrer/TypelevelExprs.jl)

This package builds on the core functionality of [GeneralizedGenerated.jl](https://github.com/JuliaStaging/GeneralizedGenerated.jl) to make it easier to work with type-level expressions.

Julia's built-in `@generated` functions and `@gg` functions from GeneralizedGenerated.jl give a way to do computations at compile time. To use these, the user writes code that looks like a standard function, but returns an expression. The compiler then executes this at compile time, constructing code based on the types of the input arguments.

The form of this generated code can only depend on the types, not on the particular values. To work around this, GeneralizedGenerated ("GG") has convenient `to_type` and `from_type` functions. For example,

```julia
julia> to_type(:(a + b))
GeneralizedGenerated.NGG.TypeLevel{Expr, "Buf{23}()"}

julia> from_type(ans)
:(a + b)
```

To make this more convenient to use, we add a thin wrapper around this. `tle` builds a `TypelevelExpr`:

```julia
julia> tle(:(a + b))
TypelevelExpr(:(a + b))

julia> Expr(ans)
:(a + b)
```

The `Typelevel` constructor from GG is still there, but now it's in the type parameter:
```julia
julia> typeof(tle(:(a + b)))
TypelevelExpr{GeneralizedGenerated.NGG.TypeLevel{Expr, "Buf{23}()"}}
```

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
