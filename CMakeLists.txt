cmake_minimum_required(VERSION 3.11)
project(ExternalProjectCollection LANGUAGES C CXX)

include(ExternalProject)
set(HOST_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/host_installed/)
message("HOST INSTALL_PREFIX_PATH: ${HOST_INSTALL_PREFIX}")

include(ExternalProject)

function(add_external_project NAME SOURCE_DIR)
    set(HOST_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/host_installed/)
    message("HOST INSTALL_PREFIX_PATH: ${HOST_INSTALL_PREFIX}")

    set(DEPENDENCIES "")
    foreach(DEP ${ARGN})
        list(APPEND DEPENDENCIES DEPENDS ${DEP})
    endforeach()

    ExternalProject_Add(
        ${NAME}
        SOURCE_DIR ${SOURCE_DIR}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX=${HOST_INSTALL_PREFIX}
            -DCMAKE_PREFIX_PATH:PATH="${HOST_INSTALL_PREFIX}"

    DEPENDS ${DEPENDENCIES}
        BUILD_ALWAYS TRUE
    )

    ExternalProject_Get_Property(${NAME} BINARY_DIR)
    ExternalProject_Add_Step(${NAME} package
        COMMAND cmake --build ${BINARY_DIR} --target package
        WORKING_DIRECTORY ${BINARY_DIR}
        ALWAYS TRUE
        EXCLUDE_FROM_MAIN TRUE
    )
    ExternalProject_Add_StepTargets(${NAME} package package)
    ExternalProject_Add_Step(${NAME} test
        COMMAND cmake --build ${BINARY_DIR} --target test
        WORKING_DIRECTORY ${BINARY_DIR}
        ALWAYS TRUE
        EXCLUDE_FROM_MAIN TRUE
    )
    ExternalProject_Add_StepTargets(${NAME} test test)
endfunction()

add_external_project(libA ${CMAKE_SOURCE_DIR}/src/libA )
add_external_project(libB ${CMAKE_SOURCE_DIR}/src/libB )
add_external_project(exe ${CMAKE_SOURCE_DIR}/src/exe DEPENDS libA libB)

