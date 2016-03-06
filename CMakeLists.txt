# Project setup
cmake_minimum_required(VERSION 3.0)
project(myapp)
enable_language(CXX)

# bring log4cplus includes onto our path
include_directories(/usr/local/include/log4cplus/)
include_directories(/usr/local/include/integrator/)

# add directories that the linker should use when searching for libraries
link_directories(/usr/local/bin)

# Build executable
add_executable(myapp src/main.cpp)
target_link_libraries(myapp cyglog4cplus-1-2-5.dll integrator-1.1.1-SNAPSHOT)

# installing to a separate bin directory
install(TARGETS myapp DESTINATION bin)

# Thoughts & notes:
#
# Should I want to, cmake .7z can be downloaded at this URL: http://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/1.2.0/log4cplus-1.2.0.7z?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Flog4cplus%2Ffiles%2F&ts=1457216600&use_mirror=netcologne