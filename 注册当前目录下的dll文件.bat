@echo off
for /f "delims=" %%i in ('dir /b *.dll') do regsvr32 /i %%i&&echo.³É¹¦×¢²á%%i
pause