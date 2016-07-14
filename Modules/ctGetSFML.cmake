# Use ctGetExtDep module to download SFML
include(ctGetExtDep)

#
# PREBUILT version of SFML
#
#ct_get_prebuilt(sfml-prebuilt
#  PACKAGE SFML
#  COMPONENTS audio graphics network window system
#  FOUND_VAR SFML_FOUND
#  ROOT_HINT_VAR SFML_ROOT
#  INCLUDE_DIR_VAR SFML_INCLUDE_DIR
#  #LIBS sfml-audio sfml-graphics sfml-network sfml-window sfml-system
#  URL http://www.sfml-dev.org/files/SFML-2.3.2-linux-gcc-64-bit.tar.gz
#  URL_MD5 1789d0eaaeb90c30bc37a0c007f18155)

# Try to find SFML package (all components)
ct_find_package(SFML COMPONENTS audio graphics network window system)

# If not found, then download SFML source files
if(NOT SFML_FOUND)
  #
  # SOURCE version of SFML
  #
  # Call ct_get_cmake to download,extract and include SFML CMake project
  ct_get_cmake(sfml
      URL http://www.sfml-dev.org/files/SFML-2.3.2-sources.zip
      URL_MD5 7f152bab6afc8ccbddaf51d6da318201
      INCLUDE_DIRS include)

  # define SFML_STATIC if the build type is not set to 'shared'
  if(NOT BUILD_SHARED_LIBS)
    add_definitions(-DSFML_STATIC)
  endif()

  # Define SFML_LIBRARIES with list of targets provided by cmake project
  set(SFML_LIBRARIES sfml-audio sfml-graphics sfml-network sfml-window sfml-system)
else()
  # Add SFML include directory found
  include_directories(${SFML_INCLUDE_DIR})
endif()

# EOF
