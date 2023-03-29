cmake_minimum_required(VERSION 3.11)
project(ExternalProjectCollection LANGUAGES C CXX)

include(ExternalProject)
set(HOST_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/host_installed/)
message("HOST INSTALL_PREFIX_PATH: ${HOST_INSTALL_PREFIX}")

ExternalProject_Add(
    libA
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/libA
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
    BUILD_ALWAYS TRUE
)

ExternalProject_Add(
    libB
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/libB
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
    BUILD_ALWAYS TRUE
)


ExternalProject_Add(
    exe
    DEPENDS libA libB
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/exe
    CMAKE_ARGS  
        -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
        -DCMAKE_PREFIX_PATH:PATH="${HOST_INSTALL_PREFIX}"
    BUILD_ALWAYS TRUE
)
