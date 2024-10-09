#!/bin/sh

# Actually run cmake now
# Example of giving custom options
# There will be the appropriate cmake files here
# cmake --preset=ninja -B build_msvc_amd64 eps/cmake

# Make the main makefile to now build with cmake as configured
# I don't know how to use cmake, but the point is, it should use cmake files stored in eps/cmake, with the Makefile just being a wrapper so the user can still ./configure and make as normal
# Also, remember to revert changes and go back to HEAD when cleaning, because of git.version
echo cat << _EOF
all:
	cmake --build build_msvc_amd64 --config Release eps/cmake

clean:
	git reset --hard HEAD

.PHONY: all clean
_EOF
>Makefile
