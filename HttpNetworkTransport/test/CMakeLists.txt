# CMakeList for HttpNetworkTransport tests module
#
# © 2024 by Hatem Nabli


cmake_minimum_required(VERSION 3.8)

set(this HttpNetworkTransportTests)

set(SOURCES
    src/HttpServerNetworkTransport.cpp
    src/HttpClientNetworkTransport.cpp
)

add_executable(${this} ${Sources})

set_target_properties(${this} PROPERTIES
    FOLDER Tests
)

target_include_directories(${this} PRIVATE ..)

target_link_libraries(${this} PUBLIC
    Http
)

add_test(
    NAME ${this}
    COMMAND ${this}
)