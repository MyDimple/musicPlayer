# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

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

# Produce verbose output by default.
VERBOSE = 1

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
CMAKE_SOURCE_DIR = /run/media/root/study/freems

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug

# Utility rule file for appfreems_qmllint_module.

# Include any custom commands dependencies for this target.
include CMakeFiles/appfreems_qmllint_module.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/appfreems_qmllint_module.dir/progress.make

CMakeFiles/appfreems_qmllint_module: /opt/Qt/6.7.1/gcc_64/bin/qmllint
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/Main.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailFavoratePageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailHistoryPageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailLocalPageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailRecommendPageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailSearchPageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/LayoutBottomView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/LayoutHeaderView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/MusicIconButton.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/MusicToolButton.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/MusicBannerView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/MusicRoundImage.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/MusicListView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/PageHomeView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/DetailPlayListPageView.qml
CMakeFiles/appfreems_qmllint_module: /run/media/root/study/freems/HotMusic.qml
CMakeFiles/appfreems_qmllint_module: .rcc/qmllint/appfreems_module.rsp
	cd /run/media/root/study/freems && /opt/Qt/6.7.1/gcc_64/bin/qmllint @/run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug/.rcc/qmllint/appfreems_module.rsp

appfreems_qmllint_module: CMakeFiles/appfreems_qmllint_module
appfreems_qmllint_module: CMakeFiles/appfreems_qmllint_module.dir/build.make
.PHONY : appfreems_qmllint_module

# Rule to build all files generated by this target.
CMakeFiles/appfreems_qmllint_module.dir/build: appfreems_qmllint_module
.PHONY : CMakeFiles/appfreems_qmllint_module.dir/build

CMakeFiles/appfreems_qmllint_module.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/appfreems_qmllint_module.dir/cmake_clean.cmake
.PHONY : CMakeFiles/appfreems_qmllint_module.dir/clean

CMakeFiles/appfreems_qmllint_module.dir/depend:
	cd /run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /run/media/root/study/freems /run/media/root/study/freems /run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug /run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug /run/media/root/study/freems/build/Desktop_Qt_6_7_1-Debug/CMakeFiles/appfreems_qmllint_module.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/appfreems_qmllint_module.dir/depend

