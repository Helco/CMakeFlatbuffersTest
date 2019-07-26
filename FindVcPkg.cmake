# Finds and sets up vcpkg as toolchain file
if (DISABLE_VCPKG)
  message(WARNING " -- VcPkg disabled. I hope you know what you are doing!")
  return()
endif()

if (CMAKE_TOOLCHAIN_FILE MATCHES "vcpkg\.cmake$")
  message(" -- VcPkg was already integrated as toolchain file")
  return()
endif()

# Find vcpkg toolchain file
find_file(VCPKG
  NAMES "vcpkg.cmake"
  PATHS
    "C:\\"
    "$ENV{VCPKG_ROOT}"
  PATH_SUFFIXES
    "scripts/buildsystems/"
    "vcpkg/scripts/buildsystems/"
)
if (VCPKG STREQUAL "VCPKG-NOTFOUND")
  message(FATAL_ERROR "Could not find VcPkg, please specify root path via -DVCPKG_ROOT=<path> ")
  return()
endif()

# Integrate without overriding custom toolchain file
if (DEFINED CMAKE_TOOLCHAIN_FILE)
  set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE "$CMAKE_TOOLCHAIN_FILE"
    CACHE STRING "Toolchain file to be loaded after VcPkg"
  )
  message(" -- VcPkg integrated with chainload toolchain file")
else()
  message(" -- VcPkg integrated as single toolchain file")
endif()
set(CMAKE_TOOLCHAIN_FILE ${VCPKG}
  CACHE STRING "Main toolchain file"
)
