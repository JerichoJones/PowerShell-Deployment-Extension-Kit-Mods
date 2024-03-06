My modifications to the PowerShell Deployment Extension Kit created by the Friends of MDT.
Changes are listed in the header of each script

View Raw to see the output without word wrapping.

Sample output from New-PSDDriverPackage_NoMDTScan.ps1 -RootDriverPath E:\IMG_Drivers\ -psDeploymentFolder E:\PSDDeploymentShare\ -DaysOld 7 -CompressionType WIMLIB

2024-03-04 21:40:16 Starting...
2024-03-04 21:40:16 Start logging
2024-03-04 21:40:16 Both wimlib-imagex.exe and libwim-15.dll are in the same folder as the executing script.
2024-03-04 21:40:16 Driver location is: E:\IMG_Drivers
2024-03-04 21:40:16 Get a list of drivers added within the last 7 days and copy to source folder

2024-03-04 21:40:16 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' ---
2024-03-04 21:40:16 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' is 02/07/2024 10:18:10
2024-03-04 21:40:16 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' as it is older than 7 days.


2024-03-04 21:40:16 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' ---
2024-03-04 21:40:17 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' is 02/09/2024 10:14:38
2024-03-04 21:40:17 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' as it is older than 7 days.


2024-03-04 21:40:17 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' ---
2024-03-04 21:40:17 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' is 02/07/2024 10:16:34
2024-03-04 21:40:17 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' as it is older than 7 days.


2024-03-04 21:40:17 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' ---
2024-03-04 21:40:17 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' is 02/28/2024 11:58:12
2024-03-04 21:40:17 Processing Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4 Drivers
2024-03-04 21:40:18 Creating archive using WIMLIB
2024-03-04 21:40:18 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 21:40:18 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 21:40:18 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4 for WIMLIB
2024-03-04 21:40:18 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 21:40:18 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4.wim using wimlib-imagex


Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4"
6805 MiB scanned (3113 files, 349 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4".
Using LZMS compression with 4 threads
Archiving file data: 6706 MiB of 6706 MiB (100%) done


2024-03-04 21:57:50 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4.wim using wimlib-imagex
2024-03-04 21:57:50 Total Compression time: 00h:17m:32s


2024-03-04 21:57:50 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' ---
2024-03-04 21:57:51 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' is 02/23/2024 14:04:15
2024-03-04 21:57:51 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' as it is older than 7 days.


2024-03-04 21:57:51 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' ---
2024-03-04 21:57:51 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' is 02/27/2024 14:16:55
2024-03-04 21:57:51 Processing Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2 Drivers
2024-03-04 21:57:51 Creating archive using WIMLIB
2024-03-04 21:57:51 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2
2024-03-04 21:57:52 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2
2024-03-04 21:57:52 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2 for WIMLIB
2024-03-04 21:57:52 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2
2024-03-04 21:57:52 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2.wim using wimlib-imagex


Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2"
2466 MiB scanned (1309 files, 233 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2".
Using LZMS compression with 4 threads
Archiving file data: 2452 MiB of 2452 MiB (100%) done


2024-03-04 22:04:24 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2.wim using wimlib-imagex
2024-03-04 22:04:24 Total Compression time: 00h:06m:31s


2024-03-04 22:04:24 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' ---
2024-03-04 22:04:24 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' is 02/23/2024 14:55:43
2024-03-04 22:04:24 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' as it is older than 7 days.


2024-03-04 22:04:24 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' ---
2024-03-04 22:04:24 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' is 02/23/2024 14:53:50
2024-03-04 22:04:24 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' as it is older than 7 days.


2024-03-04 22:04:25 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware20,1' ---
2024-03-04 22:04:25 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware20,1' is 02/22/2024 11:14:40
2024-03-04 22:04:25 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware20,1' as it is older than 7 days.


2024-03-04 22:04:25 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware7,1' ---
2024-03-04 22:04:25 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware7,1' is 02/22/2024 11:14:14
2024-03-04 22:04:25 Skipping folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc.\VMware7,1' as it is older than 7 days.


2024-03-04 22:04:25 Total execution time: 00h:24m:09s
2024-03-04 22:04:25 Process Complete
