@echo off

set batchdir=%~dp0
set buildtool=mingw

call %batchdir%invoke_%buildtool% %*
