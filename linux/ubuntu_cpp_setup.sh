#!/bin/sh

sudo apt update
#
sudo apt install -y g++ codelite cmake

# Next go to ~/GIT/code/LEARN/c++/HelloWorld/src examine the following:
# CMakeLists.txt
# cmake_minimum_required (VERSION 3.5)
# 
# project (HelloWorld)
# 
# set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++14")
# set (source_dir "${PROJECT_SOURCE_DIR}/src")
# 
# file (GLOB source_files "${source_dir}/*.cpp")        
# 
# add_executable (HelloWorld ${source_files})
# 
# execute : $cmake -G "CodeLite - Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug
#
# $codelite HelloWorld.workspace &
