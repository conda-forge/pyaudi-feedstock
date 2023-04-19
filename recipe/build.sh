#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == osx-* ]]; then
    # Workarounds for missing C++17 features.
    export CXXFLAGS="$CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY -fno-aligned-allocation"
else
    LDFLAGS="-lrt ${LDFLAGS}"
fi

cmake ${CMAKE_ARGS} \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DAUDI_BUILD_AUDI=no \
    -DAUDI_BUILD_TESTS=no \
    -DAUDI_BUILD_PYAUDI=yes \
    ..

make -j${CPU_COUNT} VERBOSE=1

make install
