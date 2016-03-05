# Project setup
cmake_minimum_required(VERSION 3.0)
project(myapp)

# add_subdirectory(libtest_project)

# Build executable
add_executable(myapp src/main.cpp)

# target_link_libraries(myapp test)

# install(TARGETS myapp DESTINATION bin)