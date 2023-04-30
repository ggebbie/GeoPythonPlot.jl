using Pkg
using CondaPkg #, Conda

if lowercase(get(ENV, "CI", "false")) == "true"    

    ENV["PYTHON"] = ""
    Pkg.build("PythonCall")

    CondaPkg.add("matplotlib",channel="conda-forge")
    #Conda.add("shapely",channel="conda-forge")
    CondaPkg.add("cartopy",channel="conda-forge")

end
