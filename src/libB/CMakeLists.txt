cmake_minimum_required(VERSION 3.11)
project(libB LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)

add_library(libB SHARED)
set_target_properties(libB PROPERTIES PREFIX "")

target_sources(libB
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/B.cpp
)

target_include_directories(libB
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE 
        src
)

install(TARGETS libB EXPORT libBConfig
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include )
install(EXPORT libBConfig NAMESPACE libB:: DESTINATION lib/cmake/libB)

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
