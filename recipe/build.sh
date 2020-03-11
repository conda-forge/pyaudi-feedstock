#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == linux-64 ]]; then
    LDFLAGS="-lrt ${LDFLAGS}"
fi


git clone https://github.com/pybind/pybind11.git
cd pybind11
mkdir build
cd build
cmake \
    -DPYBIND11_TEST=NO \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_PREFIX_PATH=/usr/local \
    ..
make install
cd ../..


cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DAUDI_BUILD_AUDI=no \
    -DAUDI_BUILD_MAIN=no \
    -DAUDI_BUILD_TESTS=no \
    -DAUDI_BUILD_PYAUDI=yes \
    -Dpybind11_DIR=/usr/local/include/pybind11 \
    ..

make -j${CPU_COUNT} VERBOSE=1

make install
