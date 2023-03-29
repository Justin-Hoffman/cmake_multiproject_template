cmake_minimum_required(VERSION 3.11)
project(libB LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 20)

add_library(libB SHARED)

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
