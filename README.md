# cmake-exploration
A place for me to play further with CMake and hopefully gain a better understanding of it's team usage capabilities.

Of particular use is this example blog post by Mirko Kiefer. It does a good job of explaining the INSTALL concept in CMake, which is a capability of the tool that I'm very interested in, but have had a hard time grasping. So, here I go...
http://mirkokiefer.com/blog/2013/03/cmake-by-example/

## Dependencies
So, dependency handling in CMake has really bugged me. Sometimes I end up with funky sub-directories that I don't really want or libraries that are offically external and never-changing that CMake perpetually re-builds. Grrr...it should be simpler.

### log4cplus
I love loggers, so my first dependency is going to be a logger. I don't want this in my git repo since it's external and never changing. So, I follow the log4cplus directions to install it into /usr/local/bin and /usr/local/include. That goes smoothly on Cygwin. The final library is: cyglog4cplus.dll. I can live with that.

To get CMake to work with it, I had to do a bunch of playing around & failing. find_library() and find_package() would not work for me. Neither did add_library(). Eventually, I found this simple solution to get the build to work correctly.

```
# bring log4cplus includes onto our path
include_directories(/usr/local/include/log4cplus/)

# add directories that the linker should use when searching for libraries
link_directories(/usr/local/bin)

# Build executable
add_executable(myapp src/main.cpp)
target_link_libraries(myapp cyglog4cplus-1-2-5.dll) # note that I had to fully specify the name here; couldn't get it to link any other way
```