using GeoPythonPlot
using Documenter

DocMeta.setdocmeta!(GeoPythonPlot, :DocTestSetup, :(using GeoPythonPlot); recursive=true)

makedocs(;
    modules=[GeoPythonPlot],
    authors="G Jake Gebbie <ggebbie@whoi.edu>",
    repo="https://github.com/ggebbie/GeoPythonPlot.jl/blob/{commit}{path}#{line}",
    sitename="GeoPythonPlot.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ggebbie.github.io/GeoPythonPlot.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ggebbie/GeoPythonPlot.jl",
    devbranch="main",
)
