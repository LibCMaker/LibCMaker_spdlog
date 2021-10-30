# ****************************************************************************
#  Project:  LibCMaker_spdlog
#  Purpose:  A CMake build script for spdlog library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2019 NikitaFeodonit
#
#    This file is part of the LibCMaker_spdlog project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************

#-----------------------------------------------------------------------
# The file is an example of the convenient script for the library build.
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# Lib's name, version, paths
#-----------------------------------------------------------------------

set(SPDLOG_lib_NAME "spdlog")
set(SPDLOG_lib_VERSION "1.9.2" CACHE STRING "SPDLOG_lib_VERSION")
set(SPDLOG_lib_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "SPDLOG_lib_DIR")

# To use our Find<LibName>.cmake.
list(APPEND CMAKE_MODULE_PATH "${SPDLOG_lib_DIR}/cmake/modules")


#-----------------------------------------------------------------------
# LibCMaker_<LibName> specific vars and options
#-----------------------------------------------------------------------

option(COPY_SPDLOG_CMAKE_BUILD_SCRIPTS "COPY_SPDLOG_CMAKE_BUILD_SCRIPTS" ON)

# Used in 'cmr_build_rules_spdlog.cmake'.
set(
  LIBCMAKER_FMT_SRC_DIR "${LibCMaker_LIB_DIR}/LibCMaker_fmt"
  CACHE PATH "LIBCMAKER_FMT_SRC_DIR"
)


#-----------------------------------------------------------------------
# Library specific vars and options
#-----------------------------------------------------------------------

option(SPDLOG_BUILD_SHARED "Build shared library" ${BUILD_SHARED_LIBS})
option(SPDLOG_BUILD_EXAMPLE "Build example" OFF)
option(SPDLOG_BUILD_EXAMPLE_HO "Build header only example" OFF)
option(SPDLOG_BUILD_TESTS "Build tests" OFF)
option(SPDLOG_BUILD_TESTS_HO "Build tests using the header only version" OFF)
option(SPDLOG_BUILD_BENCH
  "Build benchmarks (Requires https://github.com/google/benchmark.git to be installed)"
  OFF
)
option(SPDLOG_SANITIZE_ADDRESS "Enable address sanitizer in tests" OFF)
option(SPDLOG_INSTALL "Generate the install target" ON)
option(SPDLOG_FMT_EXTERNAL "Use external fmt library instead of bundled" ON)
option(SPDLOG_FMT_EXTERNAL_HO
  "Use external fmt header-only library instead of bundled"
  OFF
)
option(SPDLOG_NO_EXCEPTIONS
  "Compile with -fno-exceptions. Call abort() on any spdlog exceptions"
  OFF
)

if(WIN32)
  option(SPDLOG_WCHAR_SUPPORT "Support wchar api" OFF)
  option(SPDLOG_WCHAR_FILENAMES "Support wchar filenames" OFF)
endif()
if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  option(SPDLOG_CLOCK_COARSE
    "Use the much faster (but much less accurate) CLOCK_REALTIME_COARSE instead of the regular clock"
    OFF
  )
endif()

option(SPDLOG_PREVENT_CHILD_FD
  "Prevent from child processes to inherit log file descriptors"
  OFF
)
option(SPDLOG_NO_THREAD_ID
  "Prevent spdlog from querying the thread id on each log call if thread id is not needed"
  OFF
)
option(SPDLOG_NO_TLS "Prevent spdlog from using thread local storage" OFF)
option(SPDLOG_NO_ATOMIC_LEVELS
  "Prevent spdlog from using of std::atomic log levels (use only if your code never modifies log levels concurrently"
  OFF
)


#-----------------------------------------------------------------------
# Build, install and find the library
#-----------------------------------------------------------------------

cmr_find_package(
  LibCMaker_DIR   ${LibCMaker_DIR}
  NAME            ${SPDLOG_lib_NAME}
  VERSION         ${SPDLOG_lib_VERSION}
  LIB_DIR         ${SPDLOG_lib_DIR}
  REQUIRED
)
