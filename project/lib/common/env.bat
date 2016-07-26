::@echo off

setlocal
set buildroot=%~1
set buildini=%buildroot%\project\config\env.txt

call :read %buildini%

endlocal

:read
    setlocal
    set file=%1
    for /f "delims= eol=" %%F (%file%) do (
        if not "%%F" == "" (
            set %%F
        )
    )
    endlocal
    exit /b 0
