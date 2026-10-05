if "%CPU_COUNT%"=="" set CPU_COUNT=%NUMBER_OF_PROCESSORS%
echo Using %CPU_COUNT% cores

mkdir build
cd build
SET PYAUDI_BUILD_DIR=%cd%

REM Ensure Python paths are properly set for CMake
if "%PY_INC%"=="" (
    for /f "delims=" %%i in ('python -c "import sysconfig; print(sysconfig.get_path('include'))"') do set "PY_INC=%%i"
)

cmake %CMAKE_ARGS% -GNinja ^
    -DCMAKE_CXX_FLAGS="/EHsc /wd4244 /wd4018 /wd4456 /wd4530" ^
    -DAUDI_BUILD_TESTS=no ^
    -DAUDI_BUILD_AUDI=no ^
    -DAUDI_BUILD_PYAUDI=yes ^
    -DPYTHON_INCLUDE_DIR=%PY_INC% ^
    ..
cmake --build . -j%CPU_COUNT%
cmake --build . --target install
