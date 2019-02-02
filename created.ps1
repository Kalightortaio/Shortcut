. (Join-Path $PSScriptRoot endofscript.ps1)

function create($create, $optional, $optional2='$env:USERPROFILE') {
    If (1 -eq 0) {
        $global:sddebugcode=1;return 0 | Out-Null;
#Replace
    }
    endofscript $create, $optional, $optional2
}
