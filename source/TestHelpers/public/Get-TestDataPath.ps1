function Get-TestDataPath {
    <#
    .SYNOPSIS
        Return the data directory associated with the test
    #>
    [CmdletBinding()]
    param( )
    begin {
        Write-Debug "`n$('-' * 80)`n-- Begin $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
    process {
        $callStack = Get-PSCallStack
        $caller = $callStack[1]
        if ($caller.ScriptName -like $callStack[0].ScriptName) {
            $caller = $callStack[2]
        }

        $dataDirectory = ($caller.ScriptName -replace '\.Tests\.ps1', '.Data')
        if (-not ([string]::IsNullorEmpty($dataDirectory))) {
            $dataDirectory | Write-Output
        } else {
            throw "Could not determine the data directory"
        }
    }
    end {
        Write-Debug "`n$('-' * 80)`n-- End $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
}
