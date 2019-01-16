[CmdletBinding()]
param([Parameter(Mandatory=$true)]
      [string]$buildNumber)

# Ensure the error action preference is set to the default for PowerShell3, 'Stop'
$ErrorActionPreference = 'Stop'

# Constants
$WindowsSDKOptions = @("OptionId.UWPCpp")
$WindowsSDKRegPath = "HKLM:\Software\Microsoft\Windows Kits\Installed Roots"
$WindowsSDKRegRootKey = "KitsRoot10"
$WindowsSDKVersion = "10.0.$buildNumber.0"
$WindowsSDKInstalledRegPath = "$WindowsSDKRegPath\$WindowsSDKVersion\Installed Options"
$StrongNameRegPath = "HKLM:\SOFTWARE\Microsoft\StrongName\Verification"
$PublicKeyTokens = @("31bf3856ad364e35")

function Download-File
{
    param ([string] $outDir,
           [string] $downloadUrl,
           [string] $downloadName)

    # The ISO file can be large (800 MB), we want to use smart caching if we can to avoid long delays
    # Note that some sources explicitly disable caching, so this may not be possible
    $etagFile = Join-path $outDir "$downloadName.ETag"
    $downloadPath = Join-Path $outDir "$downloadName.download"
    $downloadDest = Join-Path $outDir $downloadName
    $downloadDestTemp = Join-Path $outDir "$downloadName.tmp"
    $headers = @{}

    Write-Host -NoNewline "Ensuring that $downloadName is up to date..."

    # if the destination folder doesn't exist, delete the ETAG file if it exists
    if (!(Test-Path -PathType Container $downloadDest) -and (Test-Path -PathType Container $etagFile))
    {
        Remove-Item -Force $etagFile
    }

    if (Test-Path $etagFile)
    {
        $headers.Add("If-None-Match", [System.IO.File]::ReadAllText($etagFile))
    }

        
    #$response = Invoke-WebRequest -Headers $headers -Uri $downloadUrl -PassThru -OutFile $downloadPath -UseBasicParsing

    # From https://stackoverflow.com/a/54102582
    process {
        try {
            $request = [System.Net.HttpWebRequest]::Create($downloadUrl)
            $headers.GetEnumerator() | % { $request.Headers.Add($_.Key, $_.Value) }

            #$request.set_Timeout(5000) # 5 second timeout
            $response = $request.GetResponse()
            $total_bytes = $response.ContentLength
            $response_stream = $response.GetResponseStream()

            try {
                # 256KB works better on my machine for 1GB and 10GB files
                # See https://www.microsoft.com/en-us/research/wp-content/uploads/2004/12/tr-2004-136.pdf
                # Cf. https://stackoverflow.com/a/3034155/10504393
                $buffer = New-Object -TypeName byte[] -ArgumentList 256KB
                $target_stream = [System.IO.File]::Create($downloadPath)

                $timer = New-Object -TypeName timers.timer
                $timer.Interval = 1000 # Update progress every second
                $timer_event = Register-ObjectEvent -InputObject $timer -EventName Elapsed -Action {
                    $Global:update_progress = $true
                }
                $timer.Start()

                do {
                    $count = $response_stream.Read($buffer, 0, $buffer.length)
                    $target_stream.Write($buffer, 0, $count)
                    $downloaded_bytes = $downloaded_bytes + $count

                    if ($Global:update_progress) {
                        $percent = $downloaded_bytes / $total_bytes
                        $status = @{
                            completed  = "{0,6:p2} Completed" -f $percent
                            downloaded = "{0:n0} MB of {1:n0} MB" -f ($downloaded_bytes / 1MB), ($total_bytes / 1MB)
                            speed      = "{0,7:n0} KB/s" -f (($downloaded_bytes - $prev_downloaded_bytes) / 1KB)
                            eta        = "eta {0:hh\:mm\:ss}" -f (New-TimeSpan -Seconds (($total_bytes - $downloaded_bytes) / ($downloaded_bytes - $prev_downloaded_bytes)))
                        }
                        $progress_args = @{
                            Activity        = "Downloading $downloadUrl"
                            Status          = "$($status.completed) ($($status.downloaded)) $($status.speed) $($status.eta)"
                            PercentComplete = $percent * 100
                        }
                        Write-Progress @progress_args

                        $prev_downloaded_bytes = $downloaded_bytes
                        $Global:update_progress = $false
                    }
                } while ($count -gt 0)
            }
            catch [System.Net.WebException]
            {
                $response = $_.Exception.Response
            }

            if ($response.StatusCode -eq 200)
            {
                Unblock-File $downloadPath
                [System.IO.File]::WriteAllText($etagFile, $response.Headers["ETag"])

                $downloadDestTemp = $downloadPath;

                # Delete and rename to final dest
                if (Test-Path -PathType Container $downloadDest)
                {
                    [System.IO.Directory]::Delete($downloadDest, $true)
                }

                Move-Item -Force $downloadDestTemp $downloadDest
                Write-Host "Updated $downloadName"
            }
            elseif ($response.StatusCode -eq 304)
            {
                Write-Host "Done"
            }
            else
            {
                Write-Host
                Write-Warning "Failed to fetch updated file from $downloadUrl"
                if (!(Test-Path $downloadDest))
                {
                    throw "$downloadName was not found at $downloadDest"
                }
                else
                {
                    Write-Warning "$downloadName may be out of date"
                }
            }
            finally {
                if ($timer) { $timer.Stop() }
                if ($timer_event) { Unregister-Event -SubscriptionId $timer_event.Id }
                if ($target_stream) { $target_stream.Dispose() }
                # If file exists and $count is not zero or $null, than script was interrupted by user
                if ((Test-Path $Filename) -and $count) { Remove-Item -Path $Filename }
            }
        }
        finally {
            
            if ($response) { $response.Dispose() }
            if ($response_stream) { $response_stream.Dispose() }
        }
    }  
    return $downloadDest
}


function Get-FileFromURL {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [System.Uri]$URL,
        [Parameter(Mandatory, Position = 1)]
        [string]$Filename
    )

   
}

function Get-ISODriveLetter
{
    param ([string] $isoPath)

    $diskImage = Get-DiskImage -ImagePath $isoPath
    if ($diskImage)
    {
        $volume = Get-Volume -DiskImage $diskImage

        if ($volume)
        {
            $driveLetter = $volume.DriveLetter
            if ($driveLetter)
            {
                $driveLetter += ":"
                return $driveLetter
            }
        }
    }

    return $null
}

function Mount-ISO
{
    param ([string] $isoPath)

    # Check if image is already mounted
    $isoDrive = Get-ISODriveLetter $isoPath

    if (!$isoDrive)
    {
        Mount-DiskImage -ImagePath $isoPath -StorageType ISO | Out-Null
    }

    $isoDrive = Get-ISODriveLetter $isoPath
    Write-Verbose "$isoPath mounted to ${isoDrive}:"
}

function Dismount-ISO
{
    param ([string] $isoPath)

    $isoDrive = (Get-DiskImage -ImagePath $isoPath | Get-Volume).DriveLetter

    if ($isoDrive)
    {
        Write-Verbose "$isoPath dismounted"
        Dismount-DiskImage -ImagePath $isoPath | Out-Null
    }
}

function Disable-StrongName
{
    param ([string] $publicKeyToken = "*")

    reg ADD "HKLM\SOFTWARE\Microsoft\StrongName\Verification\*,$publicKeyToken" /f | Out-Null
    if ($env:PROCESSOR_ARCHITECTURE -eq "AMD64")
    {
        reg ADD "HKLM\SOFTWARE\Wow6432Node\Microsoft\StrongName\Verification\*,$publicKeyToken" /f | Out-Null
    }
}

function Test-Admin
{
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal $identity
    $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-RegistryPathAndValue
{
    param (
        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $path,
        [parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $value)

    try
    {
        if (Test-Path $path)
        {
            Get-ItemProperty -Path $path | Select-Object -ExpandProperty $value -ErrorAction Stop | Out-Null
            return $true
        }
    }
    catch
    {
    }

    return $false
}

function Test-InstallWindowsSDK
{
    $retval = $true

    if (Test-RegistryPathAndValue -Path $WindowsSDKRegPath -Value $WindowsSDKRegRootKey)
    {
        # A Windows SDK is installed
        # Is an SDK of our version installed with the options we need?
        if (Test-RegistryPathAndValue -Path $WindowsSDKInstalledRegPath -Value "$WindowsSDKOptions")
        {
            # It appears we have what we need. Double check the disk
            $sdkRoot = Get-ItemProperty -Path $WindowsSDKRegPath | Select-Object -ExpandProperty $WindowsSDKRegRootKey
            if ($sdkRoot)
            {
                if (Test-Path $sdkRoot)
                {
                    $refPath = Join-Path $sdkRoot "References\$WindowsSDKVersion"
                    if (Test-Path $refPath)
                    {
                        $umdPath = Join-Path $sdkRoot "UnionMetadata\$WindowsSDKVersion"
                        if (Test-Path $umdPath)
                        {
                            # Pretty sure we have what we need
                            $retval = $false
                        }
                    }
                }
            }
        }
    }

    return $retval
}

function Test-InstallStrongNameHijack
{
    foreach($publicKeyToken in $PublicKeyTokens)
    {
        $key = "$StrongNameRegPath\*,$publicKeyToken"
        if (!(Test-Path $key))
        {
            return $true
        }
    }

    return $false
}

Write-Host -NoNewline "Checking for installed Windows SDK $WindowsSDKVersion..."
$InstallWindowsSDK = Test-InstallWindowsSDK
if ($InstallWindowsSDK)
{
    Write-Host "Installation required"
}
else
{
    Write-Host "INSTALLED"
}

$StrongNameHijack = Test-InstallStrongNameHijack
Write-Host -NoNewline "Checking if StrongName bypass required..."

if ($StrongNameHijack)
{
    Write-Host "REQUIRED"
}
else
{
    Write-Host "Done"
}

if ($StrongNameHijack -or $InstallWindowsSDK)
{
    if (!(Test-Admin))
    {
        Write-Host
        throw "ERROR: Elevation required"
    }
}

if ($InstallWindowsSDK)
{
    # Static(ish) link for Windows SDK
    # Note: there is a delay from Windows SDK announcements to availability via the static link
    $uri = "https://go.microsoft.com/fwlink/?prd=11966&pver=1.0&plcid=0x409&clcid=0x409&ar=Flight&sar=Sdsurl&o1=$buildNumber"

    if ($env:TEMP -eq $null)
    {
        $env:TEMP = Join-Path $env:SystemDrive 'temp'
    }

    $winsdkTempDir = Join-Path $env:TEMP "WindowsSDK"

    if (![System.IO.Directory]::Exists($winsdkTempDir))
    {
        [void][System.IO.Directory]::CreateDirectory($winsdkTempDir)
    }

    $file = "winsdk_$buildNumber.iso"

    Write-Verbose "Getting WinSDK from $uri"
    $downloadFile = Download-File $winsdkTempDir $uri $file

    # TODO Check if zip, exe, iso, etc.
    try
    {
        Write-Host -NoNewline "Mounting ISO $file..."
        Mount-ISO $downloadFile
        Write-Host "Done"

        $isoDrive = Get-ISODriveLetter $downloadFile

        if (Test-Path $isoDrive)
        {
            Write-Host -NoNewLine "Installing WinSDK..."

            $setupPath = Join-Path "$isoDrive" "WinSDKSetup.exe"
            Start-Process -Wait $setupPath "/features $WindowsSDKOptions /q"
            Write-Host "Done"
        }
        else
        {
            throw "Could not find mounted ISO at ${isoDrive}"
        }
    }
    finally
    {
        Write-Host -NoNewline "Dismounting ISO $file..."
        #Dismount-ISO $downloadFile
        Write-Host "Done"
    }
}

if ($StrongNameHijack)
{
    Write-Host -NoNewline "Disabling StrongName for Windows SDK..."

    foreach($key in $PublicKeyTokens)
    {
        Disable-StrongName $key
    }

    Write-Host "Done"
}