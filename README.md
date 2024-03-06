

## My modifications to the PowerShell Deployment Extension Kit v2.2.8 created by the [Friends of MDT](https://github.com/FriendsOfMDT).

Changes are listed in the header of each script

View Raw to see the output without word wrapping.

Sample output from:
New-PSDDriverPackage_NoMDTScan.ps1 -RootDriverPath E:\IMG_Drivers\ -psDeploymentFolder E:\PSDDeploymentShare\ -DaysOld 2 -CompressionType WIMLIB

    2024-03-06 15:20:55 Starting...
    2024-03-06 15:20:55 Start logging
    2024-03-06 15:20:55 Both wimlib-imagex.exe and libwim-15.dll are in the same folder as the executing script.
    2024-03-06 15:20:55 Driver location is: E:\IMG_Drivers
    2024-03-06 15:20:55 Get a list of drivers added within the last 2 days and copy to source folder
    
    2024-03-06 15:20:55 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' ---
    2024-03-06 15:20:55 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' is 02/07/2024 10:18:10
    2024-03-06 15:20:55 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' as it is older than 2 days.
    
    
    2024-03-06 15:20:55 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' ---
    2024-03-06 15:20:56 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' is 02/09/2024 10:14:38
    2024-03-06 15:20:56 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' as it is older than 2 days.
    
    
    2024-03-06 15:20:56 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' ---
    2024-03-06 15:20:56 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' is 02/07/2024 10:16:34
    2024-03-06 15:20:56 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' as it is older than 2 days.
    
    
    2024-03-06 15:20:56 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' ---
    2024-03-06 15:20:56 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' is 02/28/2024 11:58:12
    2024-03-06 15:20:56 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' as it is older than 2 days.
    
    
    2024-03-06 15:20:57 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' ---
    2024-03-06 15:20:57 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' is 02/23/2024 14:04:15
    2024-03-06 15:20:57 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' as it is older than 2 days.
    
    
    2024-03-06 15:20:57 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' ---
    2024-03-06 15:20:57 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' is 02/27/2024 14:16:55
    2024-03-06 15:20:57 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' as it is older than 2 days.
    
    
    2024-03-06 15:20:57 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' ---
    2024-03-06 15:20:57 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' is 02/23/2024 14:55:43
    2024-03-06 15:20:58 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' as it is older than 2 days.
    
    
    2024-03-06 15:20:58 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' ---
    2024-03-06 15:20:58 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' is 02/23/2024 14:53:50
    2024-03-06 15:20:58 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' as it is older than 2 days.
    
    
    2024-03-06 15:20:58 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware20,1' ---
    2024-03-06 15:20:58 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware20,1' is 02/22/2024 11:14:40
    2024-03-06 15:20:58 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware20,1' as it is older than 2 days.
    
    
    2024-03-06 15:20:59 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware7,1' ---
    2024-03-06 15:20:59 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware7,1' is 03/05/2024 09:30:12
    2024-03-06 15:20:59 Processing Windows_10_x64-VMware,_Inc.-VMware7,1 Drivers
    2024-03-06 15:20:59 Creating archive using WIMLIB
    2024-03-06 15:20:59 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1
    2024-03-06 15:20:59 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1
    2024-03-06 15:20:59 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1 for WIMLIB
    2024-03-06 15:21:00 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1
    2024-03-06 15:21:00 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1\Windows_10_x64-VMware__Inc.-VMware7_1.wim using wimlib-imagex
    
    
    Scanning "E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware7,1"
    68 MiB scanned (102 files, 32 directories)
    Setting the DESCRIPTION property of image 1 to "Windows_10_x64-VMware,_Inc.-VMware7,1".
    Using LZMS compression with 4 threads
    Archiving file data: 68 MiB of 68 MiB (100%) done
    
    
    2024-03-06 15:21:33 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc.-VMware7_1\Windows_10_x64-VMware__Inc.-VMware7_1.wim using wimlib-imagex
    2024-03-06 15:21:33 Archive File Size: 15.36 MB
    2024-03-06 15:21:33 Total Compression time: 00h:00m:33s
    
    
    ------------------------------------------------------------
    2024-03-06 15:21:33 Total execution time: 00h:00m:38s
    2024-03-06 15:21:33 Process Complete
    ------------------------------------------------------------


> Written with [StackEdit](https://stackedit.io/).
