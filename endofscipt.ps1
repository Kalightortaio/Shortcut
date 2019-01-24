#This file was created to prevent any future edits to the created.ps1 file. If error checking or extraneous commands need to be added at the end of the script, it is now permissible without interferring with user data.

function endofscript($endofscript, $optional, $optional2='$env:USERPROFILE') {
      if ($err) {
          Write-Host " "
          Write-Host "Shortcut cannot be deleted, it does not exist. Use 'shortcut created' to view your current list."
          Write-Host " "
          $err = 0
          break
      }
      Write-Host " "
      Write-Host "Missing Destination! You probably need to program it in..."
      Write-Host " "
      Write-Host "Use shortcut help for documentation."
      Write-Host " "
}
