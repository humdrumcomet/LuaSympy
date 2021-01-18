# LuaSympy - The LuaTeX Sympy Tool
## Introduction

## Warnings
This code is experimental, and has so far only been tested on a linux system (though I suspect it
will work without too much effort on any unix based system).

## Requirements
This package requires the following LuaLaTeX packages:

`luapackageloader` - Available in standard tex distributions

`luacode` - Available in standard tex distributions

`luaHelper` - Available [here](https://github.com/humdrumcomet/luahelper), as of writing, must be manually installed

`lunatexPython` - Available [here](https://github.com/humdrumcomet/lunatexpython), as of writing, must be manually installed

`luaImport` - Available [here](https://github.com/humdrumcomet/luaimport), as of writing, must be manually installed

As well as the following Python module:

`PyLuaSympy` - Available [here](https://github.com/humdrumcomet/pyluasympy) and can be installed using pip after cloning

## Installation
To install this package manually, first make sure that you have a local texmf directory with a
subdirectory named tex. You can do this with the following command, which will create the needed 
directories in your home directory. 

`
$ mkdir -p ~/texmf/tex/
`

This gives the system tex a specific place to look for the package.

Next, using bash (or similar shell) navigate into a folder you plan on storing the lunatexPython 
package (DO NOT clone into the texmf folder. This will significantly slow down all latex compilations 
as KSPE will try to traverse the .git directory) execut the following commands:

```
$ git clone https://github.com/humdrumcomet/luasympy
$ cd luasympy
$ ln -s luaSympy ~/texmf/tex/
$ texhash
```

## Basic Usage

## To Do's
In the coming weeks (months?) proper documentation that details the usage and the possibilities of 
extending the tool will be completed and added to the project. It will also hopefully one day be
submitted to CTAN so that it can come with most standard tex distributions.
