$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

$IndexMap = Get-ChildItem "$PSScriptRoot\index.*.bundle.map"
[UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexMap.FullName) | Out-Null

function New-UDRechart {
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
        $Data,
        [Parameter()]
        [Validateset('horizontal', 'vertical')]
        [string]$Layout = 'horizontal',
        [Parameter()]
        [int]$Width = 500,
        [Parameter()]
        [int]$Height = 500,
        [Parameter()]
        [Hashtable]$Margin = @{ top = 10; right = 30; bottom = 0; left = 0 },
        [Parameter()]
        [ValidateSet('expand', 'none', 'wiggle', 'silhouette')]
        [string]$StackOffset = 'none',
        [Parameter()]
        $BaseValue = 'auto',
        [Parameter()]
        [Endpoint]$OnClick,

        [Parameter()]
        [Alias("Content")]
        [ScriptBlock]$Children
    )
    
    End {
        if ($OnClick) {
            $OnClick.Register($Id + "OnClick", $PSCmdlet)
        }

        @{
            assetId     = $AssetId 
            isPlugin    = $true 
            type        = "ud-rechart"
            id          = $Id

            data        = $Data
            layout      = $Layout.ToLower()
            width       = $Width
            height      = $Height
            margin      = $Margin
            stackOffset = $StackOffset
            baseValue   = $BaseValue
            children    = & $Children
            onClick     = $OnClick

        }
    }
}

function New-UDRechartLegend {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [Validateset('horizontal', 'vertical')]
        [string]$Layout = 'horizontal',
        [Parameter()]
        [Validateset('left', 'center', 'right')]
        [string]$Align = "center",
        [Parameter()]
        [Validateset('top', 'middle', 'bottom')]
        [string]$VerticalAlign = "middle",
        [Parameter()]
        [int]$IconSize = 14,
        [Parameter()]
        [Validateset('circle', 'cross', 'diamond', 'square', 'star', 'triangle', 'wye')]
        [string]$IconType = 'square'

    )

    @{
        type          = "ud-rechart-legend"
        id            = $Id
        assetId       = $AssetId
        isPlugin      = $true

        width         = if ($PSBoundParameters.ContainsKey('Width')) { $Width } else { $null }
        height        = if ($PSBoundParameters.ContainsKey('Height')) { $Height } else { $null }
        layout        = $Layout.ToLower()
        align         = $Align.ToLower()
        verticalAlign = $VerticalAlign.ToLower()
        iconSize      = $IconSize
        iconType      = $IconType.ToLower()
    }
}

function New-UDRechartAxis {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [ValidateSet('x', 'y', 'z')]
        [string]$Axis,

        [Parameter()]
        [Switch]$Hide,

        [Parameter()]
        [string]$DataKey,
        [Parameter()]
        [ValidateSet('number', 'category')]
        [string]$Type = 'category'
    )

    @{
        type     = "ud-rechart-axis"
        id       = $Id
        assetId  = $AssetId
        isPlugin = $true

        hide     = $Hide.IsPresent
        dataKey  = $DataKey
        xAxisId  = $Id
        yAxisId  = $Id
        axisType = $Type.ToLower()
        axis     = $Axis.ToLower()
    }
}

function New-UDRechartArea {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$DataKey,
        [Parameter()]
        [string]$XAxisId,
        [Parameter()]
        [string]$YAxisId,
        [Parameter()]
        [string]$Stroke,
        [Parameter()]
        [string]$Fill,
        [Parameter()]
        [ValidateSet('basis' , 'basisClosed' , 'basisOpen' , 'linear' , 'linearClosed' , 'natural' , 'monotoneX' , 'monotoneY' , 'monotone' , 'step' , 'stepBefore' , 'stepAfter' )]
        [string]$Type = 'linear'
    )

    @{
        type     = "ud-rechart-area"
        id       = $Id
        assetId  = $AssetId
        isPlugin = $true

        dataKey  = $DataKey
        xAxisId  = $XAxisId
        yAxisId  = $YAxisId
        stroke   = $Stroke
        fill     = $Fill
        areaType = $Type
    }
}