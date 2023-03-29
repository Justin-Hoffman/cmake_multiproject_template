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

ExternalProject_Get_Property(libA BINARY_DIR)
ExternalProject_Add_Step(libA package
    COMMAND cmake --build ${BINARY_DIR} --target package
    WORKING_DIRECTORY ${BINARY_DIR}
    ALWAYS TRUE
    EXCLUDE_FROM_MAIN TRUE
)
ExternalProject_Add_StepTargets(libA package package)
ExternalProject_Add_Step(libA test
    COMMAND cmake --build ${BINARY_DIR} --target test
    WORKING_DIRECTORY ${BINARY_DIR}
    ALWAYS TRUE
    EXCLUDE_FROM_MAIN TRUE
)
ExternalProject_Add_StepTargets(libA test test)


ExternalProject_Add(
    libB
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/libB
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
    BUILD_ALWAYS TRUE
)
ExternalProject_Get_Property(libB BINARY_DIR)
ExternalProject_Add_Step(libB package
    COMMAND cmake --build ${BINARY_DIR} --target package
    WORKING_DIRECTORY ${BINARY_DIR}
    ALWAYS TRUE
    EXCLUDE_FROM_MAIN TRUE
)
ExternalProject_Add_StepTargets(libB package package)
ExternalProject_Add_Step(libB test
    COMMAND cmake --build ${BINARY_DIR} --target test
    WORKING_DIRECTORY ${BINARY_DIR}
    ALWAYS TRUE
    EXCLUDE_FROM_MAIN TRUE
)
ExternalProject_Add_StepTargets(libB test test)


ExternalProject_Add(
    exe
    DEPENDS libA libB
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/exe
    CMAKE_ARGS  
        -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
        -DCMAKE_PREFIX_PATH:PATH="${HOST_INSTALL_PREFIX}"
    BUILD_ALWAYS TRUE
)
