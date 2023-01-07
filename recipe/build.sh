#!/bin/sh
set -euo pipefail

# FindOpenCascade.cmake bundled with OCP references the env var `CONDA_PREFIX`.
# That is the right prefix when manually running CMake inside a conda env, but
# the wrong one when using conda-build. Substitute the right prefix inline.
CONDA_PREFIX="${PREFIX}" cmake ${CMAKE_ARGS} -B build -S "${SRC_DIR}/src" \
	-G Ninja \
	-DPython3_FIND_STRATEGY="LOCATION" \
	-DPython3_ROOT_DIR=$CONDA_PREFIX \
	-DCMAKE_BUILD_TYPE=Release

cmake --build build -j ${CPU_COUNT}
cmake --install build --prefix "${STDLIB_DIR}"
