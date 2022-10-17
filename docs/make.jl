using GGplot
using Documenter

DocMeta.setdocmeta!(GGplot, :DocTestSetup, :(using GGplot); recursive=true)

makedocs(;
    modules=[GGplot],
    authors="G Jake Gebbie <ggebbie@whoi.edu>",
    repo="https://github.com/ggebbie/GGplot.jl/blob/{commit}{path}#{line}",
    sitename="GGplot.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ggebbie.github.io/GGplot.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ggebbie/GGplot.jl",
    devbranch="main",
)
