mkdir build
cd build

cmake ^
    -G "Visual Studio 16 2019" -A x64 ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DBoost_NO_BOOST_CMAKE=ON ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_AUDI=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    -DCMAKE_BUILD_TYPE=Release ^
    ..

cmake --build . --config Release

cmake --build . --config Release --target install

