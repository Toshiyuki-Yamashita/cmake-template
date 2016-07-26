@echo off

set batchdir=%~dp0
set buildtool=mingw

%batchdir%invoke_%buildtool% %*
