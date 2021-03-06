 # set compiler
 # ECMAKE_COMPILER is the compiler
 # ECMAKE_COMPILER_VERSION is the version of the compiler
if(DEFINED ECMAKE_COMPILER)
    if(DEFINED ECMAKE_COMPILER_VERSION)
        set(ECMAKE_COMPILER_VERSION_SUFFIX "-${ECMAKE_COMPILER_VERSION}")
    endif()
    
    if(${ECMAKE_COMPILER} STREQUAL gcc)
        set(ECMAKE_COMPILER_C ${ECMAKE_COMPILER_PATH}/gcc${ECMAKE_COMPILER_VERSION_SUFFIX})
        set(ECMAKE_COMPILER_CXX ${ECMAKE_COMPILER_PATH}/g++${ECMAKE_COMPILER_VERSION_SUFFIX})
    endif()

    if(${ECMAKE_COMPILER} STREQUAL clang)
        set(ECMAKE_COMPILER_C ${ECMAKE_COMPILER_PATH}/clang${ECMAKE_COMPILER_VERSION_SUFFIX})
        set(ECMAKE_COMPILER_CXX ${ECMAKE_COMPILER_PATH}/clang++${ECMAKE_COMPILER_VERSION_SUFFIX})
    endif()
    
    set(CMAKE_C_COMPILER ${ECMAKE_COMPILER_C})
    set(CMAKE_CXX_COMPILER ${ECMAKE_COMPILER_CXX})
endif()

# use ccache
if(DEFINED ECMAKE_USE_CCACHE)
    set(ignoreme "${ECMAKE_USE_CCACHE}")    # suppress warning for unused variable

    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "ccache")
endif() 

# set linker
if(DEFINED ECMAKE_LINKER_GOLD)
    set(ignoreme "${ECMAKE_LINKER_GOLD}")    # suppress warning for unused variable
    
    # use -gsplit-dwarf to speed up link time
    set( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=gold -L/usr/local/lib -gsplit-dwarf" CACHE STRING "" FORCE)
    set( CMAKE_SHARED_LINKER_FLAGS  "${CMAKE_SHARED_LINKER_FLAGS} -fuse-ld=gold -L/usr/local/lib -gsplit-dwarf" CACHE STRING "" FORCE )
endif()

# gcov debug flags
if(DEFINED ECMAKE_COVERAGE_ON)
    set(ignoreme "${ECMAKE_COVERAGE_ON}")    # suppress warning for unused variable

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ECMAKE_COVERAGE_OPTIONS}" CACHE STRING "" FORCE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ECMAKE_COVERAGE_OPTIONS}" CACHE STRING "" FORCE)

    set( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} --coverage" CACHE STRING "" FORCE)
    set( CMAKE_SHARED_LINKER_FLAGS  "${CMAKE_SHARED_LINKER_FLAGS} --coverage" CACHE STRING "" FORCE )
endif()

# address sanitizer flags
if(DEFINED ECMAKE_ADDRESS_SANITIZER_ON)
    set(ignoreme "${ECMAKE_ADDRESS_SANITIZER_ON}")    # suppress warning for unused variable

    # Add options for AddressSanitizer
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ECMAKE_ADDRESS_SANITIZER_OPTIONS}" CACHE STRING "" FORCE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ECMAKE_ADDRESS_SANITIZER_OPTIONS}" CACHE STRING "" FORCE)

     #-fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2
endif()

# leak sanitizer flags
if(DEFINED ECMAKE_LEAK_SANITIZER_ON)
    set(ignoreme "${ECMAKE_LEAK_SANITIZER_ON}")    # suppress warning for unused variable

    # Add options for AddressSanitizer
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${ECMAKE_LEAK_SANITIZER_OPTIONS}" CACHE STRING "" FORCE)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${ECMAKE_LEAK_SANITIZER_OPTIONS}" CACHE STRING "" FORCE)

     #-fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2
endif()