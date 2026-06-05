# Windows Cleanup

A batch script for cleaning up temporary files and optimizing Windows system performance.

## Features

The script performs 8 cleanup operations in sequence and writes a timestamped log file to your Desktop:

1. **User temp files** — deletes `%TEMP%` contents
2. **Windows temp files** — deletes `C:\Windows\Temp` contents
3. **Prefetch files** — clears `C:\Windows\Prefetch`
4. **DNS cache** — runs `ipconfig /flushdns`
5. **Recycle Bin** — empties all drives via PowerShell `Clear-RecycleBin`
6. **Windows logs** — removes files from `C:\Windows\Logs` and `C:\Windows\Panther\*.log`
7. **Windows Update cache** — stops the `wuauserv` service, deletes `SoftwareDistribution\Download`, then restarts the service
8. **Disk Cleanup** — runs `cleanmgr /sagerun:1`

A log file is saved to `%USERPROFILE%\Desktop\cleanup_log_<YYYYMMDD_HHMM>.txt` on each run.

## Usage

1. Clone or download this repository.
2. Run `windows-cleanup.bat` with Administrator privileges.
3. The script runs automatically with no interactive prompts.
4. Review the log file on your Desktop when finished.

## Requirements

- Windows OS
- Administrator access (required for temp file deletion, stopping Windows Update service, and disk cleanup)

## Warning

This script deletes files permanently. Review the script before running to understand what will be removed.