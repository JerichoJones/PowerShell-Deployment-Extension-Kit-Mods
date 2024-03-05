My modifications to the PowerShell Deployment Extension Kit created by the Friends of MDT.

View Raw to see the output without word wrapping.

Sample output from New-PSDDriverPackage_NoMDTScan.ps1 -RootDriverPath E:\IMG_Drivers\ -psDeploymentFolder E:\PSDDeploymentShare\ -DaysOld 90 -CompressionType WIMLIB

2024-03-04 19:37:08 Starting...
2024-03-04 19:37:08 Start logging
2024-03-04 19:37:08 Both wimlib-imagex.exe and libwim-15.dll are in the same folder as the executing script.
2024-03-04 19:37:08 Driver location is: E:\IMG_Drivers
2024-03-04 19:37:08 Get a list of drivers added within the last 90 days and copy to source folder

2024-03-04 19:37:08 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' ---
2024-03-04 19:37:08 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\WinPE X64' is 02/07/2024 10:18:10
2024-03-04 19:37:09 Processing Windows_10_x64-WinPE_X64 Drivers
2024-03-04 19:37:09 Creating archive using WIMLIB
2024-03-04 19:37:09 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
2024-03-04 19:37:09 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
2024-03-04 19:37:09 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64 for WIMLIB
2024-03-04 19:37:09 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64
2024-03-04 19:37:09 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64\Windows_10_x64-WinPE_X64.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\WinPE X64"
42 MiB scanned (106 files, 40 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-WinPE_X64".
Using LZMS compression with 1 thread
Archiving file data: 42 MiB of 42 MiB (100%) done

2024-03-04 19:37:29 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-WinPE_X64\Windows_10_x64-WinPE_X64.wim using wimlib-imagex
2024-03-04 19:37:30 Total Compression time: 00h:00m:20s

2024-03-04 19:37:30 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' ---
2024-03-04 19:37:30 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox' is 02/09/2024 10:14:38
2024-03-04 19:37:30 Processing Windows_10_x64-innotek_GmbH-VirtualBox Drivers
2024-03-04 19:37:30 Creating archive using WIMLIB
2024-03-04 19:37:30 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox
2024-03-04 19:37:30 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox
2024-03-04 19:37:30 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox for WIMLIB
2024-03-04 19:37:31 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox
2024-03-04 19:37:31 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox\Windows_10_x64-innotek_GmbH-VirtualBox.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\innotek GmbH\VirtualBox"
28 MiB scanned (43 files, 8 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-innotek_GmbH-VirtualBox".
Using LZMS compression with 1 thread
Archiving file data: 28 MiB of 28 MiB (100%) done

2024-03-04 19:37:44 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-innotek_GmbH-VirtualBox\Windows_10_x64-innotek_GmbH-VirtualBox.wim using wimlib-imagex
2024-03-04 19:37:44 Total Compression time: 00h:00m:13s

2024-03-04 19:37:44 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' ---
2024-03-04 19:37:44 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q' is 02/07/2024 10:16:34
2024-03-04 19:37:44 Processing Windows_10_x64-Lenovo-ThinkCentre_M90q Drivers
2024-03-04 19:37:44 Creating archive using WIMLIB
2024-03-04 19:37:45 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q
2024-03-04 19:37:45 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q
2024-03-04 19:37:45 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q for WIMLIB
2024-03-04 19:37:45 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q
2024-03-04 19:37:45 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q\Windows_10_x64-Lenovo-ThinkCentre_M90q.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkCentre M90q"
17 GiB scanned (6326 files, 939 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkCentre_M90q".
Using LZMS compression with 4 threads
Archiving file data: 16 GiB of 16 GiB (100%) done

2024-03-04 20:18:07 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkCentre_M90q\Windows_10_x64-Lenovo-ThinkCentre_M90q.wim using wimlib-imagex
2024-03-04 20:18:08 Total Compression time: 00h:40m:22s

2024-03-04 20:18:08 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' ---
2024-03-04 20:18:08 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4' is 02/28/2024 11:58:12
2024-03-04 20:18:08 Processing Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4 Drivers
2024-03-04 20:18:08 Creating archive using WIMLIB
2024-03-04 20:18:08 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 20:18:08 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 20:18:08 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4 for WIMLIB
2024-03-04 20:18:08 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4
2024-03-04 20:18:09 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T14 Gen 4"
6805 MiB scanned (3113 files, 349 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4".
Using LZMS compression with 4 threads
Archiving file data: 6706 MiB of 6706 MiB (100%) done

2024-03-04 20:35:10 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4\Windows_10_x64-Lenovo-ThinkPad_T14_Gen_4.wim using wimlib-imagex
2024-03-04 20:35:10 Total Compression time: 00h:17m:01s

2024-03-04 20:35:10 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' ---
2024-03-04 20:35:10 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2' is 02/23/2024 14:04:15
2024-03-04 20:35:10 Processing Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2 Drivers
2024-03-04 20:35:10 Creating archive using WIMLIB
2024-03-04 20:35:11 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2
2024-03-04 20:35:11 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2
2024-03-04 20:35:11 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2 for WIMLIB
2024-03-04 20:35:11 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2
2024-03-04 20:35:11 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkPad T16 Gen 2"
6805 MiB scanned (3113 files, 349 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2".
Using LZMS compression with 4 threads
Archiving file data: 6706 MiB of 6706 MiB (100%) done

2024-03-04 20:52:22 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2\Windows_10_x64-Lenovo-ThinkPad_T16_Gen_2.wim using wimlib-imagex
2024-03-04 20:52:22 Total Compression time: 00h:17m:11s

2024-03-04 20:52:23 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' ---
2024-03-04 20:52:23 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2' is 02/27/2024 14:16:55
2024-03-04 20:52:23 Processing Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2 Drivers
2024-03-04 20:52:23 Creating archive using WIMLIB
2024-03-04 20:52:23 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2 for WIMLIB
2024-03-04 20:52:23 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2
2024-03-04 20:52:23 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\Thinkpad Z16 Gen 2"
2466 MiB scanned (1309 files, 233 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2".
Using LZMS compression with 4 threads
Archiving file data: 2452 MiB of 2452 MiB (100%) done

2024-03-04 20:58:38 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2\Windows_10_x64-Lenovo-Thinkpad_Z16_Gen_2.wim using wimlib-imagex
2024-03-04 20:58:38 Total Compression time: 00h:06m:14s

2024-03-04 20:58:38 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' ---
2024-03-04 20:58:38 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra' is 02/23/2024 14:55:43
2024-03-04 20:58:38 Processing Windows_10_x64-Lenovo-ThinkStation_P3_Ultra Drivers
2024-03-04 20:58:38 Creating archive using WIMLIB
2024-03-04 20:58:38 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra
2024-03-04 20:58:39 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra
2024-03-04 20:58:39 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra for WIMLIB
2024-03-04 20:58:39 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra
2024-03-04 20:58:39 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P3 Ultra"
3622 MiB scanned (1141 files, 187 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkStation_P3_Ultra".
Using LZMS compression with 4 threads
Archiving file data: 3430 MiB of 3430 MiB (100%) done

2024-03-04 21:10:04 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra\Windows_10_x64-Lenovo-ThinkStation_P3_Ultra.wim using wimlib-imagex
2024-03-04 21:10:04 Total Compression time: 00h:11m:25s

2024-03-04 21:10:04 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' ---
2024-03-04 21:10:04 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5' is 02/23/2024 14:53:50
2024-03-04 21:10:05 Processing Windows_10_x64-Lenovo-ThinkStation_P5 Drivers
2024-03-04 21:10:05 Creating archive using WIMLIB
2024-03-04 21:10:05 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5
2024-03-04 21:10:05 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5
2024-03-04 21:10:05 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5 for WIMLIB
2024-03-04 21:10:05 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5
2024-03-04 21:10:05 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5\Windows_10_x64-Lenovo-ThinkStation_P5.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\Lenovo\ThinkStation P5"
4505 MiB scanned (1161 files, 203 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-Lenovo-ThinkStation_P5".
Using LZMS compression with 4 threads
Archiving file data: 4487 MiB of 4487 MiB (100%) done

2024-03-04 21:23:25 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-Lenovo-ThinkStation_P5\Windows_10_x64-Lenovo-ThinkStation_P5.wim using wimlib-imagex
2024-03-04 21:23:25 Total Compression time: 00h:13m:20s

2024-03-04 21:23:26 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware20,1' ---
2024-03-04 21:23:26 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware20,1' is 02/22/2024 11:14:40
2024-03-04 21:23:26 Processing Windows_10_x64-VMware,_Inc-VMware20,1 Drivers
2024-03-04 21:23:26 Creating archive using WIMLIB
2024-03-04 21:23:26 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1
2024-03-04 21:23:26 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1
2024-03-04 21:23:26 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1 for WIMLIB
2024-03-04 21:23:26 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1
2024-03-04 21:23:27 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1\Windows_10_x64-VMware__Inc-VMware20_1.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware20,1"
67 MiB scanned (96 files, 31 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-VMware,_Inc-VMware20,1".
Using LZMS compression with 4 threads
Archiving file data: 67 MiB of 67 MiB (100%) done

2024-03-04 21:24:00 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware20_1\Windows_10_x64-VMware__Inc-VMware20_1.wim using wimlib-imagex
2024-03-04 21:24:00 Total Compression time: 00h:00m:33s

2024-03-04 21:24:00 --- Verifying the creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware7,1' ---
2024-03-04 21:24:00 The creation date of the source folder 'E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware7,1' is 02/22/2024 11:14:14
2024-03-04 21:24:00 Processing Windows_10_x64-VMware,_Inc-VMware7,1 Drivers
2024-03-04 21:24:00 Creating archive using WIMLIB
2024-03-04 21:24:00 Trying to remove E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1
2024-03-04 21:24:01 Successfully removed E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1
2024-03-04 21:24:01 Creating E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1 for WIMLIB
2024-03-04 21:24:01 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1
2024-03-04 21:24:01 Creating WIM format archive at E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1\Windows_10_x64-VMware__Inc-VMware7_1.wim using wimlib-imagex

Scanning "E:\IMG_Drivers\Windows 10 x64\VMware, Inc\VMware7,1"
67 MiB scanned (96 files, 31 directories)
Setting the DESCRIPTION property of image 1 to "Windows_10_x64-VMware,_Inc-VMware7,1".
Using LZMS compression with 4 threads
Archiving file data: 67 MiB of 67 MiB (100%) done

2024-03-04 21:24:34 Successfully created E:\PSDDeploymentShare\PSDResources\DriverPackages\Windows_10_x64-VMware__Inc-VMware7_1\Windows_10_x64-VMware__Inc-VMware7_1.wim using wimlib-imagex
2024-03-04 21:24:34 Total Compression time: 00h:00m:33s

2024-03-04 21:24:34 Total execution time: 01h:47m:26s
2024-03-04 21:24:34 Process Complete
