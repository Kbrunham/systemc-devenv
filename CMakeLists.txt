cmake_minimum_required(VERSION 3.24)

project(systemc_devenv
        VERSION 0.1.0
        DESCRIPTION "SystemC development template"
        LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(ENABLE_COVERAGE "Enable gcov/lcov coverage instrumentation" OFF)
if (ENABLE_COVERAGE)
    add_compile_options(--coverage -fprofile-arcs -ftest-coverage)
    add_link_options(--coverage)
endif ()

include("${CMAKE_CURRENT_SOURCE_DIR}/extern/cmake_helpers/bcommon.cmake")
build_project_msg()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

include(CTest)
include(GoogleTest)

if (NOT Boost_ROOT)
    set(Boost_ROOT "${PROJECT_SOURCE_DIR}/boost")
endif ()
find_package(Boost 1.86 REQUIRED)
message(STATUS "Boost version: ${Boost_VERSION}")

if (DEFINED ENV{SYSTEMC_HOME})
    set(SYSTEMC_HOME "$ENV{SYSTEMC_HOME}")
else ()
    set(SYSTEMC_HOME "${PROJECT_SOURCE_DIR}/systemc")
endif ()
message(STATUS "SystemC home: ${SYSTEMC_HOME}")

find_path(SYSTEMC_INCLUDE_DIR
        NAMES systemc
        HINTS "${SYSTEMC_HOME}/include")
find_library(SYSTEMC_LIBRARY
        NAMES systemc
        HINTS "${SYSTEMC_HOME}/lib" "${SYSTEMC_HOME}/lib-${CMAKE_SYSTEM_NAME}")

if (NOT SYSTEMC_INCLUDE_DIR OR NOT SYSTEMC_LIBRARY)
    message(FATAL_ERROR "SystemC not found under ${SYSTEMC_HOME}. Run 'make systemc' or 'make prepare-tools'.")
endif ()

add_library(systemc::systemc UNKNOWN IMPORTED)
set_target_properties(systemc::systemc PROPERTIES
        IMPORTED_LOCATION "${SYSTEMC_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${SYSTEMC_INCLUDE_DIR}")

find_package(Threads REQUIRED)

set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
set(__TEMP_BUILD_SHARED_LIBS ${BUILD_SHARED_LIBS})
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
add_subdirectory("${PROJECT_SOURCE_DIR}/extern/googletest" "extern/googletest")
set(BUILD_SHARED_LIBS ${__TEMP_BUILD_SHARED_LIBS} CACHE BOOL "" FORCE)

add_library(cycle_accurate_hello INTERFACE)
target_include_directories(cycle_accurate_hello INTERFACE
        "${CMAKE_CURRENT_SOURCE_DIR}/model/views/cycle_accurate")
target_link_libraries(cycle_accurate_hello INTERFACE systemc::systemc Threads::Threads)

add_executable(hello_systemc model/views/cycle_accurate/hello_main.cpp)
target_link_libraries(hello_systemc PRIVATE cycle_accurate_hello)
set_target_properties(hello_systemc PROPERTIES FOLDER model)

project_add_test(
        systemc_smoke
        "verification/systemc/smoke/smoke_test.cpp"
        "cycle_accurate_hello"
)

target_include_directories(systemc_smoke PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/model/views/cycle_accurate")
