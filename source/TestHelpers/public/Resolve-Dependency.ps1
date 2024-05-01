function Resolve-Dependency {
    <#
    .SYNOPSIS
        Attempt to find the file for the resource requested
    .DESCRIPTION
        Provide a means for a test to lookup the path to a needed function, class , etc.
    .EXAMPLE
        $myTest = 'Test-MyItem' | Resolve-Dependency
        if ($null -ne $myTest) {
            . $myTest
        }
    #>
    [CmdletBinding()]
    param(
        # Name of the function or resource
        [Parameter(
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [string]$Name
    )
    begin {
        Write-Debug "`n$('-' * 80)`n-- Begin $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
    process {
        $sourceItem = Get-SourceItem | Where-Object Name -Like $Name -ErrorAction SilentlyContinue
        if ($null -ne $sourceItem) {
            $sourceItem.Path
        }
    }
    end {
        Write-Debug "`n$('-' * 80)`n-- End $($MyInvocation.MyCommand.Name)`n$('-' * 80)"
    }
}
