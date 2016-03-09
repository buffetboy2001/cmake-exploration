# VersionUtils.cmake

#
# Modeled heavily after macros for the Log4Cplus project
#

# Get Integrator version macro
# first param - path to include folder, we will rip version from version.h
macro(integrator_get_version _include_PATH vmajor vminor vpatch vsuffix)
  file(STRINGS "${_include_PATH}/version.h" _integrator_VER_STRING_AUX REGEX ".*#define[ ]+INTEGRATOR_VERSION_STR[ ]+")
  # message(${_integrator_VER_STRING_AUX}) debugging message
  string(REGEX MATCHALL "[0-9]+" _integrator_VER_LIST "${_integrator_VER_STRING_AUX}") # version numbers
  list(LENGTH _integrator_VER_LIST _integrator_VER_LIST_LEN)

  # suffix processing
  string(REGEX MATCH "[\"A-Z,a-z\")]*$" _integrator_VER_SUFFIX "${_integrator_VER_STRING_AUX}") # version suffix (string)
  string(LENGTH ${_integrator_VER_SUFFIX} _integrator_SUFFIX_LENGTH)
  if(_integrator_SUFFIX_LENGTH EQUAL 1)
    set(_integrator_VER_SUFFIX " ")
  else()
      string(REPLACE ")" "" _integrator_VER_SUFFIX ${_integrator_VER_SUFFIX}) # trim the suffix
  endif()
  # message(${_integrator_VER_SUFFIX}) # debugging message

# get each version value from the list and return
  set(${vsuffix} ${_integrator_VER_SUFFIX})
  if(_integrator_VER_LIST_LEN EQUAL 3)
    list(GET _integrator_VER_LIST 0 ${vmajor})
    list(GET _integrator_VER_LIST 1 ${vminor})
    list(GET _integrator_VER_LIST 2 ${vpatch})
  endif()
endmacro()


