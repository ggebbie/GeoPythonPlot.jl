using GGplot
using PythonCall
using PythonPlot
using Test

pyversion = pyconvert(String, pyimport("sys").version)
@info("PythonPlot is using Matplotlib $(PythonPlot.version) with Python $pyversion")

@testset "GGplot.jl" begin

    # Write your tests here.

    # will this plot run?
    latbox = [50,60]; lonbox = [30,40]
    plotextent(latbox,lonbox)

end
