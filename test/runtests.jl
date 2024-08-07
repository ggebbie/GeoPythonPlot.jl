using GeoPythonPlot
using Test

pyversion = GeoPythonPlot.pyconvert(String, GeoPythonPlot.pyimport("sys").version)
@info("PythonPlot is using Matplotlib $(GeoPythonPlot.PythonPlot.version) with Python $pyversion")

@testset "GeoPythonPlot.jl" begin

    # Write your tests here.
    @testset "box" begin
        GeoPythonPlot.pygui(true) # to see the plot (in Jupyter?)
        latbox = [50,60]; lonbox = [30,40]
        plotbox(latbox,lonbox) # add display() to see plot over connection
    end

    @testset "planview" begin
        Nx = 90
        Ny = 45
        testfield = randn(Nx+1,Ny+1)
        lon = range(0.0,360.0,length=Nx+1)
        lat = range(-90.0,90.0,length=Ny+1)

        cntrs = -2:0.5:2
        depth = 1000.0
        label = "test field, depth = "*string(depth)*" m"

        GeoPythonPlot.pygui(true) # to help plots appear on screen using Python GUI
        planviewplot(testfield, lon, lat, depth, cntrs, titlelabel=label)

        # next see the continents
        planviewplot(NaN.*testfield, lon, lat, depth, cntrs, titlelabel=label)
        
    end

    @testset "section" begin
        lon = 330; # only works if exact

        Ny = 50
        Nz = 10
        testfield = hcat(randn(Ny,Nz),NaN.*zeros(Ny,Nz))

        lims = -2.0:0.5:2.0
        depth = range(0.0,2000.0,length=2Nz)
        lat = range(-90,90,length=Ny)
        sectionplot(testfield,lon,lat,depth,lims)
    end

end
