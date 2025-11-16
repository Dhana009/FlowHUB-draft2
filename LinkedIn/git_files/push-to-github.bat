@echo off
REM Push LinkedIn folder to GitHub repo
REM Can be run from CMD or PowerShell

echo.
echo ========================================
echo   Push LinkedIn Folder to GitHub
echo ========================================
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0push-to-github.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Error occurred. Check the messages above.
    pause
    exit /b %ERRORLEVEL%
)
