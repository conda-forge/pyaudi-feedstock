#!/usr/bin/env bash

mkdir build
cd build
export PYAUDI_BUILD_DIR=`pwd`

if [[ "$target_platform" == linux-64 ]]; then
    LDFLAGS="-lrt ${LDFLAGS}"
fi

cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DAUDI_BUILD_AUDI=no \
    -DAUDI_BUILD_TESTS=no \
    -DAUDI_BUILD_PYAUDI=yes \
    ..

make -j${CPU_COUNT} VERBOSE=1

make install
