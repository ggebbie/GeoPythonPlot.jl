using GGplot
using Test

@testset "GGplot.jl" begin

    # Write your tests here.

    # will this plot run?
    latbox = [50,60]; lonbox = [30,40]
    plotextent(latbox,lonbox)

end
