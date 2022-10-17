module GGplot

using PyCall
using PyPlot
using TMI

# Write your package code here.
export planview, planviewplot,
    section, sectionplot,
    plotextent, tracerinit,

#Python packages - initialize them to null globally
#const patch = PyNULL()
#const ccrs = PyNULL()

# following example at ClimatePlots.jl
const mpl = PyNULL()
const plt = PyNULL()
const cmocean = PyNULL()
const cartopy = PyNULL()

#Initialize all Python packages - install with conda through Julia
function __init__()
    #copy!(patch, pyimport_conda("matplotlib.patches", "patches"))
    #copy!(ccrs, pyimport_conda("cartopy.crs", "ccrs"))

    # following ClimatePlots.jl
    copy!(mpl, pyimport_conda("matplotlib", "matplotlib", "conda-forge"))
    #copy!(plt, pyimport_conda("matplotlib.pyplot", "matplotlib", "conda-forge"))
    #copy!(cmocean, pyimport_conda("cmocean", "cmocean", "conda-forge"))
    copy!(cartopy, pyimport_conda("cartopy", "cartopy", "conda-forge"))

    println("Python libraries installed")
 end

"""
    function plotextent
    Generate image showing user-specified ROI
# Arguments
- `latbox`: in format [lat_start, lat_stop]
- `lonbox`: in format [lon_start, lon_stop]

"""
function plotextent(latbox, lonbox)
    
#    ccrs = pyimport("cartopy.crs")
    lower_left = [minimum(lonbox), minimum(latbox)] #array of lower left of box

    #calc width and height of box
    w = maximum(lonbox) - minimum(lonbox)
    h = maximum(latbox) - minimum(latbox)

    #init GeoAxes
    fig = figure()
    ax = fig.add_subplot(projection = TMI.cartopy.crs.PlateCarree())

    #plot rectangle
    ax.add_patch(TMI.mpl.patches.Rectangle(xy=lower_left,
                                 width=w, height=h,
                                 facecolor="blue",
                                 alpha=0.2,
                                 transform=TMI.cartopy.crs.PlateCarree()))
    #define extent of figure
    pad = 10 #how many deg lat and lon to show outside of bbox
    pad_add = [-pad, pad] #add this to latbox and lonbox
    padded_lat = latbox + pad_add
    padded_lon = lonbox + pad_add
    ext = vcat(padded_lon, padded_lat) #make into one vector
    ax.set_extent(ext)

    # using cartopy 0.18 and NaturalEarth is missing
    ax.coastlines() #show coastlines

    #add gridlines
    gl = ax.gridlines(draw_labels=true, dms=true, x_inline=false, y_inline=false)
    gl.top_labels = false
    gl.right_labels = false

    ax.set_title("User-defined surface patch")
end

"""
    function sectionplot
    Plot of section (lat-depth) in ocean
# Arguments
- `field::Field`, 3d filed of values to be plotted
- `lon`: longitude of section
- `lims`: contour levels
- `titlelabel`: optional title labeln
"""
function sectionplot(field::Field{T}, lon, lims;titlelabel="section plot") where T <: Real

    Psection = section(field,lon)
    cmap_seismic = get_cmap("seismic")
    z = field.γ.depth/1000.0
    
    #calc fignum - based on current number of figures
    figure()
    contourf(field.γ.lat, z, Psection', lims, cmap=cmap_seismic)
    #fig, ax = plt.subplots()
    CS = gca().contour(field.γ.lat, z, Psection', lims,colors="k")
    gca().clabel(CS, CS.levels, inline=true, fontsize=10)
    xlabel("Latitude [°N]")
    ylabel("Depth [km]")
    gca().set_title(titlelabel)
    gca().invert_yaxis()
    colorbar(orientation="horizontal")
    
end

"""
    function planviewplot
    Plot of plan view (lon-lat) in ocean
# Arguments
- `field::Field`, 3d filed of values to be plotted
- `depth`: depth of plan view
- `lims`: contour levels
- `titlelabel`: optional title label
"""
function planviewplot(c::Field{T}, depth, lims;titlelabel="section plot") where T <: Real

    cplan = planview(c::Field{T},depth)

    cmap_seismic = get_cmap("seismic")
    
    #calc fignum - based on current number of figures
    figure()
    contourf(c.γ.lon,c.γ.lat, cplan', lims, cmap=cmap_seismic)
    #fig, ax = plt.subplots()
    CS = gca().contour(c.γ.lon,c.γ.lat, cplan', lims, cmap=cmap_seismic)
    gca().clabel(CS, CS.levels, inline=true, fontsize=10)
    ylabel("Latitude [°N]")
    xlabel("Longitude [°E]")
    gca().set_title(titlelabel)
    colorbar(orientation="vertical")
    
end

"""
    function planviewplot
    Plot of plan view (lon-lat) in ocean
# Arguments
- `field::BoundaryCondition`, 3d filed of values to be plotted
- `depth`: depth of plan view
- `lims`: contour levels
- `γ::Grid`, needed for lat, lon but not in BoundaryCondition! (could refactor)
- `titlelabel`: optional title label
"""
function planviewplot(b::BoundaryCondition{T}, lims,γ::Grid;titlelabel="surface plot") where T <: Real

    # is the boundary condition oriented correctly?
    if b.dim != 3
        error("boundary condition not horizontal")
    end
    
    cplan = b.tracer
    
    cmap_seismic = get_cmap("seismic")
    
    #calc fignum - based on current number of figures
    figure()
    contourf(γ.lon,γ.lat, cplan', lims, cmap=cmap_seismic)
    #fig, ax = plt.subplots()
    CS = gca().contour(γ.lon,γ.lat, cplan', lims, cmap=cmap_seismic)
    gca().clabel(CS, CS.levels, inline=true, fontsize=10)
    ylabel("Latitude [°N]")
    xlabel("Longitude [°E]")
    gca().set_title(titlelabel)
    colorbar(orientation="vertical")
    
end

end
