#Import code
. (Join-Path $PSScriptRoot created.ps1)
. (Join-Path $PSScriptRoot config.ps1)

#Main function
function shortcut($shortcut, $optional, $optional2=$env:USERPROFILE) {
    If ($shortcut -eq "desktop") {
        cd "$($DefaultDrive):\Desktop"
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "documents") {
        cd "$($DefaultDrive):\Documents"
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "downloads") {
        cd "$($DefaultDrive):\Downloads"
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "shortcut") {
        cd $PSScriptRoot
        powershell_ise.exe shortcut.psm1
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "created") {
        cd $PSScriptRoot
        powershell_ise.exe created.ps1
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "unelevate") {
        $global:sddebugcode=2
        runas /trustlevel:0x20000 "powershell Start-Process powershell"
        exit
    } elseif ($shortcut -eq "reload") {
        Import-Module (Join-Path $PSScriptRoot shortcut.psm1) -Force -Global
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "window") {
        start .
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "find") {
        Get-ChildItem $optional2 -recurse -ErrorAction SilentlyContinue  | Where-Object {$_.Name -match $optional}
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "touch") {
        echo $null >> $optional
        Clear-Content $optional
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "findfolder") {
        Get-ChildItem $optional2 -recurse -ErrorAction SilentlyContinue  | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match $optional}
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "elevate") {
        $global:sddebugcode=2
        $location = $(get-location).Path
        Start-Process powershell -Verb runAs -ArgumentList "Start-Process powershell -WorkingDirectory $location"
        exit
    } elseif ($shortcut -eq "follow") {
        if ($optional -eq $null) {
            Write-Host " "
            Write-Host "Missing destination parameter!"
            Write-Host " "
            $global:sddebugcode=1;return 0 | Out-Null;
        } else {
            #Credit to Kevin Panko (https://superuser.com/users/3680/kevin-panko)
            if($optional.EndsWith(".lnk")) {
                $sh = new-object -com wscript.shell
                $fullpath = resolve-path $optional
                $targetpath = $sh.CreateShortcut($fullpath).TargetPath
                set-location $targetpath
            } else {
                Write-Host "You can only use follow on .lnk files. Be sure to include the file extension. Use the function cd for any other needs."
            }
        }
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "uninstall") {
        Add-Type -AssemblyName Microsoft.VisualBasic
        [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory("$PSScriptRoot",'OnlyErrorDialogs','SendToRecycleBin')
    } elseif ($shortcut -eq "update") {
        if (!(Test-Path (Join-Path $PSScriptRoot created.ps1))) {
            Move-Item -Path ".\Update\created.ps1" -Destination "$PSScriptRoot"
        }
        if (!(Test-Path (Join-Path $PSScriptRoot config.ps1))) {
            Move-Item -Path ".\Update\config.ps1" -Destination "$PSScriptRoot"
        }
        if (!(Test-Path "$($BootDrive):\Program Files\WindowsPowerShell\Modules\Shortcut\Update\")) {
            cd $PSScriptRoot
            mkdir Update
        }
        Move-Item -Force -Path ".\Update\shortcut.psm1" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\installer.exe" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\install.ps1" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\Install Instructions.txt" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\Update Instructions.txt" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\LICENSE" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\README.md" -Destination "$PSScriptRoot" -ErrorAction Ignore
        Move-Item -Force -Path ".\Update\endofscript.ps1" -Destination "$PSScriptRoot" -ErrorAction Ignore
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "help") {
        Write-Host " "
        Write-Host "changelog  - displays the version history of shortcut"
        Write-Host "create     - creates a shortcut to the current directory"
        Write-Host "             Usage: create <name>"
        Write-Host "created    - easy access to view or edit the script in powershell ISE"
        Write-Host "delete     - removes a previously created shortcut"
        Write-Host "             Usage: delete <name>"
        Write-Host "desktop    - shortcut to the desktop folder"
        Write-Host "documents  - shortcut to the documents folder"
        Write-Host "downloads  - shortcut to the downloads folder"
        Write-Host "elevate    - opens a new instance of powershell as administrator. Use unelevate to return to a regular instance."
        Write-Host "find       - searches the directory to find the path to a file"
        Write-Host "             Usage: find <filename> <directory>"
        Write-Host "findfolder - searches the directory to find the path to a folder"
        Write-Host "             Usage: findfolder <foldername> <directory>"
        Write-Host "follow     - allows access to the destination of shortcut files, a shortcoming of cd"
        Write-Host "             Usage: follow <name>.lnk"
        Write-Host "help       - displays this page :^]"
        Write-Host "reload     - refreshes the module from memory and reloads the most current version"
        Write-Host "sd         - a shortened alias to use in leui of shortcut. Note that this is not a command, but an alias for the function shortcut."
        Write-Host "             Usage: sd <command>"
        Write-Host "shortcut   - easy access to view or edit the script in powershell ISE"
        Write-Host "touch      - creates a file in current directory"
        Write-Host "             Usage: touch <filename>.<extension>"
        Write-Host "update     - automates the update process"
        Write-Host "unelevate  - opens a new regular instance of powershell and closes the current one"
        Write-Host "uninstall  - removes the module from PowerShell and puts it in the recycle bin."
        Write-Host "version    - displays the version of shortcut"
        Write-Host "window     - opens file explorer in current directory"
        Write-Host " "
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "version") {
        Write-Host " "
        Write-Host "Shortcut version 1.2"
        Write-Host "Use 'shortcut changelog' for more information"
        Write-Host "Written by Krishna Kokatay"
        Write-Host "GNU Licensed 2018"
        Write-Host "(Open Source, duh)"
        Write-Host " "
        $global:sddebugcode=2;return 0 | Out-Null;
    #This is getting long... might store this as seperate files down the road.
    } elseif ($shortcut -eq "changelog") {
        Write-Host ""
        Write-Host "Version 0.1 - ??/8/18"
        Write-Host "- Learned how to add shortcuts to different folders"
        Write-Host ""
        Write-Host "Version 0.2"
        Write-Host "- Added shortcuts to programming folders"
        Write-Host ""
        Write-Host "Version 0.3"
        Write-Host "- You can now edit the script and restart it easily. Added chrome, window, and touch as well!"
        Write-Host ""
        Write-Host "Version 0.4"
        Write-Host "- Added find, findfolder, elevate, help, and changelog! This feels like a proper program now."
        Write-Host ""
        Write-Host "Version 0.5"
        Write-Host "- Cleaned up the aesthetics of the help page. Also added option to find a file outside of ~\."
        Write-Host ""
        Write-Host "Version 0.6"
        Write-Host "- Modularized the code. Main functionality of module was added... You can now create shortcuts within your terminal."
        Write-Host ""
        Write-Host "Version 0.7 - 13/9/18"
        Write-Host "- Fixed major bugs, slight inconsistancies, and incorrect information. Also reordered version numbers."
        Write-Host ""
        Write-Host "Version 0.8 - 20/9/18"
        Write-Host "- Added created and reload. Module now comes with an installer.exe and update instructions."
        Write-Host ""
        Write-Host "Version 0.9 - 25/9/18"
        Write-Host "- Removed touch folder, just use mkdir. Preparing for release 1.0 soon, added 'sd' as an alias for shortcut."
        Write-Host ""
        Write-Host "Version 0.9.5 - 22/1/18"
        Write-Host "- Fixed some typos. Planning to add functionality to open lnk files in powershell, make a readout of created shortcuts, and stop windows from viewing the installer as a trojan..."
        Write-Host ""
        Write-Host "Version 0.9.9 - 23/1/18"
        Write-Host "- Added the follow command to follow lnk files in powershell. Also added the delete command to delete created shortcuts (This was done previously by editing the created.ps1 file)."
        Write-Host ""
        Write-Host "Version 1.0 - 24/1/18"
        Write-Host "- Ready for official release! We're still in development of course, but I'm happy with it's current state to go public. Added the commands, update and uninstall."
        Write-Host ""
        Write-Host "Version 1.1 - 25/1/18"
        Write-Host "- Fixed the unelevate command, elevate and unelevate now maintain the working directory, and I added the endofscript file."
        Write-Host ""
        Write-Host "Version 1.2 - 1/2/18"
        Write-Host "- Numerous bug fixes, will learn and complete how to digitally sign this module in the next update."
        Write-Host ""
        Write-Host "Version 1.3 - 1/2/18"
        Write-Host "- If v1.1 was the Titanic of programming bugs, v1.2 is the Hindenburg. Everything was broken. Everything. I had to implement debug codes into everything to fix it!"
        Write-Host ""
    #Main functionality of shortcut. Stores shortcuts in seperate file so I can update the program without interferring with them.
    } elseif ($shortcut -eq "create") {
        if ($optional -eq $null) {
            Write-Host " "
            Write-Host "Missing name parameter. You must name this shortcut."
            Write-Host " "
            $global:sddebugcode=1;return 0 | Out-Null;
        }
        shortcut $optional | Out-Null
        if ($global:sddebugcode -eq 0) {
            $location = $(get-location).Path
            (Get-Content (Join-Path $PSScriptRoot created.ps1)).replace('#Replace', "    } elseif (`$create -eq ""$optional"") {
        cd ""$location"";'$global:sddebugcode=3;return 0 | Out-Null;
#Replace") | Set-Content (Join-Path $PSScriptRoot created.ps1)
            Import-Module (Join-Path $PSScriptRoot shortcut.psm1) -Force -Global
        } else {
            Write-Host " "
            Write-Host "Error! Shortcut already exists! Use 'shortcut created' to view the list"
            Write-Host " "
            $global:sddebugcode=1;return 0 | Out-Null;
        }
    } elseif ($shortcut -eq "delete") {
        if ($optional -eq $null) {
            Write-Host " "
            Write-Host "Missing name parameter. You must name this shortcut."
            Write-Host " "
            $global:sddebugcode=1;return 0 | Out-Null;
        } else {
            $location = $(get-location).Path
            shortcut $optional | Out-Null
            $temp = $(get-location).Path
            if ($global:sddebugcode -eq 0) {
                Write-Host " "
                Write-Host "Shortcut cannot be deleted, it does not exist. Use 'shortcut created' to view your current list."
                Write-Host " "
                $global:sddebugcode=1;return 0 | Out-Null;
            }
            if ($global:sddebugcode -eq 2) {
                $wshell = New-Object -ComObject Wscript.Shell
                $wshell.Popup("Do not attempt to delete shortcut commands using the delete command! Edit the script if you must! Thankfully you're reading this and not corrupting your created.ps1 file. Please don't repeat this action, I hate warning boxes as much as you do!",0,"Shortcut - Warning",0x1)
                cd $location
                $global:sddebugcode=1;return 0 | Out-Null;      
            }
            if ($global:sddebugcode -eq 3) {
                Get-Content (Join-Path $PSScriptRoot created.ps1) | Select-String -SimpleMatch -Pattern "$optional","$temp" -NotMatch | Out-File (Join-Path $PSScriptRoot backup.ps1)
                cd $location
                Move-Item -Path (Join-Path $PSScriptRoot backup.ps1) -Destination (Join-Path $PSScriptRoot created.ps1) -Force
                Import-Module (Join-Path $PSScriptRoot shortcut.psm1) -Force -Global
                $global:sddebugcode=2;return 0 | Out-Null;
            }
            $wshell = New-Object -ComObject Wscript.Shell
            $wshell.Popup("Please report error code 'memory is the key' to devs at https://github.com/Kalightortaio/shortcut/issues",0,"Shortcut - Bug Detection",0x1)
            $global:sddebugcode=1;return 0 | Out-Null;
        }
    } else {
        create $shortcut $optional $optional2
    }
}
#You can use sd instead of typing out shortcut all the time!
function sd($shortcut, $optional, $optional2) {
    shortcut $shortcut $optional $optional2
}
