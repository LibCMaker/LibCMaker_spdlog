# ****************************************************************************
#  Project:  LibCMaker_spdlog
#  Purpose:  A CMake build script for spdlog library
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2020 NikitaFeodonit
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

set(LibCMaker_LIB_DIR "${CMAKE_CURRENT_LIST_DIR}/libs")
set(LibCMaker_DIR "${LibCMaker_LIB_DIR}/LibCMaker")

include("${LibCMaker_DIR}/cmake/cmr_get_cmake_min_ver.cmake" NO_POLICY_SCOPE)
cmr_get_cmake_min_ver()
cmake_minimum_required(VERSION ${cmr_CMAKE_MIN_VER})

include("${LibCMaker_DIR}/samples/cmr_samples_common_macros.cmake")
cmr_common_sample_part__before_project()

project(LibCMaker_spdlog_Compile_Test CXX)

cmr_common_sample_part__project_settings()


#-----------------------------------------------------------------------
# Common sample part
#-----------------------------------------------------------------------

cmr_common_sample_part__add_executable()


#-----------------------------------------------------------------------
# Download, configure, build, install and find the required libraries
#-----------------------------------------------------------------------

include(${LibCMaker_LIB_DIR}/LibCMaker_fmt/cmr_build_fmt.cmake)
include(${LibCMaker_LIB_DIR}/LibCMaker_spdlog/cmr_build_spdlog.cmake)


#-----------------------------------------------------------------------
# Build the executable of the example
#-----------------------------------------------------------------------

set(example_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")

target_sources(${PROJECT_NAME}
  PRIVATE
    ${example_src_DIR}/example.cpp
)
set_target_properties(${PROJECT_NAME} PROPERTIES
  CXX_STANDARD 11
)


#-----------------------------------------------------------------------
# Link to the libraries
#-----------------------------------------------------------------------

# spdlog
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog)


#-----------------------------------------------------------------------
# Testing
#-----------------------------------------------------------------------

set(test_src_DIR "${CMAKE_CURRENT_LIST_DIR}/src")
add_subdirectory(test)
