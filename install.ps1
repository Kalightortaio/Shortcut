#Requires -RunAsAdministrator
. (Join-Path $PSScriptRoot config.ps1)

$folderpath = Get-Location
if (!(Test-Path "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut")) {
    cd "$($BootDrive):\Program Files\WindowsPowerShell\Modules"
    mkdir Shortcut
}
if (!(Test-Path "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut\created.ps1")) {
    Move-Item -Path "$folderpath\created.ps1" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
}
if (!(Test-Path "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut\config.ps1")) {
    Move-Item -Path "$folderpath\config.ps1" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
}
if (!(Test-Path "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut\Update\")) {
    cd .\Shortcut
    mkdir Update
}
Move-Item -Force -Path "$folderpath\shortcut.psm1" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\install.ps1" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\Install Instructions.txt" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\Update Instructions.txt" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\packager_backup.txt" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\LICENSE" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\README.md" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\endofscript.ps1" -Destination "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut"
takeown /f "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut" /r
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Operation Completed!",0,"Shortcut Installer",0x1)
exit
