<#
.Synopsis
    This script creates driver packages from drivers to be imported in PSD. Drivers do not need to be imported into MDT as they are created from the file system.
    
.Description
    This script was written by Johan Arwidmark @jarwidmark and Mikael Nystrom @mikael_nystrom. This script is for the friends of MDT deployment tools 
    and is responsible for creating a self-signed certificate.

.LINK
    https://github.com/FriendsOfMDT/PSD

.NOTES
          FileName: New-PSDDriverPackage.ps1
          Solution: PowerShell Deployment for MDT
          Author: PSD Development Team
          Contact: @Mikael_Nystrom , @jarwidmark
          Primary: @Mikael_Nystrom 
          Created: 2019-05-09
          Modified: 2022-09-25

          Version - 0.0.0 - () - Finalized functional version 1
          Version - 0.0.1 - () - Added support for WIM compression, and improved error handling

          Changes by: Jericho Jones
          Version - 0.0.2 - () - Added support for creating driverpacks based on age of driver source folders. I use the CREATION date.
                                 If you add drivers to an existing folder it will most likely NOT BE DETECTED.
                                 Create a New folder and copy everything into that.
	  Version - 0.0.3 - () - Resolved issue where all driverpack folders were being deleted regardless of DaysOld
								 Added output to console so we can see what is happening
          Version - 0.0.4 - () - Added timestamps to the output to console
                                 No longer uses the MDT driver store to determine drivers per model, recreate the folder structure under
								 RootDriverPath to match the DriverPath in your Task Sequence!
                                 You must define the $SourceFolderNames with the driver folder structure:
                                 EXAMPLE:
                                 $SourceFolderNames = @("Windows 10 x64\WinPE X64",
                                    "Windows 10 x64\innotek GmbH\VirtualBox",
                                    "Windows 10 x64\LENOVO\ThinkCentre M90q",
                                    "Windows 10 x64\LENOVO\ThinkPad T14 Gen 4",
                                    "Windows 10 x64\LENOVO\ThinkPad T16 Gen 2",
                                    "Windows 10 x64\LENOVO\Thinkpad Z16 Gen 2",
                                    "Windows 10 x64\LENOVO\ThinkStation P3 Ultra",
                                    "Windows 10 x64\LENOVO\ThinkStation P5",
                                    "Windows 10 x64\VMware, Inc\VMware20,1",
                                    "Windows 10 x64\VMware, Inc\VMware7,1"
                                 )

                                 Since the Windows filesystem does not support trailing periods for our DriverSource we have to add a period after VMware, Inc to match the BIOS Model/ModelAlias
                                 when we create the driverpacks.

                                 So in the usage example below your driver source folder structure should look like:
                                    E:\Drivers\Windows 10 x64\VMware, Inc\VMware20,1

                                 and the DriverPath in your Task Sequence like:
	                 			    Windows 10 x64\%make%\%modelalias%

                                 NOTE: I use MODELALIAS because Lenovo chooses to be "different"
 
                                 I gave up on the MDT DriverStore because determining the date the drivers were added was beyond my ability (or motivation).
                                 Also the way MDT manages drivers seems to be broken. When you delete them from the console, they still seem to live in the file system.
                                 Added support to create WIMs using the PS cmdlet, wimlib-imagex and DISM (pick your poison).
                                 wimlib-imagex.exe and libwim-15.dll must be either in the folder next to the script or in the PATH
                                 I get the smallest WIMs using wimlib but it does take a long time (and uses ALL the cores) the way it is currently configured. Fixed in v0.0.8 - uses half the cores
                                 No longer copies drivers to $psDeploymentFolder\PSDResources\DriverSources, archives them directly from RootDriverPath
                                 No longer creates archive and then moves it into position. It archives directly to the destination. It was a design choice.
          Version - 0.0.5 - () - Now outputs size of created archive
          Version - 0.0.6 - () - Moved the DriverPack paths into a text file so we don't have to edit the script to add new models.
                                 Add the $SourceFolderNames to the DriverPackModelsPaths.txt, one path per line next to the script.
                                 Please avoid blank lines.
                                 Example:
                                            Windows 10 x64\WinPE X64
                                            Windows 10 x64\innotek GmbH\VirtualBox
                                            Windows 10 x64\LENOVO\ThinkCentre M90q
                                            Windows 10 x64\VMware Inc\VMware7,1
          Version - 0.0.7 - () - Skip blank lines in DriverPackModelsPaths.txt or we could enter a recursive loop
                                 Modified Set-PSDDefaultLogPath to prepend the logname with a timestamp
          Version - 0.0.8 - () - Determine number of available CPU cores and use half for wimlib-imagex
          Version - 0.0.9 - () - Shows a proper message and logs if a driver folder is not found
          Version - 0.1.0 - () - We now attempt to create the folder structure under PSD Out-of-Box Drivers as seen in the console
                                 Creates empty DriverPackModelsPaths.txt if not found
                                 A single DriversFolder can now be passed on the commandline via -DriversFolder. The path is verified, exits with error if not found. The $DriversFolder is added to DriverPackModelsPaths.txt if not found in the file.
                                 When -DriversFolder is passed -DaysOld is ignored if passed as well (avoid using both).
                                 Now validates that $DaysOld is greater than zero

.EXAMPLE
	.\New-PSDDriverPackage.ps1 -RootDriverPath E:\Drivers -psDeploymentFolder E:\PSDProduction -CompressionType WIMPS -DaysOld 1
	.\New-PSDDriverPackage.ps1 -RootDriverPath E:\Drivers -psDeploymentFolder E:\PSDProduction -CompressionType ZIP -DaysOld 1
    .\New-PSDDriverPackage.ps1 -RootDriverPath E:\Drivers -psDeploymentFolder E:\PSDProduction -CompressionType WIMLIB -DriversFolder "Windows 10 x64\WinPE X64"
#>

#Requires -RunAsAdministrator

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$RootDriverPath,

    [Parameter(Mandatory=$true)]
    [string]$psDeploymentFolder,

    [ValidateSet("ZIP", "WIMPS", "WIMLIB", "WIMDISM")]
    [string]$CompressionType = "WIMPS", # Default to PS WIM cmdlet if not specified

    [ValidateRange(1, [int]::MaxValue)]
    [int]$DaysOld = 30,  # Default to 30 days if not specified. Must be greater than 0.

    [string]$DriversFolder # Drivers folder to be added. -DaysOld is ignored if passed. ex. "Windows 10 x64\WinPE X64"
)

$RootDriverPath = $RootDriverPath.TrimEnd("\")
$psDeploymentFolder = $psDeploymentFolder.TrimEnd("\")

function Start-PSDLog{
	[CmdletBinding()]
    param (
    #[ValidateScript({ Split-Path $_ -Parent | Test-Path })]
	[string]$FilePath
 	)
    try
    	{
			if(!(Split-Path $FilePath -Parent | Test-Path))
			{
				New-Item (Split-Path $FilePath -Parent) -Type Directory | Out-Null
			}
			#Confirm the provided destination for logging exists if it doesn't then create it.
			if (!(Test-Path $FilePath)){
	    			## Create the log file destination if it doesn't exist.
                    New-Item $FilePath -Type File | Out-Null
			}
            else{
                Remove-Item -Path $FilePath -Force
            }
				## Set the global variable to be used as the FilePath for all subsequent write-PSDInstallLog
				## calls in this session
				$global:ScriptLogFilePath = $FilePath
    	}
    catch
    {
		#In event of an error write an exception
        Write-Error $_.Exception.Message
    }
}
function Write-PSDInstallLog{
	param (
    [Parameter(Mandatory = $true)]
    [string]$Message,
    [Parameter()]
    [ValidateSet(1, 2, 3)]
	[string]$LogLevel=1,
	[Parameter(Mandatory = $false)]
    [bool]$writetoscreen = $true   
   )
    $TimeGenerated = "$(Get-Date -Format HH:mm:ss).$((Get-Date).Millisecond)+000"
    $Line = '<![LOG[{0}]LOG]!><time="{1}" date="{2}" component="{3}" context="" type="{4}" thread="" file="">'
    $LineFormat = $Message, $TimeGenerated, (Get-Date -Format MM-dd-yyyy), "$($MyInvocation.ScriptName | Split-Path -Leaf):$($MyInvocation.ScriptLineNumber)", $LogLevel
	$Line = $Line -f $LineFormat
	[system.GC]::Collect()
    Add-Content -Value $Line -Path $global:ScriptLogFilePath
	if($writetoscreen)
	{
        switch ($LogLevel)
        {
            '1'{
                Write-Verbose -Message $Message
                }
            '2'{
                Write-Warning -Message $Message
                }
            '3'{
                Write-Error -Message $Message
                }
            Default {
            }
        }
    }
	if($writetolistbox -eq $true)
	{
        $result1.Items.Add("$Message")
    }
}
function set-PSDDefaultLogPath{
	#Function to set the default log path if something is put in the field then it is sent somewhere else. 
	[CmdletBinding()]
	param
	(
		[parameter(Mandatory = $false)]
		[bool]$defaultLogLocation = $true,
		[parameter(Mandatory = $false)]
		[string]$LogLocation
	)
	if($defaultLogLocation)
	{
		$LogPath = Split-Path $script:MyInvocation.MyCommand.Path
		$LogFile = "$(Get-Date -Format "yyyy-MM-dd_HH-mm-ss")_$($($script:MyInvocation.MyCommand.Name).Substring(0,$($script:MyInvocation.MyCommand.Name).Length-4)).log"
		Start-PSDLog -FilePath $($LogPath + "\" + $LogFile)
	}
	else 
	{
		$LogPath = $LogLocation
		$LogFile = "$(Get-Date -Format "yyyy-MM-dd_HH-mm-ss")_$($($script:MyInvocation.MyCommand.Name).Substring(0,$($script:MyInvocation.MyCommand.Name).Length-4)).log"
		Start-PSDLog -FilePath $($LogPath + "\" + $LogFile)
	}
}
function Copy-PSDFolder{
    param (
        [Parameter(Mandatory=$True,Position=1)]
        [string] $source,
        [Parameter(Mandatory=$True,Position=2)]
        [string] $destination
    )

    $s = $source.TrimEnd("\")
    $d = $destination.TrimEnd("\")
    Write-Verbose "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Copying folder $source to $destination using XCopy"
    & xcopy $s $d /s /e /v /y /i | Out-Null
}

function Get-AdjustedCores {
    # Aggregate the total number of cores across all processors
    $totalCores = (Get-WmiObject -Class Win32_Processor | Measure-Object -Property NumberOfCores -Sum).Sum
    
    # Divide the total number of cores by 2
    $halfCores = $totalCores / 2
    
    # If the original number of cores is odd, use Ceiling to round up
    if ($totalCores % 2 -ne 0) {
        $adjustedCores = [math]::Ceiling($halfCores)
    } else {
        $adjustedCores = $halfCores
    }
    
    # Return the adjusted number of cores
    return $adjustedCores
}

# Function to add a folder to the Out-of-Box Drivers (OOBD) section in a Microsoft Deployment Toolkit (MDT) deployment share
function Add-DrvrFldrToOOBDPath {
    param (
        [Parameter(Mandatory = $false)]
        [string]$PSDriveName = "ZZ001",
        
        [Parameter(Mandatory = $true)]
        [string]$DeploymentSharePath,

        [Parameter(Mandatory = $true)]
        [string]$FolderPath
    )

    if ($FolderPath -match "VMware, Inc") {
        try {
            # Perform the replacement
            $ModifiedFolderPath = $FolderPath.Replace("Inc", "Inc.")
    
            # Logging before the actual modification to show intent
            Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') VMware: modifying $FolderPath to '$ModifiedFolderPath'"
            Write-PSDInstallLog -Message "VMware: modifying $FolderPath to '$ModifiedFolderPath'"
    
            # Assign the modified path back to $FolderPath
            $FolderPath = $ModifiedFolderPath
    
            # Confirm modification
            Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') VMware FolderPath modified successfully"
            Write-PSDInstallLog -Message "VMware FolderPath modified successfully"
        } catch {
            Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Failed to modify VMware FolderPath"
            Write-PSDInstallLog -Message "Failed to modify VMware FolderPath"
            exit 1
        }
    }
    
    try {
        # Attempt to load the MDT PowerShell snap-in
        if (-not (Get-PSSnapin -Name Microsoft.BDD.PSSnapIn -ErrorAction SilentlyContinue)) {
            Add-PSSnapin Microsoft.BDD.PSSnapIn -ErrorAction Stop
        }

        # Import the MDT PowerShell module
        $mdtModulePath = "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
        if (Test-Path $mdtModulePath) {
            Import-Module $mdtModulePath -ErrorAction SilentlyContinue
        } else {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") MDT PowerShell module not found at path: $mdtModulePath"
            Write-PSDInstallLog -Message "MDT PowerShell module not found at path: $mdtModulePath"
        }

        # Check if the PSDrive is connected
        $driveExists = $false
        $ds = Get-PSDrive -Name $PSDriveName -PSProvider "MDTProvider" -ErrorAction SilentlyContinue
        if ($null -eq $ds) {
            New-PSDrive -Name $PSDriveName -PSProvider MDTProvider -Root $DeploymentSharePath -ErrorAction Stop | Out-Null
            $driveExists = $true
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully connected to $PSDriveName"
            Write-PSDInstallLog -Message "Successfully connected to $PSDriveName"
        }
        else{
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to connect to $PSDriveName. Folder will have to be manually added to PSD. Error: $_"
            Write-PSDInstallLog -Message "Failed to connect to $PSDriveName. Folder will have to be manually added to PSD. Error: $_"
            break
        }

        # Construct the full path for the new folder within the OOBD section
        $oobdPath = "${PSDriveName}:\Out-of-Box Drivers\$FolderPath"

        # Check if the folder already exists
        if (Test-Path $oobdPath) {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Folder '$FolderPath' already exists in the MDT Out-of-Box Drivers section under PSDrive '$PSDriveName'."
            Write-PSDInstallLog -Message "Folder '$FolderPath' already exists in the MDT Out-of-Box Drivers section under PSDrive '$PSDriveName'."
        } else {
            # If the folder does not exist, create the new folder
            New-Item -Path $oobdPath -Type Folder -ErrorAction Stop |Out-Null
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Folder '$FolderPath' added to the MDT Out-of-Box Drivers section under PSDrive '$PSDriveName'."
            Write-PSDInstallLog -Message "Folder '$FolderPath' added to the MDT Out-of-Box Drivers section under PSDrive '$PSDriveName'."
        }
    } catch {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") An error occurred: $_"
        Write-PSDInstallLog -Message "An error occurred: $_"
    } finally {
        if ($driveExists) {
            Remove-PSDrive -Name $PSDriveName
        }
    }
}

# End Functions
Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Starting..."
# Start the stopwatch
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

# Set VerboseForegroundColor
$host.PrivateData.VerboseForegroundColor = 'Cyan'

# Get the directory of the current script
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Get the filename of the current script
$scriptName = $MyInvocation.MyCommand.Name

# Start logging
Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Start logging"
set-PSDDefaultLogPath

if($psDeploymentFolder -eq "NA"){
	Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") You need to specify a psDeploymentFolder"
    Write-PSDInstallLog -Message "You need to specify a psDeploymentFolder" -LogLevel 2
    $Fail = $True
}

if((Test-Path -Path $psDeploymentFolder ) -eq $false){
	Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Unable to access $psDeploymentFolder, exiting"
    Write-PSDInstallLog -Message "Unable to access $psDeploymentFolder, exiting" -LogLevel 2
    $Fail = $True
}

# Paths to wimlib-imagex.exe and libwim-15.dll based on the current script's directory
$wimlibPath = Join-Path -Path $scriptPath -ChildPath "wimlib-imagex.exe"
$libwimPath = Join-Path -Path $scriptPath -ChildPath "libwim-15.dll"

If ($CompressionType -eq "WIMLIB"){
    # Check if both files exist at the specified paths
    if ((Test-Path -Path $wimlibPath) -and (Test-Path -Path $libwimPath)) {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Both wimlib-imagex.exe and libwim-15.dll are in the same folder as the executing script."
        Write-PSDInstallLog -Message "Both wimlib-imagex.exe and libwim-15.dll are in the same folder as the executing script."
    } else {
        # If not found in the script directory, check the system PATH
        try {
            $wimlibExePath = Get-Command wimlib-imagex.exe -ErrorAction Stop
            $libwimDllPath = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($wimlibExePath.Source), "libwim-15.dll")
            
            if (Test-Path -Path $libwimDllPath) {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Both wimlib-imagex.exe and libwim-15.dll found in system PATH."
                Write-PSDInstallLog -Message "Both wimlib-imagex.exe and libwim-15.dll found in system PATH."
            } else {
                Throw "libwim-15.dll not found in PATH."
            }
            $wimlibPath = $wimlibExePath.Source
        } catch {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") One or both of the files (wimlib-imagex.exe, libwim-15.dll) are not found in the same folder as the executing script."
            Write-PSDInstallLog -Message "One or both of the files (wimlib-imagex.exe, libwim-15.dll) are not found in the same folder as the executing script." -LogLevel 2
            $Fail = $True
        }
    }
}

# Opening $scriptPath\DriverPackModelsPaths.txt for parsing.
Try {
    Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Opening $scriptPath\DriverPackModelsPaths.txt for parsing."
    Write-PSDInstallLog -Message "Opening $scriptPath\DriverPackModelsPaths.txt for parsing."
    If(!(Test-Path "$scriptPath\DriverPackModelsPaths.txt"))
    {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $scriptPath\DriverPackModelsPaths.txt not found. Creating..."
        Write-PSDInstallLog -Message "$scriptPath\DriverPackModelsPaths.txt not found. Creating..."
        try{
            New-Item -Path "$scriptPath\DriverPackModelsPaths.txt" -ItemType File -ErrorAction Stop | Out-Null
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $scriptPath\DriverPackModelsPaths.txt created."
            Write-PSDInstallLog -Message "$scriptPath\DriverPackModelsPaths.txt created."
        }
        catch {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $scriptPath\DriverPackModelsPaths.txt, error: $_`. Exiting..."
            Write-PSDInstallLog -Message "Failed to create $scriptPath\DriverPackModelsPaths.txt, error: $_`. Exiting..."
            exit 1
        }

    }
    $SourceFolderNames = Get-Content "$scriptPath\DriverPackModelsPaths.txt" -ErrorAction Stop
    Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") DriverPack List loaded successfully"
    Write-PSDInstallLog -Message "DriverPack List loaded successfully"
}
catch {
    Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to load DriverPack List."
    Write-PSDInstallLog -Message "Failed to load DriverPack List."
    $Fail = $True
}

if($Fail -eq $True){
	Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Exiting"
    Write-PSDInstallLog -Message "Exiting"
    Exit
}

If($DriversFolder){
    If(Test-Path "$RootDriverPath\$DriversFolder"){
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $DriversFolder exists"
        Write-PSDInstallLog -Message "$DriversFolder exists"
        $SourceFolderNames = $DriversFolder
    }
    else {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $DriversFolder does NOT exist"
        Write-PSDInstallLog -Message "$DriversFolder does NOT exist"
        exit 1
    }

    #$TestDriversFolder = $DriversFolder
    #Write-Output "TestDriversFolder: $TestDriversFolder"
    # pause
    $filePath = "$scriptPath\DriverPackModelsPaths.txt"
    # Using -Raw, yo get the entire file content as a single string. This allows -match to work correctly for searching the whole content without splitting it into lines.
    $fileContent = Get-Content -Path $filePath -Raw    
    If($fileContent -match [regex]::Escape($DriversFolder)){
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $DriversFolder found in SourceFolderNames"
        Write-PSDInstallLog -Message "$DriversFolder found in $SourceFolderNames"
    }
    else
    {
        try{
            
            #$driversFolderContent = $DriversFolder  # The data you want to append

            # Determine if a newline should be prepended
            # File is not empty; check if the last line is not empty
            $lastLine = $fileContent | Select-Object -Last 1
            if (-not [string]::IsNullOrWhiteSpace($lastLine)) {
                $contentToAdd = "`r`n" + $driversFolder
            } else {
                $contentToAdd = $driversFolder
            }
            # Use .NET method to append the text exactly as prepared
            [System.IO.File]::AppendAllText($filePath, $contentToAdd)
            
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Added $DriversFolder to $scriptPath\DriverPackModelsPaths.txt"
            Write-PSDInstallLog -Message "$DriversFolder Added $DriversFolder to $scriptPath\DriverPackModelsPaths.txt"
        }
        catch{
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to add $DriversFolder to $scriptPath\DriverPackModelsPaths.txt"
            Write-PSDInstallLog -Message "$DriversFolder Failed to add $DriversFolder to $scriptPath\DriverPackModelsPaths.txt"
            exit 1
        }
    }
}
else {
    # Get a list of drivers to be processed
    Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Get a list of drivers added within the last $DaysOld days and archive to DriverPacks folder`n"
    Write-PSDInstallLog -Message "Get a list of drivers to be processed and copy to source folder"
    $foldersToProcess = $false
}

$DriverPackagesFolder = $psDeploymentFolder + "\PSDResources\DriverPackages"
If(!(Test-Path $DriverPackagesFolder))
{
	try
	{
		Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating $DriverPackagesFolder"
		Write-PSDInstallLog -Message "Creating $DriverPackagesFolder"
		New-Item -Path $DriverPackagesFolder -ItemType Directory -Force -ErrorAction Stop | Out-Null
		Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DriverPackagesFolder"
		Write-PSDInstallLog -Message "Successfully created $DriverPackagesFolder"
	} catch {
		Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DriverPackagesFolder error: $_`, troubleshoot and run the script again"
		Write-PSDInstallLog -Message "Failed to create $DriverPackagesFolder error: $_`, troubleshoot and run the script again" -LogLevel 2
	}
}

Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Driver location is: $RootDriverPath"
Write-PSDInstallLog -Message "Driver location is: $RootDriverPath"

# Set if DriversFolder is not passed on commandline
If(-not $DriversFolder){
    $cmdline = $false
}
else{
    $cmdline = $true
}
$ProcessedFolderNames = @{}
foreach($SourceFolderName in $SourceFolderNames){
    # Skip blank lines in DriverPackModelsPaths.txt or we will enter a recursive loop
    if ([string]::IsNullOrEmpty($SourceFolderName)) {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") *** Blank Line in DriverPackModelsPaths.txt... Skipping ***"
        Write-PSDInstallLog -Message "*** Blank Line in DriverPackModelsPaths.txt ***... Skipping" -LogLevel 1
        continue
    }

    # Set the filesystem path
    $filepathSourceFolderName = $SourceFolderName

    # Set to be passed to Add-DrvrFldrToOOBDPath if not passed on commandline
    If(-not $cmdline){
        $DriversFolder = $SourceFolderName
    }

    # The Windows filesystem does not support trailing periods
    # We have to add a period after VMware, Inc
    # Perform a case-insensitive replace
    # The regex (?i) makes the match case-insensitive
    # The \b ensures we're at a word boundary, so we don't add a period in the middle of a word
    if ($SourceFolderName -match "(?i)\\VMware, Inc\\") {
        $SourceFolderName = $SourceFolderName -replace '(?i)(\\VMware, Inc)(\\)', '${1}.${2}'
    }

    $filesystemSourceFolderPath = "$RootDriverPath\$filepathSourceFolderName"
    $SourceFolderPath = "$RootDriverPath\$SourceFolderName"
    If(-not $cmdline){
        # Check the creation date of the source folder
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") --- Verifying the creation date of the source folder `'$SourceFolderPath`' ---"
        Write-PSDInstallLog -Message "Verifying the creation date of the source folder `'$SourceFolderPath`'" -LogLevel 1
        If(Test-Path $SourceFolderPath){
            $CreationDate = (Get-Item $SourceFolderPath).CreationTime
        }
        else{
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") --- `'$SourceFolderPath`' not found... continuing ---"
            Write-Output "`n"
            Write-PSDInstallLog -Message "`'$SourceFolderPath`' not found... continuing ---" -LogLevel 1
            continue
        }
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") The creation date of the source folder `'$SourceFolderPath`' is $CreationDate"
        Write-PSDInstallLog -Message "The creation date of the source folder `'$SourceFolderPath`' is $CreationDate" -LogLevel 1
        $DateLimit = (Get-Date).AddDays(-$DaysOld)

        # Skip the folder if it's older than the specified number of days
        if($CreationDate -lt $DateLimit) {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Skipping folder `'$SourceFolderPath`' as it is older than $DaysOld days."
            Write-Output "`n"
            Write-PSDInstallLog -Message "Skipping folder `'$SourceFolderPath`' as it is older than $DaysOld days." -LogLevel 1
            continue
        }
    }

    # Determine destination folder
    $RemoveMe = "$RootDriverPath\"
    $DestinationFolderName = ($SourceFolderPath).Replace("$RemoveMe","").Replace("\","-").Replace(" ","_")

    if ($ProcessedFolderNames.ContainsKey($DestinationFolderName)) {
        If($ProcessedFolderNames[$DestinationFolderName] -eq $true){
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Skipping folder `'$DestinationFolderName`' as it has been processed."
            Write-PSDInstallLog -Message "Skipping folder `'$DestinationFolderName`' as it has been processed." -LogLevel 1
            continue
        }
    }

    # Check if this destination folder name has not been processed before
    if (-not $ProcessedFolderNames.ContainsKey($DestinationFolderName)) {
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Processing $DestinationFolderName Drivers"
        Write-PSDInstallLog -Message "Processing $DestinationFolderName"
        # Add the destination folder name to the hashtable to mark it as processed
        $ProcessedFolderNames[$DestinationFolderName] = $true
    
        # Set default compresion type to WIM if not specified on the command line
        If ([string]::IsNullOrEmpty($CompressionType)){
            $CompressionType = "WIMPS"
        }

        # Creating the drivers packages. 
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating archive using $CompressionType"
        Write-PSDInstallLog -Message "Creating archives using $CompressionType"
        If($CompressionType -match "WIM"){
            $ArchiveExtension = "WIM"
        }
        else {
            $ArchiveExtension = "ZIP"
        }
        $FileName = ($DestinationFolderName).replace(" ","_").replace(",","_") + ".$($ArchiveExtension.ToLower())"
        $DestinationFolderPath = $psDeploymentFolder + "\PSDResources\DriverPackages"
        $DestinationDriverFolder = $($DestinationFolderPath) + "\" + $($DestinationFolderName).replace(" ","_").replace(",","_")
        $DestFile = $DestinationDriverFolder + "\" + $FileName
        
        If(Test-Path $DestinationDriverFolder){
            try
            {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Trying to remove $DestinationDriverFolder"
                Write-PSDInstallLog -Message "Trying to remove $DestinationDriverFolder"
                Remove-Item -Path $DestinationDriverFolder -Recurse -ErrorAction Stop | Out-Null
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully removed $DestinationDriverFolder"
                Write-PSDInstallLog -Message "Successfully removed $DestinationDriverFolder"
            } catch {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") $DestinationDriverFolder folder cleanup failed error: $_`nPlease do a manual cleanup of $DestinationFolderPath`, and run the script again"
                Write-PSDInstallLog -Message "$DestinationDriverFolder folder cleanup failed. Please do a manual cleanup of $DestinationFolderPath`, and run the script again" -LogLevel 2
            }
        }

        try
        {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating $($DestinationDriverFolder) for $CompressionType"
            Write-PSDInstallLog -Message "Creating $($DestinationDriverFolder) for $CompressionType"
            New-Item -Path $DestinationDriverFolder -ItemType Directory -Force -ErrorAction Stop | Out-Null
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DestinationDriverFolder"
            Write-PSDInstallLog -Message "Successfully created $DestinationDriverFolder"
        } catch {
            Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DestinationDriverFolder error: $_`n Correct the error and try again."
            Write-PSDInstallLog -Message "Failed to create $DestinationDriverFolder error: $_" -LogLevel 2
        }

        # Start the stopwatch
        $stopwatchCompression = [System.Diagnostics.Stopwatch]::StartNew()
        If ($CompressionType -eq "WIMPS"){
            try {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating WIM format archive at $DestFile using PS cmdlet"
                New-WindowsImage -CapturePath $filesystemSourceFolderPath -ImagePath $DestFile -Name "Driver Package" | Out-Null
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DestFile using PS cmdlet"
                # Retrieve and format the file size
                $fileInfo = Get-Item $DestFile
                $fileSizeMB = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
                Write-PSDInstallLog -Message "Successfully created $DestFile using wimlib-imagex"
                Write-PSDInstallLog -Message "Archive File Size: $fileSizeMB"
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Archive File Size: $fileSizeMB"
            } catch {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DestFile using PS cmdlet. Error: $_"
                Write-PSDInstallLog -Message "Failed to create $DestFile using PS cmdlet. Error: $_" -LogLevel 3
            }
        }
        ElseIf ($CompressionType -eq "WIMLIB"){
            try {
                # Determine number of available CPU cores and use half for wimlib-imagex
                $cores = Get-AdjustedCores

                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Using $cores CPU cores for WIM compression"
                Write-PSDInstallLog -Message "Using $cores CPU cores for WIM compression"
                # Create WIM format archive using wimlib-imagex
                $wimlibArguments = "capture `"$filesystemSourceFolderPath`" `"$DestFile`" --solid --solid-compress=LZMS:100 --no-acls --threads=$cores `"Driver Package`" `"$DestinationFolderName`""

                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating WIM format archive at $DestFile using wimlib-imagex"
                Write-Output "`n"
                # Invoke wimlib-imagex
                $process = Start-Process -FilePath $wimlibPath -ArgumentList $wimlibArguments -Wait -PassThru -NoNewWindow

                # Check wimlib-imagex exit code
                if ($process.ExitCode -ne 0) {
                    throw "wimlib-imagex failed with exit code $($process.ExitCode)"
                }
                Write-Output "`n"
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DestFile using wimlib-imagex"
                # Retrieve and format the file size
                $fileInfo = Get-Item $DestFile
                $fileSizeMB = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
                Write-PSDInstallLog -Message "Successfully created $DestFile using wimlib-imagex"
                Write-PSDInstallLog -Message "Archive File Size: $fileSizeMB"
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Archive File Size: $fileSizeMB"
            } catch {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DestFile using wimlib-imagex. Error: $_"
                Write-PSDInstallLog -Message "Failed to create $DestFile using wimlib-imagex. Error: $_" -LogLevel 3
            }
        }
        ElseIf ($CompressionType -eq "WIMDISM"){
            try {
                # Create WIM format archive using DISM
                $dismPath = "dism.exe"
                $dismArguments = "/Capture-Image /ImageFile:`"$DestFile`" /CaptureDir:`"$filesystemSourceFolderPath`" /Name:`"Driver Package`" /Compress:max"

                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating WIM format archive at $DestFile using DISM"
                # Invoke DISM
                $process = Start-Process -FilePath $dismPath -ArgumentList $dismArguments -Wait -PassThru -NoNewWindow

                # Check DISM exit code
                if ($process.ExitCode -ne 0) {
                    throw "DISM failed with exit code $($process.ExitCode)"
                }

                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DestFile using DISM"
                # Retrieve and format the file size
                $fileInfo = Get-Item $DestFile
                $fileSizeMB = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
                Write-PSDInstallLog -Message "Successfully created $DestFile using DISM"
                Write-PSDInstallLog -Message "Archive File Size: $fileSizeMB"
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Archive File Size: $fileSizeMB"
            } catch {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DestFile using DISM. Error: $_"
                Write-PSDInstallLog -Message "Failed to create $DestFile using DISM. Error: $_" -LogLevel 3
            }
        }
        Else {
            try
            {
                # Create ZIP format archive
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Creating ZIP format archive at $DestFile"
                Write-PSDInstallLog -Message "Creating ZIP format archive at $DestFile"
                Add-Type -Assembly 'System.IO.Compression.FileSystem' -PassThru | Select -First 1 | ForEach {
                    Write-PSDInstallLog -Message "Creating ZIP format archive at $DestFile"
                    [IO.Compression.ZIPFile]::CreateFromDirectory("$filesystemSourceFolderPath", $DestFile)
                }
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Successfully created $DestFile"
                # Retrieve and format the file size
                $fileInfo = Get-Item $DestFile
                $fileSizeMB = "{0:N2} MB" -f ($fileInfo.Length / 1MB)
                Write-PSDInstallLog -Message "Successfully created $DestFile"
                Write-PSDInstallLog -Message "Archive File Size: $fileSizeMB"
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Archive File Size: $fileSizeMB"
            } catch {
                Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Failed to create $DestFile error $_`... Exiting"
                Write-PSDInstallLog -Message "Failed to create $DestFile error $_`... Exiting" -LogLevel 3
            }
        }

        # Create driver folder structure under PSD Out-of-Box Drivers
        Add-DrvrFldrToOOBDPath -PSDriveName "PSDShare01" -DeploymentSharePath $psDeploymentFolder -FolderPath $DriversFolder
        
        # Stop the stopwatch and display the elapsed time in HH:MM:SS format
        $stopwatchCompression.Stop()
        $elapsedCompression = $stopwatchCompression.Elapsed

        # Format and display the elapsed time as hours:minutes:seconds
        $elapsedCompressionTimeFormatted = $elapsedCompression.ToString("hh\h\:mm\m\:ss\s")
        Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Total Processing time: $elapsedCompressionTimeFormatted"
        Write-Output "`n"
        Write-PSDInstallLog -Message "Total processing time: $elapsedCompressionTimeFormatted"
    }
}

# Stop the stopwatch and display the elapsed time in HH:MM:SS format
$stopwatch.Stop()
$elapsed = $stopwatch.Elapsed

# Format and display the elapsed time as hours:minutes:seconds
$elapsedTimeFormatted = $elapsed.ToString("hh\h\:mm\m\:ss\s")
Write-Output "------------------------------------------------------------"
Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Total execution time: $elapsedTimeFormatted"
Write-Output "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") Process Complete"
Write-PSDInstallLog -Message "Total execution time: $elapsedTimeFormatted"
Write-PSDInstallLog -Message "Process Complete"
Write-Output "------------------------------------------------------------"
