@echo off 

set buildroot=%~1
set buildtype=%~2

if "%3" == "" (
    set buildconfig=Debug
)
if "%3" == "debug" (
    set buildconfig=Debug
)
if "%3" == "release" (
    set buildconfig=Release
)

set MINGW_PATH=C:\usr\share\ruby\ruby\devkit-mingw64-64\mingw\bin
set builddir=%buildroot%\build
set srcdir=%buildroot%\src
path=C:\usr\share\CMake\bin;%MINGW_PATH%



if "%buildtype%" == "generate" (
    if not exist "%builddir%" ( mkdir "%builddir%" )
    set arg=-G "MinGW Makefiles" -D CMAKE_PROGRAM_PATH=%MINGW_PATH% -D CMAKE_BUILD_TYPE=%buildconfig% "%srcdir%" 
)

if "%buildtype%" == "build" (
    if not exist "%builddir%\Makefile" (call %0 %1 generate %3)
    set arg=--build %builddir% --config %buildconfig%
)

if "%buildtype%" == "distclean" (
    rmdir /q /s "%builddir%"
    exit /b 0
)

if "%buildtype%" == "clean" (
    set arg=--build %builddir% --target clean
)

if "%buildtype%" == "regenerate" (
    call %0 %1 distclean %3
    call %0 %1 generate %3
    exit /b 0
)

if "%buildtype%" == "rebuild" (
    call %0 %1 clean %3
    call %0 %1 build %3
    exit /b 0
)

pushd %builddir%
cmake  %arg% 
popd 
