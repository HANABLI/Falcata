[![CI](https://github.com/HANABLI/Falcata/actions/workflows/ci.yml/badge.svg)](https://github.com/HANABLI/Falcata/actions/workflows/ci.yml)
# Falcata
Falcata is just a name I picked for this solution, which is a sort of container for some libraries that I plan to develop towards making a web server framework from scratch.

## Usage 
The way that we use this solution is to build it and run the unit tests for the various libraries. There two main ways to run tests:

1. By using [CTest](https://cmake.org/cmake/help/lastest/module/CTest.html).
2. We can run individual unit test runners directly (e.g. `build/Uri/test/Debug/UriTests.exe`).

## Libraries hosted in this solution

__Uri "Uniform Resource Identifier (URI): Generic Syntax"__  
* Implementation of [RFC 3986](http://tools.ief.org/html/rfc3986)

## Supported plaforms / recommended toolchains  

* Windows -- [Visual Studio](https://www.visualstudio.com/) (Microsoft Visual C++)
* Linux -- clang or gcc
* MacOS -- Xcode (clang)

## Building

There are two distinct steps in the build  process:

1. Generation of the build system, using CMake
2. Compiling, linking, etc., using CMake-compatible toolchain

### Prerequisites
* [CMake](https://cmake.org/) version 3.8 or newer
* C++11 toolchain compatible with CMake for the develoment platform (e.g. [Visual Studio](https://www.visualstudio.com/) on Windows)

### Build system generation

Generate the build system using [CMake](https://cmake.org/) from the solution root .  
Example:
```bash
mkdir build
cd build
cmake -G "Visual Studio 15 2017" -A "x64" ..
```

### Compilling, linking, etc ..

Either use [CMake](https://cmake.org/) or your toolchain's IDE for build.

For [CMake](https://cmake.org/) build :

```bash
cd build
cmake --build .
```
