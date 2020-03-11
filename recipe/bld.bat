mkdir build
cd build

$Env:PYAUDI_BUILD_DIR=pwd

git clone https://github.com/pybind/pybind11.git
cd pybind11
mkdir build
cd build
cmake ^
    -G "Ninja" ^
    -DPYBIND11_TEST=NO ^
    -DCMAKE_INSTALL_PREFIX=%PYAUDI_BUILD_DIR% ^
    -DCMAKE_PREFIX_PATH=%PYAUDI_BUILD_DIR% ^
    ..
make install
cd ../..

cmake ^
    -G "Ninja" ^
    -DCMAKE_C_COMPILER=clang-cl ^
    -DCMAKE_CXX_COMPILER=clang-cl ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DAUDI_BUILD_MAIN=no ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    -Dpybind11_DIR=%PYAUDI_BUILD_DIR%/include/pybind11 ^
    ..

cmake --build . -- -v

cmake --build . --target install
