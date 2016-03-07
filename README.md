# cmake-exploration
A place for me to play further with CMake and hopefully gain a better understanding of it's team usage capabilities.

Of particular use is this example blog post by Mirko Kiefer. It does a good job of explaining the INSTALL concept in CMake, which is a capability of the tool that I'm very interested in, but have had a hard time grasping. So, here I go...
http://mirkokiefer.com/blog/2013/03/cmake-by-example/

## Dependencies
So, dependency handling in CMake has really bugged me. Sometimes I end up with funky sub-directories that I don't really want or libraries that are offically external and never-changing that CMake perpetually re-builds. Grrr...it should be simpler.

### log4cplus
I love loggers, so my first dependency in any new project is probably going to be a logger. I'll use [log4cplus](https://sourceforge.net/projects/log4cplus/) in this case. I don't want this in my git repo since it's external and never changing. To avoid that, I follow the log4cplus directions to install it into /usr/local/bin and /usr/local/include. That goes smoothly on Cygwin. The final library is: cyglog4cplus.dll. Bleh name, but I can live with it.

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

### integrator
Here, I want to emulate a team dev environment. Let's say some other team is developing a library, [integrator](https://github.com/buffetboy2001/integrator), that myapp needs. Let's say they are actively developing and tagging releases. The point is that the integrator dependent library is independent of this project and should not be included in this project's repo. So, what do we do? Let's take a few approaches.

#### First dependency infrastucture: Manual Install
So, let's try to first work with a separately installed library. The installation will occur by CMake. So, the integrator project needs to have created an install target for its binary (libintegrator.dll) and any of its include files. The installation needs to indicate the version number so that we can keep track of an evolving dependency and upgrade or downgrade as necessary.

NOTE: in this paradigm, CMake is not managing this dependency for us. We must do it ourselves by checking out that project and installing it manually. It's not quite what we'd prefer for a team development environment. And even less satisfactory if anything Agile is going on! Let's try to go beyond this business of making the developer manually manage the project dependencies.

```
# Make sure the include path from the manual install is provided to CMake
include_directories(/usr/local/include/integrator/)

# Make sure to link the myapp binary against the integrator library
target_link_libraries(myapp cyglog4cplus-1-2-5.dll integrator-1.1.1-SNAPSHOT)
```

#### Second Approach: CMake-Managed Install
[] Complete Me

#### Third Approach: CMake-Managed Fetch from an Artifact Repository
[] Complete Me

## Installing
CMake has been setup to install the application. That doesn't mean much; it just dumps it into /usr/local/bin. But it does mean the binary is available to the local user. So, hey-hey! Maybe we'll focus on deploying...

## Deploying
[] Complete Me. What I'm hoping to do here is actually deploy the application in the broader sense. You know, like to a DevOps pipeline that provides the goods to the end user. Let's see what we can do there. CMake, come to our rescue!