using GGplot
using PythonCall
using PythonPlot
using TMI
using Test

pyversion = pyconvert(String, pyimport("sys").version)
@info("PythonPlot is using Matplotlib $(PythonPlot.version) with Python $pyversion")

# get test field
TMIversion = "modern_90x45x33_GH10_GH12"
A, Alu, γ, TMIfile, L, B = config_from_nc(TMIversion,compute_lu = false);

# get observations at surface
# set them as surface boundary condition
testfield = readfield(TMIfile,"PO₄",γ)

@testset "GGplot.jl" begin

    # Write your tests here.
    @testset "box" begin
        # will this plot run?
        #pygui(true) # to see the plot
        latbox = [50,60]; lonbox = [30,40]
        plotbox(latbox,lonbox)
    end

    @testset "planview" begin

        cntrs = 0:0.2:4
        level = 15 # what model depth level?
        depth = γ.depth[level]
        label = testfield.longname*", depth = "*string(depth)*" m"

        #GGplot.pygui(true) # to help plots appear on screen using Python GUI
        planviewplot(testfield, depth, cntrs, titlelabel=label)

    end

    @testset "section" begin
        lon_section = 330; # only works if exact
        lims = 0:0.2:4.0
        field = testfield
        sectionplot(field,lon_section,lims)
    end

end
