# Shortcut / sd
A powershell module aimed at making navigating the Windows OS a little bit easier.

Originally it was designed to create 'waypoints' around my various programming folders, but soon became my full fledged dive into learning PowerShell scripting. It's core features still revolve around making navigation for new or experienced developers' lives easier.

Let me know if you run into any issues, as I'll continue to develop further patches. This is a sort of passion project of mine.

The following is the help page, accessed by typing "shortcut help" or "sd help" into console.
```
changelog  - displays the version history of shortcut
create     - creates a shortcut to the current directory
             Usage: create <name>
created    - easy access to view or edit the script in powershell ISE
delete     - removes a previously created shortcut
             Usage: delete <name>
elevate    - opens a new instance of powershell as administrator. Use unelevate to return to a regular instance.
find       - searches the directory to find the path to a file
             Usage: find <filename> <directory>
findfolder - searches the directory to find the path to a folder
             Usage: findfolder <foldername> <directory>
follow     - allows access to the destination of shortcut files, a shortcoming of cd
             Usage: follow <name>.lnk
help       - displays this page :^]
reload     - refreshes the module from memory and reloads the most current version
sd         - a shortened alias to use in leui of shortcut. Note that this is not a command, but an alias for 
             the function shortcut. This can also be used as an alias for the cd or Set-Location commands.
             Usage: sd <command>
shortcut   - easy access to view or edit the script in powershell ISE
touch      - creates a file in current directory
             Usage: touch <filename>.<extension>
update     - automates the update process
unelevate  - opens a new regular instance of powershell and closes the current one
uninstall  - removes the module from PowerShell and puts it in the recycle bin.
version    - displays the version of shortcut
window     - opens file explorer in current directory
```

So for example, you can create a shortcut to your Python Dev folder by typing <code>shortcut create python</code> (or <code>sd create python</code>) and from that point onward, no matter where you are in powershell, you can return to that folder by using <code>shortcut python</code> (or <code>sd python</code>). Coupled with other useful commands like find, elevate, touch, and more, this module has greatly increased my productivity on Windows!
