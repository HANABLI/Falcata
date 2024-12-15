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
    if(MSVC)
        if (RUNTIME_STATIC_LINKAGE)
            set(gtest_force_shared_crt OFF CACHE BOOL "Use shared (DLL) run-time lib even when Google Test is built as static lib." FORCE)
        else(RUNTIME_STATIC_LINKAGE)
            set(gtest_force_shared_crt ON CACHE BOOL "Use shared (DLL) run-time lib even when Google Test is built as static lib." FORCE)
        endif(RUNTIME_STATIC_LINKAGE)
    endif(MSVC)
    # Organize applications, libraries, etc. in folders in the IDE
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # Ensure proper loading of side-loaded shared libraries
    # on all targets.
    set(CMAKE_SKIP_BUILD_RPATH FALSE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
    if(APPLE)
        set(CMAKE_INSTALL_RPATH "@loader_path")
    elseif(UNIX)
        set(CMAKE_INSTALL_RPATH "\$ORIGIN")
    endif()


    # Don't add the goofy "d" postfix for debug builds of libraries.
    set(CMAKE_DEBUG_POSTFIX "")

    # Suppress Microsoft warnings about functions being unsafe.
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_SCL_SECURE_NO_WARNINGS)

    # Google Test
    set(BUILD_GTEST ON CACHE BOOL "Builds the googletest subproject" FORCE)
    set(BUILD_GMOCK OFF CACHE BOOL "Builds the googlemock subproject" FORCE)
    add_subdirectory(googletest)
    set_target_properties(gtest gtest_main PROPERTIES FOLDER Libraries)

    # All other libraties can be pulled in whiout further configuration.
    add_subdirectory(Uri)
    add_subdirectory(Http)
    add_subdirectory(Utf8)
    add_subdirectory(Json)
    add_subdirectory(WebServer)
    add_subdirectory(MessageHeaders)
    add_subdirectory(StringUtils)
    add_subdirectory(SystemUtils)
    add_subdirectory(HttpNetworkTransport)
    add_subdirectory(WebSocket)
    add_subdirectory(Sha1)
    add_subdirectory(Base64)
endif(ParentDirectory STREQUAL "")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})