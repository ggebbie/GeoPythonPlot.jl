module GeoPythonPlot

using PythonCall
using PythonPlot

export planview, planviewplot,
    section, sectionplot,
    plotbox, tracerinit

#Python packages - initialize them to null globally
const patch = pyimport("matplotlib.patches") #PyNULL()

# following example at ClimatePlots.jl
const pyplot = pyimport("matplotlib.pyplot") #PyNULL()
const cmocean = pyimport("cmocean") #PyNULL()
const cartopy = pyimport("cartopy") #PyNULL()
const ccrs = pyimport("cartopy.crs") #PyNULL()
const mpl = pyimport("matplotlib") #PyNULL()

#Initialize all Python packages - install with conda through Julia
 function __init__()

     PythonCall.pycopy!(mpl,pyimport("matplotlib"))
     PythonCall.pycopy!(cartopy,pyimport("cartopy"))
     PythonCall.pycopy!(patch,pyimport("matplotlib.patches"))
     PythonCall.pycopy!(ccrs,pyimport("cartopy.crs"))

     # following ClimatePlots.jl
     PythonCall.pycopy!(pyplot,pyimport("matplotlib.pyplot"))
     PythonCall.pycopy!(cmocean,pyimport("cmocean"))
     println("Python libraries installed")
 end

"""
function `plotbox`

Generate image showing user-specified ROI

# Arguments
- `latbox`: in format [lat_start, lat_stop]
- `lonbox`: in format [lon_start, lon_stop]
"""
function plotbox(latbox, lonbox)
    
#    ccrs = pyimport("cartopy.crs")
    lower_left = [minimum(lonbox), minimum(latbox)] #array of lower left of box

    #calc width and height of box
    w = maximum(lonbox) - minimum(lonbox)
    h = maximum(latbox) - minimum(latbox)

    #init GeoAxes
    fig = figure()
    ax = fig.add_subplot(projection = GeoPythonPlot.cartopy.crs.PlateCarree())

    #plot rectangle
    ax.add_patch(GeoPythonPlot.mpl.patches.Rectangle(xy=lower_left,
                                 width=w, height=h,
                                 facecolor="blue",
                                 alpha=0.2,
                                 transform=GeoPythonPlot.cartopy.crs.PlateCarree()))
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
function `sectionplot`
Plot of meridional section (lat-depth) in ocean

# Arguments
- `field::Matrix`, 2D array of values to be plotted
- `lon`: longitude of section
- `lat`: vector of latitudes
- `depth`: vector of depths
- `lims`: contour levels
# Optional Arguments
- `titlelabel`: optional title labeln
- `fname`: file name
- `units`: units of 2D array
"""
function sectionplot(Psection::Matrix, lon, lat, depth, lims;titlelabel="section plot",fname="figure.png",units=:none) 

    cmap_seismic = get_cmap("seismic")
    cmap_hot = get_cmap("inferno_r")
    z = depth/1000.0
    
    #calc fignum - based on current number of figures
    figure()
    contourf(lat, z, transpose(Psection), lims, cmap=cmap_seismic)
    #contourf(lat, z, transpose(Psection), lims, cmap=cmap_hot)
    #fig, ax = plt.subplots()
    CS = gca().contour(lat, z, transpose(Psection), lims,colors="k")
    gca().clabel(CS, CS.levels, inline=true, fontsize=8)
    xlabel("Latitude [°N]")
    ylabel("Depth [km]")
    gca().set_title(titlelabel)
    gca().invert_yaxis()
    colorbar(orientation="horizontal",label=units)
    gca().set_facecolor("black")
    savefig(fname)
end

"""
function `planviewplot`

Plot of plan view (lon-lat) in ocean using cartopy and PythonPlot (matplotlib)

# Arguments
- `field::Matrix`, 2d array of values to be plotted
- `lon`: vector of longitudes
- `lat`: vector of latitudes
- `depth`: depth of plan view (scalar)
- `lims`: contour levels
# Optional Arguments
- `titlelabel`: optional title label
- `fname`: output file name
- `cenlon`: central longitude
- `units`: units of array `field`
"""
function planviewplot(cplan::Matrix{<:Real}, lon, lat, depth, lims;titlelabel="planview plot",fname="fname.png",cenlon=-160.0,units=:none) #where T <: Real

    cmap_seismic = get_cmap("seismic")
    cmap_hot = get_cmap("inferno_r")

    fig = figure(202)
    clf()
    proj0 = cartopy.crs.PlateCarree()
    proj = cartopy.crs.PlateCarree(central_longitude=cenlon)
    ax = fig.add_subplot(projection = proj)
    ax.set_global()
    #ax.coastlines()
    ax.add_feature(cartopy.feature.LAND, zorder=0, edgecolor="black", facecolor="black")
    
    xlbl = "longitude "*L"[\degree E]"
    ylbl = "latitude "*L"[\degree N]"
    ax.set_title(titlelabel)
    ax.set_xlabel(xlbl)
    ax.set_ylabel(ylbl)
    gl = ax.gridlines(draw_labels=true, dms=true, x_inline=false, y_inline=false, crs=proj0)
    gl.top_labels = false
    gl.right_labels = false

    #test = ax.contourf(lon, lat, cplan', lims, cmap=cmap_hot, transform = proj0)
    test = ax.contourf(lon, lat, cplan', lims, cmap=cmap_seismic, transform = proj0)
    colorbar(test,label=units,orientation="vertical",ticks=lims, fraction = 0.03)
    CS = ax.contour(lon, lat, cplan', lims, colors="k", transform = proj0)
    ax.clabel(CS, CS.levels, inline=true, fontsize=8)
    savefig(fname)
end

end
