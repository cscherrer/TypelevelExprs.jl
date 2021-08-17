using TypelevelExprs
using Documenter

DocMeta.setdocmeta!(TypelevelExprs, :DocTestSetup, :(using TypelevelExprs); recursive=true)

makedocs(;
    modules=[TypelevelExprs],
    authors="Chad Scherrer <chad.scherrer@gmail.com> and contributors",
    repo="https://github.com/cscherrer/TypelevelExprs.jl/blob/{commit}{path}#{line}",
    sitename="TypelevelExprs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://cscherrer.github.io/TypelevelExprs.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/cscherrer/TypelevelExprs.jl",
)
