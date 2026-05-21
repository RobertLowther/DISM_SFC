# DISM + SFC Repair Script

This project contains a Windows batch script that helps run two built-in system repair tools in sequence:

- `DISM /Online /Cleanup-Image /RestoreHealth`
- `sfc /scannow`

The script is meant to simplify a common Windows repair workflow by checking for administrator privileges, showing a few pre-run reminders, launching `DISM`, then running `SFC`, and finally offering an optional second `SFC` scan.

## What the Script Does

The [`DISM+SFC-SCANS.bat`](./DISM+SFC-SCANS.bat) script:

1. Verifies that it is being run as an administrator.
2. Stops and warns the user if it is not elevated.
3. Prompts the user to disable antivirus, Malwarebytes, backup tools, and file sync apps before continuing.
4. Runs:

```bat
DISM.exe /Online /Cleanup-image /RestoreHealth
```

5. Runs:

```bat
sfc /scannow
```

6. Lets the user choose whether to run `SFC` a second time or exit.

## Why Use This

This script can be useful when troubleshooting Windows corruption, damaged system files, or update/component store issues. It combines two repair steps that are often run manually into one guided process.

## Requirements

- Windows
- Administrator privileges
- `DISM` and `sfc` available in the system PATH

These tools are built into modern versions of Windows.

## How to Use

1. Download or clone this repository.
2. Right-click `DISM+SFC-SCANS.bat`.
3. Select **Run as administrator**.
4. Follow the on-screen prompts.
5. Wait for `DISM` to complete.
6. Wait for `SFC` to complete.
7. Choose whether to run a second `SFC` scan.

## Notes

- The script does **not** self-elevate. If you run it without administrator privileges, it exits and tells you to restart it as admin.
- The script recommends temporarily disabling antivirus, Malwarebytes, backup tools, and file sync software before running repairs.

## Example Workflow

1. Open the script as administrator.
2. Disable any antivirus or sync software.
3. Let `DISM` repair the Windows image.
4. Let `SFC` check and repair system files.
5. Run `SFC` again if needed.

## Disclaimer

Use this script at your own risk. It only runs built-in Windows repair commands, but you should still review it before use and avoid interrupting the repair process once started.

## Repository Contents

- `DISM+SFC-SCANS.bat` - Main repair script
