
include(../../../cmake/common.cmake)

find_package(GTest REQUIRED)

package_add_test(ExampleTest 
    SOURCES 
        ${CMAKE_CURRENT_SOURCE_DIR}/src/ExampleTest.cpp
    DEPENDS
        libB
)

