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

# Part of "LibCMaker/cmake/cmr_get_download_params.cmake".

  if(version VERSION_EQUAL "1.4.2")
    set(arch_file_sha
      "821c85b120ad15d87ca2bc44185fa9091409777c756029125a02f81354072157")
  endif()
  if(version VERSION_EQUAL "1.4.2.20191231")
    set(arch_file_sha
      "43000c500dd2826def47c897dd6b9c25f16075155572759e19d37c5ecd2c42b3")
    set(src_commit
      "58e68901c741aab7a5b9c7ff059f228afc1d49e2")
  endif()
  if(version VERSION_EQUAL "1.9.2")
    set(arch_file_sha
      "6fff9215f5cb81760be4cc16d033526d1080427d236e86d70bb02994f85e3d38")
  endif()

  set(base_url "https://github.com/gabime/spdlog/archive/refs/tags")
  set(src_dir_name    "v${version}")
  set(arch_file_name  "${src_dir_name}.tar.gz")
  set(unpack_to_dir   "${unpacked_dir}/spdlog-${version}")

  set(${out_ARCH_SRC_URL}   "${base_url}/${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_DST_FILE}  "${download_dir}/spdlog-${arch_file_name}" PARENT_SCOPE)
  set(${out_ARCH_FILE_SHA}  "${arch_file_sha}" PARENT_SCOPE)
  set(${out_SHA_ALG}        "SHA256" PARENT_SCOPE)
  set(${out_UNPACK_TO_DIR}  "${unpack_to_dir}" PARENT_SCOPE)
  set(${out_UNPACKED_SOURCES_DIR}
    "${unpack_to_dir}/spdlog-${version}" PARENT_SCOPE
  )
  set(${out_VERSION_BUILD_DIR} "${build_dir}/${src_dir_name}" PARENT_SCOPE)

  if(src_commit)
    set(${out_ARCH_SRC_URL} "${base_url}/${src_commit}.tar.gz" PARENT_SCOPE)
    set(${out_UNPACKED_SOURCES_DIR}
      "${unpack_to_dir}/spdlog-${src_commit}" PARENT_SCOPE
    )
  endif()
