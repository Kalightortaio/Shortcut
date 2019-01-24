
function create($create, $optional, $optional2='~\') {
    If ($create -eq 'shortcut') {
        Write-Host "You should never ever be able to see this message, ever, at all. Please report to dev. Quantum Mechanics has failed us."
#Replace
    } else {
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
}


