cmake_minimum_required(VERSION 3.11)
project(libA LANGUAGES C CXX)

add_library(libA SHARED)

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
