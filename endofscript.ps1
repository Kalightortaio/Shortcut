#This file was created to prevent any future edits to the created.ps1 file. If error checking or extraneous commands need to be added at the end of the script, it is now permissible without interferring with user data.

function endofscript($endofscript, $optional, $optional2='$env:USERPROFILE') {
      Write-Output " "
      Write-Output "Missing Destination! You probably need to program it in..."
      Write-Output " "
      Write-Output "Use shortcut help for documentation."
      Write-Output " "
      $global:sddebugcode=0;return 0 | Out-Null;
}

#Debug Codes
#0 - End of Script / Function was not found
#1 - Error was returned when function was executed
#2 - Function is hardcoded
#3 - Function is softcoded
