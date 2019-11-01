mkdir build
cd build

cmake ^
    -G "Ninja" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DAUDI_BUILD_AUDI=no ^
    -DAUDI_BUILD_MAIN=no ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    ..

cmake --build . -- -v

cmake --build . --target install
