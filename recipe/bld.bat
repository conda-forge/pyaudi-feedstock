mkdir build
cd build
SET PYAUDI_BUILD_DIR=%cd%

cmake ^
    -G "Ninja" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_AUDI=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    -DCMAKE_BUILD_TYPE=Release ^
    ..

cmake --build . -- -v

cmake --build . --target install
