function Get-TestData {
    [CmdletBinding()]
    param(
        # The filter to apply (as a script block)
        [Parameter(
        )]
        [scriptblock]$Filter
    )

    begin {
        Write-Debug "`n$('-' * 80)`n-- Begin $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
    process {
        $dataDir = Get-TestDataPath
        if (-not ([string]::IsNullorEmpty($dataDir))) {
            if (-not ([string]::IsNullorEmpty($Filter))) {
                Get-ChildItem -Path $dataDir
                | Where-Object $Filter
            } else {
                Get-ChildItem -Path $dataDir
            }
        } else {
            throw "Could not find data Directory for $((Get-PSCallStack)[1].ScriptName) "
        }
    }
    end {
        Write-Debug "`n$('-' * 80)`n-- End $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
}
