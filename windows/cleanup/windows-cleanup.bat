@echo off
:: Windows Cleanup Script
:: Run as Administrator for best results

title Windows System Cleanup
color 0A

echo ============================================
echo    WINDOWS SYSTEM CLEANUP
echo ============================================
echo.

:: Creates operation log
set "LOGFILE=%USERPROFILE%\Desktop\cleanup_log_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%.txt"
set "LOGFILE=%LOGFILE: =0%"

echo Cleanup started on %date% %time% > "%LOGFILE%"
echo. >> "%LOGFILE%"

:: Cleans user temporary files
echo [1/8] Cleaning user temporary files...
echo [1/8] User temporary files >> "%LOGFILE%"
del /q /f /s "%TEMP%\*" 2>nul
for /d %%p in ("%TEMP%\*") do rmdir "%%p" /s /q 2>nul
echo Completed. >> "%LOGFILE%"
echo.

:: Cleans Windows temporary files
echo [2/8] Cleaning Windows temporary files...
echo [2/8] Windows temporary files >> "%LOGFILE%"
del /q /f /s "C:\Windows\Temp\*" 2>nul
for /d %%p in ("C:\Windows\Temp\*") do rmdir "%%p" /s /q 2>nul
echo Completed. >> "%LOGFILE%"
echo.

:: Cleans Prefetch (with verification)
echo [3/8] Cleaning Prefetch files...
echo [3/8] Prefetch >> "%LOGFILE%"
if exist "C:\Windows\Prefetch\" (
    del /q /f /s "C:\Windows\Prefetch\*" 2>nul
    echo Completed. >> "%LOGFILE%"
) else (
    echo Prefetch folder not found. >> "%LOGFILE%"
)
echo.

:: Cleans DNS cache
echo [4/8] Cleaning DNS cache...
echo [4/8] DNS cache >> "%LOGFILE%"
ipconfig /flushdns >nul 2>&1
echo Completed. >> "%LOGFILE%"
echo.

:: Empties Recycle Bin
echo [5/8] Emptying Recycle Bin...
echo [5/8] Recycle Bin >> "%LOGFILE%"
PowerShell.exe -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo Completed. >> "%LOGFILE%"
echo.

:: Cleans old Windows log files
echo [6/8] Cleaning old Windows logs...
echo [6/8] Windows logs >> "%LOGFILE%"
del /q /f /s "C:\Windows\Logs\*" 2>nul
del /q /f /s "C:\Windows\Panther\*.log" 2>nul
echo Completed. >> "%LOGFILE%"
echo.

:: Cleans Windows Update cache
echo [7/8] Cleaning Windows Update cache...
echo [7/8] Windows Update cache >> "%LOGFILE%"
net stop wuauserv >nul 2>&1
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" 2>nul
net start wuauserv >nul 2>&1
echo Completed. >> "%LOGFILE%"
echo.

:: Runs Disk Cleanup
echo [8/8] Running Windows Disk Cleanup...
echo [8/8] Disk Cleanup >> "%LOGFILE%"
cleanmgr /sagerun:1
echo Completed. >> "%LOGFILE%"
echo.

:: Displays summary
echo ============================================
echo          CLEANUP COMPLETED!
echo ============================================
echo.
echo Log saved to: %LOGFILE%
echo.
echo Recommendations:
echo - Restart your computer to apply all changes
echo - Run this script periodically
echo.

echo Finished on %date% %time% >> "%LOGFILE%"

color 0A
timeout /t 10
exit /b 0