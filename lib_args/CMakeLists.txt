add_library(lib_args)

target_sources(lib_args
        PRIVATE
        src/lib_args.cpp)

target_compile_features(lib_args PUBLIC cxx_std_17)
target_include_directories(lib_args PUBLIC inc/)
set_target_properties(lib_args PROPERTIES CXX_EXTENSIONS OFF)

target_compile_options(lib_args PUBLIC
        # set warnings for all build types
        $<$<CXX_COMPILER_ID:GNU,Clang,AppleClang>:-Wall -Wextra -Wpedantic -Werror -fno-omit-frame-pointer>
        # debug optimisation in Debug
        $<$<AND:$<CXX_COMPILER_ID:GNU,Clang,AppleClang>,$<CONFIG:Release>>:-O3>
        # O3 optimisation Release
        $<$<AND:$<CXX_COMPILER_ID:GNU,Clang,AppleClang>,$<CONFIG:Debug>>:-Og -g>
        )

# Set options for MSVC
target_compile_options(lib_args PUBLIC
        # set warnings for all build types
        $<$<CXX_COMPILER_ID:MSVC>:/W4>
        # debug optimisation in Debug
        $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Release>>:/O2>
        # O3 optimisation in Release
        $<$<AND:$<CXX_COMPILER_ID:MSVC>,$<CONFIG:Debug>>:/RTC1 /Od /Zi>
        )