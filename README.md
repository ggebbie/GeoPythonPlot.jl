# GeoPythonPlot

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://ggebbie.github.io/GeoPythonPlot.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://ggebbie.github.io/GeoPythonPlot.jl/dev/)
[![Build Status](https://github.com/ggebbie/GeoPythonPlot.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/ggebbie/GeoPythonPlot.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/ggebbie/GeoPythonPlot.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/ggebbie/GeoPythonPlot.jl)

# Description

A matplotlib plotting library conveniently packaged as a bundle of PythonPlot and cartopy dependencies

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

This package was generated using PkgTemplates.jl. 
