#!/usr/bin/env bash

mkdir build
cd build
export PYAUDI_BUILD_DIR=`pwd`

if [[ "$target_platform" == linux-64 ]]; then
    LDFLAGS="-lrt ${LDFLAGS}"
fi


git clone https://github.com/pybind/pybind11.git
cd pybind11
git checkout 4f72ef846fe8453596230ac285eeaa0ce3278bb4
mkdir build
cd build
pwd
cmake \
    -DPYBIND11_TEST=NO \
    -DCMAKE_INSTALL_PREFIX=$PYAUDI_BUILD_DIR \
    -DCMAKE_PREFIX_PATH=$PYAUDI_BUILD_DIR \
    ..
make install
cd ../..


cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DAUDI_BUILD_AUDI=no \
    -DAUDI_BUILD_TESTS=no \
    -DAUDI_BUILD_PYAUDI=yes \
    -Dpybind11_DIR=$PYAUDI_BUILD_DIR/share/cmake/pybind11/ \
    ..

make -j${CPU_COUNT} VERBOSE=1

make install
