# CMakeList for HttpNetworkTransport module
#
# © 2024 by Hatem Nabli

cmake_minimum_required(VERSION 3.8)

set(this HttpNetworkTransport)

set(Headers 
    include/HttpNetworkTransport/HttpServerNetworkTransport.hpp
    include/HttpNetworkTransport/HttpClientNetworkTransport.hpp
)

set(Sources
    src/HttpServerNetworkTransport.cpp
    src/HttpClientNetworkTransport.cpp
)

add_library(${this} STATIC ${Sources} ${Headers})
set_target_properties(${this} PROPERTIES
    FOLDER Libraries
)

target_include_directories(${this} PUBLIC include)

add_subdirectory(test)