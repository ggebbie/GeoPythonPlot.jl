# GeoPythonPlot

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ggebbie.github.io/GeoPythonPlot.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ggebbie.github.io/GeoPythonPlot.jl/dev/)
[![Build Status](https://github.com/ggebbie/GeoPythonPlot.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ggebbie/GeoPythonPlot.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ggebbie/GeoPythonPlot.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ggebbie/GeoPythonPlot.jl)

# Description

G. Gebbie's plotting routines, not to be confused with `ggplot2`. These plotting functions mostly originate from `TMI.jl`.  

# Requirements

GeoPythonPlot.jl uses matplotlib, cmocean, and cartopy. Direct the python environment to an existing system-wide version of python with these already installed:
`ENV["PYTHON"]="python/directory/on/your/machine"`

Or use a Julia-specific python environment built from scratch following the directions from `deps/build.jl`. Or, at the Julia REPL, run:
```julia
using Pkg
using CondaPkg
Pkg.add("PythonCall")
Pkg.add("PythonPlot")
ENV["PYTHON"]="" 
import Pkg; Pkg.build("PythonCall")
Pkg.build("PythonCall")	
CondaPkg.add("matplotlib")
CondaPkg.add("cartopy")
CondaPkg.add("cmocean")
```

# How this Julia package was started

This package was generated using PkgTemplates.jl. 

Steps: 
1. Use PkgTemplates to make git repo.

Run the following Julia code

`using Revise, PkgTemplates`

`t = Template(; 
    user="ggebbie",
    dir="~/projects",
    authors="G Jake Gebbie <ggebbie@whoi.edu>",
    julia=v"1.8",
    plugins=[
        License(; name="MIT"),
        Git(; manifest=true, ssh=true),
        GitHubActions(; x86=false),
        Codecov(),
        Documenter{GitHubActions}(),
        Develop(),
    ],
             )`

`t("GeoPythonPlot.jl")`

2. Make a new empty repository on GitHub.
	
3. Then push this existing repository from the command line:\
    `git push -u origin main`

	Previously it required setting the remote and branch name via the following settings. Not anymore.
    `git remote add origin git@github.com:ggebbie/IsopycnalSurfaces.jl.git`\
   `git branch -M main`
 
  In magit, use the command `M a` to set origin, but it's not necessary anymore.
  
4. Use Documenter.jl and DocumenterTools to automatically deploy documentation following: https://m3g.github.io/JuliaNotes.jl/stable/publish_docs/ .
