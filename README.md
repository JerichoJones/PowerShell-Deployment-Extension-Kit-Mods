

## My modifications to the PowerShell Deployment Extension Kit v2.2.8 created by the [Friends of MDT](https://github.com/FriendsOfMDT).

Feature/Changes are listed in the header of each script.

These scripts are mean't to be used as a group. Mixing and matching is on you.

View Raw to see the output without word wrapping.

Sample output from:
New-PSDDriverPackage_NoMDTScan.ps1 -RootDriverPath E:\IMG_Drivers\ -psDeploymentFolder E:\PSDDeploymentShare\ -CompressionType WIMLIB -DaysOld 1

    2024-03-26 10:16:17 Starting...
    2024-03-26 10:16:17 Start logging
    2024-03-26 10:16:18 Both wimlib-imagex.exe and libwim-15.dll found in system PATH.
    2024-03-26 10:16:18 Opening E:\PSDDeploymentShare\Tools\DriverPackModelsPaths.txt for parsing.
    2024-03-26 10:16:18 DriverPack List loaded successfully
    2024-03-26 10:16:18 Get a list of drivers added within the last 1 days and archive to DriverPacks folder
    
    2024-03-26 10:16:18 Driver location is: E:\IMG_Drivers
    2024-03-26 10:16:18 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' ---
    2024-03-26 10:16:18 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' is 03/25/2024 10:18:10
    2024-03-26 10:16:18 Processing Windows_10_x64-WinPE_X64 Drivers
    2024-03-26 10:16:19 Creating archive using WIMLIB
    2024-03-26 10:16:19 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
    2024-03-26 10:16:19 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
    2024-03-26 10:16:19 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64 for WIMLIB
    2024-03-26 10:16:19 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
    2024-03-26 10:16:23 Using 2 CPU cores for WIM compression
    2024-03-26 10:16:24 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64\Windows_10_x64-WinPE_X64.wim using wimlib-imagex
    
    Scanning "E:\IMG_Drivers\Windows 10 x64\WinPE X64"
    144 MiB scanned (412 files, 147 directories)
    Setting the DESCRIPTION property of image 1 to "Windows_10_x64-WinPE_X64".
    Using LZMS compression with 2 threads
    Archiving file data: 129 MiB of 129 MiB (100%) done
    
    2024-03-26 10:16:53 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64\Windows_10_x64-WinPE_X64.wim using wimlib-imagex
    2024-03-26 10:16:53 Archive File Size: 18.50 MB
    2024-03-26 10:16:53 Successfully connected to PSDShare01
    2024-03-26 10:16:54 Folder 'Windows 10 x64\WinPE X64' already exists in the MDT Out-of-Box Drivers section under PSDrive 'PSDShare01'.
    2024-03-26 10:16:55 Total Processing time: 00h:00m:35s
    
    2024-03-26 10:16:55 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' ---
    2024-03-26 10:16:55 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' is 02/09/2024 10:14:38
    2024-03-26 10:16:55 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' as it is older than 1 days.
    
    ------------------------------------------------------------
    2024-03-06 15:21:33 Total execution time: 00h:00m:38s
    2024-03-06 15:21:33 Process Complete
    ------------------------------------------------------------
> Written with [StackEdit](https://stackedit.io/).
