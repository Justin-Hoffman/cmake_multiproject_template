function(configure_cpack_package)
    cmake_parse_arguments(CONFIG "" "NAME;DESCRIPTION;DEBIAN_ARCHITECTURE;RPM_ARCHITECTURE;DEBIAN_DEPENDS;RPM_REQUIRES;GENERATOR;" "" ${ARGN})

    # Package metadata
    set(CPACK_PACKAGE_NAME "${CONFIG_NAME}" PARENT_SCOPE)
    set(CPACK_PACKAGE_VENDOR "ExampleCompany" PARENT_SCOPE)
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${CONFIG_DESCRIPTION}" PARENT_SCOPE)
    set(CPACK_PACKAGE_VERSION ${CMAKE_PROJECT_VERSION} PARENT_SCOPE)
    set(CPACK_PACKAGE_CONTACT "John Doe <your.email@example.com>" PARENT_SCOPE)

    set(CPACK_DEB_COMPONENT_INSTALL ON PARENT_SCOPE)
    set(CPACK_RPM_COMPONENT_INSTALL ON PARENT_SCOPE)
    
    # Package architecture
    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "${CONFIG_DEBIAN_ARCHITECTURE}" PARENT_SCOPE)
    set(CPACK_RPM_PACKAGE_ARCHITECTURE "${CONFIG_RPM_ARCHITECTURE}"  PARENT_SCOPE)

    # Package dependencies
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "" "${CONFIG_DEBIAN_DEPENDS}" "" PARENT_SCOPE)
    set(CPACK_RPM_PACKAGE_REQUIRES "" "${CONFIG_RPM_REQUIRES}" "" PARENT_SCOPE)

    # Package generators
    set(CPACK_GENERATOR "" "${CONFIG_GENERATOR}" "" PARENT_SCOPE)

    # Package output directories
    set(CPACK_PACKAGE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/packages" PARENT_SCOPE)
endfunction()


function(package_add_test TESTNAME)
    cmake_parse_arguments(CONFIG "" "SOURCES;DEPENDS;" "" ${ARGN})
    add_executable(${TESTNAME} ${CONFIG_SOURCES})
    target_link_libraries(${TESTNAME} ${CONFIG_DEPENDS} GTest::GTest GTest::Main)
    add_test(NAME ${TESTNAME}
      COMMAND ${TESTNAME}
      WORKING_DIRECTORY ${CMAKE_PROJECT_BINARY_DIR})
    set_target_properties(${TESTNAME} PROPERTIES FOLDER test )
endfunction(package_add_test)
