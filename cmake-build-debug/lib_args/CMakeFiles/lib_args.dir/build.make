# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.21

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/c/Users/nikse/CLionProjects/command_line_tool

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug

# Include any dependencies generated for this target.
include lib_args/CMakeFiles/lib_args.dir/depend.make
# Include the progress variables for this target.
include lib_args/CMakeFiles/lib_args.dir/progress.make

# Include the compile flags for this target's objects.
include lib_args/CMakeFiles/lib_args.dir/flags.make

lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.o: lib_args/CMakeFiles/lib_args.dir/flags.make
lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.o: ../lib_args/src/lib_args.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.o"
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lib_args.dir/src/lib_args.cpp.o -c /mnt/c/Users/nikse/CLionProjects/command_line_tool/lib_args/src/lib_args.cpp

lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lib_args.dir/src/lib_args.cpp.i"
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /mnt/c/Users/nikse/CLionProjects/command_line_tool/lib_args/src/lib_args.cpp > CMakeFiles/lib_args.dir/src/lib_args.cpp.i

lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lib_args.dir/src/lib_args.cpp.s"
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /mnt/c/Users/nikse/CLionProjects/command_line_tool/lib_args/src/lib_args.cpp -o CMakeFiles/lib_args.dir/src/lib_args.cpp.s

# Object files for target lib_args
lib_args_OBJECTS = \
"CMakeFiles/lib_args.dir/src/lib_args.cpp.o"

# External object files for target lib_args
lib_args_EXTERNAL_OBJECTS =

lib_args/liblib_args.a: lib_args/CMakeFiles/lib_args.dir/src/lib_args.cpp.o
lib_args/liblib_args.a: lib_args/CMakeFiles/lib_args.dir/build.make
lib_args/liblib_args.a: lib_args/CMakeFiles/lib_args.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library liblib_args.a"
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && $(CMAKE_COMMAND) -P CMakeFiles/lib_args.dir/cmake_clean_target.cmake
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lib_args.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib_args/CMakeFiles/lib_args.dir/build: lib_args/liblib_args.a
.PHONY : lib_args/CMakeFiles/lib_args.dir/build

lib_args/CMakeFiles/lib_args.dir/clean:
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args && $(CMAKE_COMMAND) -P CMakeFiles/lib_args.dir/cmake_clean.cmake
.PHONY : lib_args/CMakeFiles/lib_args.dir/clean

lib_args/CMakeFiles/lib_args.dir/depend:
	cd /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/c/Users/nikse/CLionProjects/command_line_tool /mnt/c/Users/nikse/CLionProjects/command_line_tool/lib_args /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args /mnt/c/Users/nikse/CLionProjects/command_line_tool/cmake-build-debug/lib_args/CMakeFiles/lib_args.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib_args/CMakeFiles/lib_args.dir/depend

