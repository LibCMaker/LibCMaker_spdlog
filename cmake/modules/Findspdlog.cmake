find_path(spdlog_INCLUDE_DIR
  NAMES spdlog/spdlog.h
  NO_CMAKE_ENVIRONMENT_PATH
  NO_SYSTEM_ENVIRONMENT_PATH
  NO_CMAKE_SYSTEM_PATH
)

find_library(spdlog_LIBRARY
  NAMES spdlog spdlogd
  NO_CMAKE_ENVIRONMENT_PATH
  NO_SYSTEM_ENVIRONMENT_PATH
  NO_CMAKE_SYSTEM_PATH
)

if(spdlog_INCLUDE_DIR)
  if(EXISTS "${spdlog_INCLUDE_DIR}/spdlog/version.h")
    file(READ "${spdlog_INCLUDE_DIR}/spdlog/version.h" spdlog_VERSION_CONTENT)

    string(REGEX MATCH "#define +SPDLOG_VER_MAJOR +([0-9]+)" _dummy "${spdlog_VERSION_CONTENT}")
    set(spdlog_VERSION_MAJOR "${CMAKE_MATCH_1}")

    string(REGEX MATCH "#define +SPDLOG_VER_MINOR +([0-9]+)" _dummy "${spdlog_VERSION_CONTENT}")
    set(spdlog_VERSION_MINOR "${CMAKE_MATCH_1}")

    string(REGEX MATCH "#define +SPDLOG_VER_PATCH +([0-9]+)" _dummy "${spdlog_VERSION_CONTENT}")
    set(spdlog_VERSION_PATCH "${CMAKE_MATCH_1}")

    set(spdlog_VERSION "${spdlog_VERSION_MAJOR}.${spdlog_VERSION_MINOR}.${spdlog_VERSION_PATCH}")
  endif()
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(spdlog
  REQUIRED_VARS spdlog_INCLUDE_DIR spdlog_LIBRARY
  VERSION_VAR spdlog_VERSION
)

mark_as_advanced(
  spdlog_INCLUDE_DIR
  spdlog_LIBRARY
  spdlog_VERSION_MAJOR
  spdlog_VERSION_MINOR
  spdlog_VERSION_PATCH
  spdlog_VERSION_STRING
)

if(spdlog_FOUND AND NOT (TARGET spdlog::spdlog))
  add_library(spdlog::spdlog UNKNOWN IMPORTED)
  set_target_properties(spdlog::spdlog PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${spdlog_INCLUDE_DIR}"
    IMPORTED_LINK_INTERFACE_LANGUAGES "CXX"
    IMPORTED_LOCATION "${spdlog_LIBRARY}"
  )
  set_property(TARGET spdlog::spdlog APPEND PROPERTY
    INTERFACE_COMPILE_DEFINITIONS SPDLOG_COMPILED_LIB
  )

  find_package(Threads REQUIRED)
  set_property(TARGET spdlog::spdlog APPEND PROPERTY
    INTERFACE_LINK_LIBRARIES Threads::Threads
  )

  find_package(fmt REQUIRED)
  set_property(TARGET spdlog::spdlog APPEND PROPERTY
    INTERFACE_COMPILE_DEFINITIONS SPDLOG_FMT_EXTERNAL
  )
  set_property(TARGET spdlog::spdlog APPEND PROPERTY
    INTERFACE_LINK_LIBRARIES fmt::fmt
  )
endif()
