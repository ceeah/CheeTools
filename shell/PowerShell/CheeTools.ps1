###
# Set of useful tools for everyday work
# add:
#   . "C:\path\to\CheeTools\shell\PowerShell\CheeTools.ps1"
# to $env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# or to $PROFILE

# if this file gets changed you can reload it in existing PS session with
#   . $PROFILE
###

Function Chee-Help ()
{
    Write-Output "Supported commands: Invoke-Adb"
}

#
# Uploads the ELF binary to the connected Android device and executes it
#
Function Invoke-Adb ($filePath)
{
    $remotePath = "/data/local/tmp"
    $fileName = (Get-Item $filePath).Name
    $remoteFilePath = "$remotePath/$fileName"

    Write-Output "Executing: $filePath"

    if ( -Not (Test-Path -Path "$filePath"))
    {
        Write-Error "File does not exist! Exiting..."
        return
    }

    adb push "$filePath" "$remoteFilePath"
    adb shell chmod a+x "$remoteFilePath"

    # Executing the file itself
    Write-Output "-----"
    adb shell "$remoteFilePath"
    Write-Output "`n-----"
}

echo "[+] CheeTools loaded. Enjoy!~`n"
