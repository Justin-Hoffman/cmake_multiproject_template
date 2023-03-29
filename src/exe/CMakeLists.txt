cmake_minimum_required(VERSION 3.11)
project(exe LANGUAGES C CXX)

message(${CMAKE_PREFIX_PATH})
find_package(libA REQUIRED)
find_package(libB REQUIRED)

add_executable(exe src/main.cpp)

target_sources(exe
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src/exe.cpp
)

target_include_directories(exe
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE 
        src
)

target_link_libraries(exe libA::libA libB::libB)

install(TARGETS exe EXPORT exeConfig
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include )
install(EXPORT exeConfig NAMESPACE exe:: DESTINATION lib/cmake/exe)