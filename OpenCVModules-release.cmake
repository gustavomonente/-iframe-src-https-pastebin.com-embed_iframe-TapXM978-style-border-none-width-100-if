#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "opencv_world" for configuration "Release"
set_property(TARGET opencv_world APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(opencv_world PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/opencv_world410.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/opencv_world410.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS opencv_world )
list(APPEND _IMPORT_CHECK_FILES_FOR_opencv_world "${_IMPORT_PREFIX}/lib/opencv_world410.lib" "${_IMPORT_PREFIX}/bin/opencv_world410.dll" )

# Import target "opencv_pvl" for configuration "Release"
set_property(TARGET opencv_pvl APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(opencv_pvl PROPERTIES
  IMPORTED_IMPLIB_RELEASE "${_IMPORT_PREFIX}/lib/opencv_pvl410.lib"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/opencv_pvl410.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS opencv_pvl )
list(APPEND _IMPORT_CHECK_FILES_FOR_opencv_pvl "${_IMPORT_PREFIX}/lib/opencv_pvl410.lib" "${_IMPORT_PREFIX}/bin/opencv_pvl410.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
