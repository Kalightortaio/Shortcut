. (Join-Path $PSScriptRoot endofscript.ps1)

function create($create, $optional, $optional2='$env:USERPROFILE') {
    If ($create -eq 'shortcut') {
        Write-Host "You should never ever be able to see this message, ever, at all. Please report to dev. Quantum Mechanics has failed us."
#Replace
    }
    endofscript $create, $optional, $optional2
}


