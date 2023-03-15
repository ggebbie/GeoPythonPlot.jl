using Pkg, Conda

println("building GGplot")
println("adding packages not in general Julia registry")
Pkg.add(url="https://github.com/ggebbie/TMI.jl")
Pkg.add(url="https://github.com/tejasvaidhyadev/GoogleDrive.jl")

if lowercase(get(ENV, "CI", "false")) == "true"    

    println("inside CI loop")
    ENV["PYTHON"] = ""
    Pkg.build("PyCall")

    Conda.add("matplotlib",channel="conda-forge")
    Conda.add("shapely",channel="conda-forge")
    Conda.add("cartopy",channel="conda-forge")

end
