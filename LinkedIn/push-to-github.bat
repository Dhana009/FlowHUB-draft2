@echo off
REM Push LinkedIn folder to GitHub repo
REM Can be run from CMD or PowerShell

powershell -ExecutionPolicy Bypass -File "%~dp0push-to-github.ps1"

