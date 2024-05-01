function Get-SourceFilePath {
    [CmdletBinding()]
    param()
    begin {
        Write-Debug "`n$('-' * 80)`n-- Begin $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
    process {
        $callStack = Get-PSCallStack
        $caller = $callStack[1]
        $testFileName = Split-Path $caller.ScriptName -LeafBase
        if (-not ([string]::IsNullorEmpty($testFileName))) {
            $sourceName = $testFileName -replace '\.Tests', ''
            $sourceItem = Get-SourceItem
            | Where-Object Name -Like $sourceName -ErrorAction SilentlyContinue
        } else {
            $PSCmdlet.ThrowTerminatingError($_)
        }
        if ($null -ne $sourceItem) {
            $sourceItem.Path | Write-Output
        } else {
            throw "Could not find source item for $sourceName"
        }
    }
    end {
        Write-Debug "`n$('-' * 80)`n-- End $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
}
