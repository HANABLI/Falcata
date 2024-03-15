# CMakeLists.txt for Falcata 
#
#  2024 by Hatem Nabli

cmake_minimum_required(VERSION 3.8)
set(this Falcata)
project(${this} C CXX)


set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD 11)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


enable_testing()

get_directory_property(ParentDirectory PARENT_DIRECTORY)
if(ParentDirectory STREQUAL "")
    # Define option for linking  with  the runtime statically.
    if(MSVC)
        option(RUNTIME_STATIC_LINKAGE "Link with the runtime library statically" OFF)
    endif(MSVC)

    # If the runtime static linkage option is turned to ON, then replace
    # compiler flag that selects runtime library variant.
    if(MSVC AND RUNTIME_STATIC_LINKAGE)
        foreach(flag 
        CMAKE_C_FLAGS
        CMAKE_CXX_FLAGS
        CMAKE_C_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_C_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_C_FLAGS_MINSIZEREL
        CMAKE_CXX_FLAGS_MINSIZEREL
        CMAKE_C_FLAGS_RELWITHDEBINFO
        CMAKE_CXX_FLAGS_RELWITHDEBINFO)
            if(${flag} MATCHES "/MD")
                string(REGEX REPLACE "/MD" "/MT" ${flag} "${${flag}}")
            endif(${flag} MATCHES "/MD")
        endforeach(flag )
    endif(MSVC AND RUNTIME_STATIC_LINKAGE)
    
    
    # Keep Google Test's linkage of the runtime in sync with our own.
    if (RUNTIME_STATIC_LINKAGE)
        set(gtest_force_shared_crt OFF CACHE BOOL "Use shared (DLL) run-time lib even when Google Test is built as static lib." FORCE)
    else(RUNTIME_STATIC_LINKAGE)
        set(gtest_force_shared_crt ON CACHE BOOL "Use shared (DLL) run-time lib even when Google Test is built as static lib." FORCE)
    endif(RUNTIME_STATIC_LINKAGE)

    # Organize applications, libraries, etc. in folders in the IDE
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # Suppress Microsoft warnings about functions being unsafe.
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS)

    # Google Test
    set(BUILD_GTEST ON CACHE BOOL "Builds the googletest subproject" FORCE)
    set(BUILD_GMOCK OFF CACHE BOOL "Builds the googlemock subproject" FORCE)
    add_subdirectory(googletest)
    set_target_properties(gtest gtest_main PROPERTIES FOLDER Libraries)

    # All other libraties can be pulled in whiout further configuration.
    add_subdirectory(Uri)
endif(ParentDirectory STREQUAL "")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})