if "%CPU_COUNT%"=="" set CPU_COUNT=%NUMBER_OF_PROCESSORS%
echo Using %CPU_COUNT% cores

mkdir build
cd build
SET PYAUDI_BUILD_DIR=%cd%

:: Ref: Chris Burr https://github.com/conda-forge/boost-feedstock/blob/c213d2f8fb3553ad18b295a1e8c9059ada0ef2d2/recipe/bld.bat#L3.
:: python 3.15 moved the windows headers from %PREFIX%\include into
:: %PREFIX%\include\python; ask python rather than hard-coding either layout
"%PYTHON%" -c "import sysconfig; print(sysconfig.get_config_var('INCLUDEPY'))" > py_include.txt
if %ERRORLEVEL% neq 0 exit 1
set /p PY_INC=<py_include.txt
del py_include.txt

cmake ... 

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
    -DPYTHON_INCLUDE_DIRS=%PY_INC% ^
    ..

cmake --build .  --config Release -- /m

cmake --build . --config Release --target install
