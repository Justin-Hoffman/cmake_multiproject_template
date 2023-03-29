cmake_minimum_required(VERSION 3.11)
project(libA LANGUAGES C CXX)

add_library(libA SHARED)
set_target_properties(libA PROPERTIES PREFIX "")

set(CMAKE_CXX_STANDARD 20)

target_sources(libA
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/A.cpp
)

target_include_directories(libA
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE 
        src
)

install(TARGETS libA EXPORT libAConfig
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include )
install(EXPORT libAConfig NAMESPACE libA:: DESTINATION lib/cmake/libA)

include(../../cmake/common.cmake)

configure_cpack_package(
    NAME "libA"
    DESCRIPTION "libA - An Example"
    DEBIAN_ARCHITECTURE "amd64"
    DEBIAN_REQUIRES "libstdc++6 (>= 4.9), libc6 (>= 2.17)"
    RPM_ARCHITECTURE "x86_64"
    RPM_DEPENDS "glibc >= 2.3.1, libgcc >= 3.4.2"
    GENERATOR "" "RPM;TGZ" ""
)

include(CPack)

message(${CPACK_GENERATOR})

include (CTest)
enable_testing()
add_subdirectory(test)
