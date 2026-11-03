# Fetches the Dusklight source tree pinned by DUSKLIGHT_VERSION.
include_guard(GLOBAL)

set(DUSKLIGHT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/dusklight" CACHE PATH
    "Path to the Dusklight source tree")
set(DUSKLIGHT_REPOSITORY "https://github.com/TwilitRealm/dusklight.git" CACHE STRING
    "Dusklight git repository to fetch from")

function(_dusklight_git)
    execute_process(
        COMMAND "${GIT_EXECUTABLE}" ${ARGN}
        WORKING_DIRECTORY "${DUSKLIGHT_DIR}"
        RESULT_VARIABLE result
    )
    if (NOT result EQUAL 0)
        message(FATAL_ERROR "Dusklight git operation failed for ${DUSKLIGHT_VERSION}")
    endif ()
endfunction()

set(stamp "${DUSKLIGHT_DIR}/.stamp")
if (EXISTS "${DUSKLIGHT_DIR}/sdk/CMakeLists.txt" AND NOT EXISTS "${stamp}")
    message(STATUS "Dusklight: using existing checkout at ${DUSKLIGHT_DIR}")
else ()
    if (NOT DUSKLIGHT_VERSION)
        message(FATAL_ERROR "Dusklight: DUSKLIGHT_VERSION is not set")
    endif ()

    set(fetched "")
    if (EXISTS "${stamp}")
        file(READ "${stamp}" fetched)
        string(STRIP "${fetched}" fetched)
    endif ()

    if (NOT fetched STREQUAL DUSKLIGHT_VERSION)
        find_package(Git QUIET REQUIRED)
        file(MAKE_DIRECTORY "${DUSKLIGHT_DIR}")
        if (NOT EXISTS "${DUSKLIGHT_DIR}/.git")
            _dusklight_git(init --quiet)
            _dusklight_git(remote add origin "${DUSKLIGHT_REPOSITORY}")
        endif ()
        _dusklight_git(fetch --depth 1 "${DUSKLIGHT_REPOSITORY}" "${DUSKLIGHT_VERSION}")
        _dusklight_git(-c advice.detachedHead=false checkout --force FETCH_HEAD)
        _dusklight_git(submodule update --init --depth 1 extern/aurora)
        file(WRITE "${stamp}" "${DUSKLIGHT_VERSION}\n")
    endif ()
endif ()
