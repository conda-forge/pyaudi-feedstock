if "%CPU_COUNT%"=="" set CPU_COUNT=%NUMBER_OF_PROCESSORS%
echo Using %CPU_COUNT% cores

mkdir build
cd build
SET PYAUDI_BUILD_DIR=%cd%

cmake ^
    -G "Visual Studio 17 2022" ^
    -A x64 ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_CXX_FLAGS="/EHsc /wd4244 /wd4018 /wd4456 /wd4530" ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_AUDI=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    ..

cmake --build .  --config Release -- /m

cmake --build . --config Release --target install
