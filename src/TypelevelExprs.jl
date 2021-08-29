module TypelevelExprs

using GeneralizedGenerated
using MacroTools: @q

export TypelevelExpr
export tle

struct TypelevelExpr{E}
    TypelevelExpr(expr::Expr) = new{to_type(expr)}()
end

TypelevelExpr(x) = TypelevelExpr(@q begin $x end)

function Base.show(io::IO, ex::TypelevelExpr) 
    print(io, "TypelevelExpr(")
    Base.show(io, Expr(ex))
    print(io, ")")
end


tle(x) = TypelevelExpr(x)

Base.convert(::Type{Expr}, ::TypelevelExpr{E}) where {E} = from_type(E) 

Base.Expr(::TypelevelExpr{E}) where {E} = from_type(E)

Base.Expr(::Type{TypelevelExpr{E}}) where {E} = from_type(E)

include("with.jl")

end
