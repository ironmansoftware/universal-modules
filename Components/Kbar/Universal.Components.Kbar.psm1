$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

$IndexMap = Get-ChildItem "$PSScriptRoot\index.*.bundle.map"
[UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexMap.FullName) | Out-Null

function New-UDKBar {
    <#
    .SYNOPSIS
    A chart component for PowerShell Universal apps.
    
    .DESCRIPTION
    A chart component for PowerShell Universal apps.
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.

    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [Hashtable[]]$Action,
        [Parameter(Mandatory)]
        [Endpoint]$OnPerform,
        [Parameter()]
        [Alias("Content")]
        [ScriptBlock]$Children
    )
    
    End {
        $OnPerform.Register($Id, $PSCmdlet)

        @{
            assetId   = $AssetId 
            isPlugin  = $true 
            type      = "ud-kbar"
            id        = $Id

            children  = & $Children
            action    = $Action
            onPerform = $OnPerform
        }
    }
}

function New-UDKBarAction {
    param(
        [Parameter()]
        [string]$Id = [Guid]::NewGuid(),
        [Parameter(Mandatory)]
        [string]$Name, 
        [Parameter()]
        [string[]]$Shortcut, 
        [Parameter()]
        [string]$Keywords,
        [Parameter()]
        [string]$Section,
        [Parameter()]
        [Hashtable]$Icon,
        [Parameter()]
        [string]$Subtitle
    )

    End {
        @{
            id       = $Id
            name     = $Name
            shortcut = $Shortcut
            keywords = $Keywords
            section  = $Section
            icon     = $Icon
            subtitle = $Subtitle
        }
    }
}