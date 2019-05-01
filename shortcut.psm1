#Import code
. (Join-Path $PSScriptRoot created.ps1)
. (Join-Path $PSScriptRoot config.ps1)

#Main function
function shortcut($shortcut, $optional, $optional2=$env:USERPROFILE) {
    If ($shortcut -eq "shortcut") {
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
            Write-Output " "
            Write-Output "Missing destination parameter!"
            Write-Output " "
            $global:sddebugcode=1;return 0 | Out-Null;
        } else {
            #Credit to Kevin Panko (https://superuser.com/users/3680/kevin-panko)
            if($optional.EndsWith(".lnk")) {
                $sh = new-object -com wscript.shell
                $fullpath = resolve-path $optional
                $targetpath = $sh.CreateShortcut($fullpath).TargetPath
                set-location $targetpath
            } else {
                Write-Output "You can only use follow on .lnk files. Be sure to include the file extension. Use the function cd for any other needs."
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
        Write-Output " "
        Write-Output "changelog  - displays the version history of shortcut"
        Write-Output "create     - creates a shortcut to the current directory"
        Write-Output "             Usage: create <name>"
        Write-Output "created    - easy access to view or edit the script in powershell ISE"
        Write-Output "delete     - removes a previously created shortcut"
        Write-Output "             Usage: delete <name>"
        Write-Output "elevate    - opens a new instance of powershell as administrator. Use unelevate to return to a regular instance."
        Write-Output "find       - searches the directory to find the path to a file"
        Write-Output "             Usage: find <filename> <directory>"
        Write-Output "findfolder - searches the directory to find the path to a folder"
        Write-Output "             Usage: findfolder <foldername> <directory>"
        Write-Output "follow     - allows access to the destination of shortcut files, a shortcoming of cd"
        Write-Output "             Usage: follow <name>.lnk"
        Write-Output "help       - displays this page :^]"
        Write-Output "reload     - refreshes the module from memory and reloads the most current version"
        Write-Output "sd         - a shortened alias to use in leui of shortcut. Note that this is not a command, but an alias for the function shortcut."
        Write-Output "             Usage: sd <command>"
        Write-Output "shortcut   - easy access to view or edit the script in powershell ISE"
        Write-Output "touch      - creates a file in current directory"
        Write-Output "             Usage: touch <filename>.<extension>"
        Write-Output "update     - automates the update process"
        Write-Output "unelevate  - opens a new regular instance of powershell and closes the current one"
        Write-Output "uninstall  - removes the module from PowerShell and puts it in the recycle bin."
        Write-Output "version    - displays the version of shortcut"
        Write-Output "window     - opens file explorer in current directory"
        Write-Output " "
        $global:sddebugcode=2;return 0 | Out-Null;
    } elseif ($shortcut -eq "version") {
        Write-Output " "
        Write-Output "Shortcut version 1.3.1"
        Write-Output "Use 'shortcut changelog' for more information"
        Write-Output "Written by Krishna Kokatay"
        Write-Output "GNU Licensed 2018"
        Write-Output "(Open Source, duh)"
        Write-Output " "
        $global:sddebugcode=2;return 0 | Out-Null;
    #This is getting long... might store this as seperate files down the road.
    } elseif ($shortcut -eq "changelog") {
        Write-Output ""
        Write-Output "Version 0.1 - ??/8/18"
        Write-Output "- Learned how to add shortcuts to different folders"
        Write-Output ""
        Write-Output "Version 0.2"
        Write-Output "- Added shortcuts to programming folders"
        Write-Output ""
        Write-Output "Version 0.3"
        Write-Output "- You can now edit the script and restart it easily. Added chrome, window, and touch as well!"
        Write-Output ""
        Write-Output "Version 0.4"
        Write-Output "- Added find, findfolder, elevate, help, and changelog! This feels like a proper program now."
        Write-Output ""
        Write-Output "Version 0.5"
        Write-Output "- Cleaned up the aesthetics of the help page. Also added option to find a file outside of ~\."
        Write-Output ""
        Write-Output "Version 0.6"
        Write-Output "- Modularized the code. Main functionality of module was added... You can now create shortcuts within your terminal."
        Write-Output ""
        Write-Output "Version 0.7 - 13/9/18"
        Write-Output "- Fixed major bugs, slight inconsistancies, and incorrect information. Also reordered version numbers."
        Write-Output ""
        Write-Output "Version 0.8 - 20/9/18"
        Write-Output "- Added created and reload. Module now comes with an installer.exe and update instructions."
        Write-Output ""
        Write-Output "Version 0.9 - 25/9/18"
        Write-Output "- Removed touch folder, just use mkdir. Preparing for release 1.0 soon, added 'sd' as an alias for shortcut."
        Write-Output ""
        Write-Output "Version 0.9.5 - 22/1/19"
        Write-Output "- Fixed some typos. Planning to add functionality to open lnk files in powershell, make a readout of created shortcuts, and stop windows from viewing the installer as a trojan..."
        Write-Output ""
        Write-Output "Version 0.9.9 - 23/1/19"
        Write-Output "- Added the follow command to follow lnk files in powershell. Also added the delete command to delete created shortcuts (This was done previously by editing the created.ps1 file)."
        Write-Output ""
        Write-Output "Version 1.0 - 24/1/19"
        Write-Output "- Ready for official release! We're still in development of course, but I'm happy with it's current state to go public. Added the commands, update and uninstall."
        Write-Output ""
        Write-Output "Version 1.1 - 25/1/19"
        Write-Output "- Fixed the unelevate command, elevate and unelevate now maintain the working directory, and I added the endofscript file."
        Write-Output ""
        Write-Output "Version 1.2 - 1/2/19"
        Write-Output "- Numerous bug fixes, will learn and complete how to digitally sign this module in the next update."
        Write-Output ""
        Write-Output "Version 1.3 - 1/2/18"
        Write-Output "- If v1.1 was the Titanic of programming bugs, v1.2 is the Hindenburg. Everything was broken. Everything. I had to implement debug codes into everything to fix it!"
        Write-Output ""
        Write-Output ""
        Write-Output "Version 1.3.1 - 1/5/19"
        Write-Output "- Removed the pre built functions documents, desktop, and downloads, due to a bug. Minor typos fixed."
        Write-Output ""
    #Main functionality of shortcut. Stores shortcuts in seperate file so I can update the program without interferring with them.
    } elseif ($shortcut -eq "create") {
        if ($optional -eq $null) {
            Write-Output " "
            Write-Output "Missing name parameter. You must name this shortcut."
            Write-Output " "
            $global:sddebugcode=1;return 0 | Out-Null;
        }
        shortcut $optional | Out-Null
        if ($global:sddebugcode -eq 0) {
            $location = $(get-location).Path
            (Get-Content (Join-Path $PSScriptRoot created.ps1)).replace('#Replace', "    } elseif (`$create -eq ""$optional"") {
        cd ""$location"";`$global:sddebugcode=3;return 0 | Out-Null;
#Replace") | Set-Content (Join-Path $PSScriptRoot created.ps1)
            Import-Module (Join-Path $PSScriptRoot shortcut.psm1) -Force -Global
        } else {
            Write-Output " "
            Write-Output "Error! Shortcut already exists! Use 'shortcut created' to view the list"
            Write-Output " "
            $global:sddebugcode=1;return 0 | Out-Null;
        }
    } elseif ($shortcut -eq "delete") {
        if ($optional -eq $null) {
            Write-Output " "
            Write-Output "Missing name parameter. You must name this shortcut."
            Write-Output " "
            $global:sddebugcode=1;return 0 | Out-Null;
        } else {
            $location = $(get-location).Path
            shortcut $optional | Out-Null
            $temp = $(get-location).Path
            if ($global:sddebugcode -eq 0) {
                Write-Output " "
                Write-Output "Shortcut cannot be deleted, it does not exist. Use 'shortcut created' to view your current list."
                Write-Output " "
                $global:sddebugcode=1;return 0 | Out-Null;
            }
            if ($global:sddebugcode -eq 2) {
                $wshell = New-Object -ComObject Wscript.Shell
                $wshell.Popup("Do not attempt to delete shortcut commands using the delete command! Edit the script if you must! Thankfully you're reading this and not corrupting your shortcut.ps1 file. Please don't repeat this action, I hate warning boxes as much as you do!",0,"Shortcut - Warning",0x1)
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
