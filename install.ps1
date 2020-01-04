#Requires -RunAsAdministrator

$folderpath = Get-Location
if (!(Test-Path "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut")) {
    cd "$($env:ProgramFiles)\WindowsPowerShell\Modules"
    mkdir Shortcut
}
if (!(Test-Path "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut\created.ps1")) {
    Move-Item -Path "$folderpath\created.ps1" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
}
if (!(Test-Path "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut\Update\")) {
    cd .\Shortcut
    mkdir Update
}
Move-Item -Force -Path "$folderpath\shortcut.psm1" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\install.ps1" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\Install Instructions.txt" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\Update Instructions.txt" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\LICENSE" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\README.md" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
Move-Item -Force -Path "$folderpath\endofscript.ps1" -Destination "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut"
takeown /f "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut" /r
icacls "$($env:ProgramFiles)\WindowsPowerShell\Modules\Shortcut" /grant administrators:F /t
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("Operation Completed!",0,"Shortcut Installer",0x1)
exit
