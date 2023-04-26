$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

function New-UDBootstrapIcon {
    <#
    .SYNOPSIS
    Bootstrap icons for PowerShell Universal apps.
    
    .DESCRIPTION
    Bootstrap icons for PowerShell Universal apps.
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.
    
    .PARAMETER Icon
    The name of the icon to use. See https://react-icons.github.io/react-icons/icons?name=bs for icons.
    
    .PARAMETER Style
    A hashtable for CSS styles to apply.
    
    .PARAMETER ClassName
    A CSS class to apply to this component.
    
    .EXAMPLE
    New-UDBootstrapIcon -Icon 'BsFillAlarmFill'

    .EXAMPLE
    New-UDBootstrapIcon -Icon 'BsFillAlarmFill' -Style @{
        FontSize = '100px'
    }
    #>#
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$Icon,
        [Parameter()]
        [Hashtable]$Style,
        [Parameter()]
        [string]$ClassName
    )
    
    End {
        @{
            assetId   = $AssetId 
            isPlugin  = $true 
            type      = "ud-bsicon"
            id        = $Id

            icon      = $icon
            style     = $Style
            className = $ClassName
        }
    }
}