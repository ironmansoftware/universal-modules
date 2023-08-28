$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

$IndexMap = Get-ChildItem "$PSScriptRoot\index.*.bundle.map"
[UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexMap.FullName) | Out-Null

function New-UDLoader {
    <#
    .SYNOPSIS
    A loader component for PowerShell Universal apps.
    
    .DESCRIPTION
    A loader component for PowerShell Universal apps.
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.

    .PARAMETER Height
    The height of the spinner.

    .PARAMETER Width
    The width of the spinner.

    .PARAMETER Color
    The color of the spinner.

    .PARAMETER Style
    The style of the spinner.

    .PARAMETER SpeedMultiplier
    controls the speed of animation. Higher number equals faster speed

    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),

        [Parameter(ParameterSetName = "Bar")]
        [Switch]$Bar,
        [Parameter(ParameterSetName = "Beat")]
        [Switch]$Beat,
        [Parameter(ParameterSetName = "Bounce")]
        [Switch]$Bounce,
        [Parameter(ParameterSetName = "Circle")]
        [Switch]$Circle,
        [Parameter(ParameterSetName = "ClimbingBox")]
        [Switch]$ClimbingBox,
        [Parameter(ParameterSetName = "Clip")]
        [Switch]$Clip,
        [Parameter(ParameterSetName = "Clock")]
        [Switch]$Clock,
        [Parameter(ParameterSetName = "Dot")]
        [Switch]$Dot,
        [Parameter(ParameterSetName = "Fade")]
        [Switch]$Fade,
        [Parameter(ParameterSetName = "Grid")]
        [Switch]$Grid,
        [Parameter(ParameterSetName = "Hash")]
        [Switch]$Hash,
        [Parameter(ParameterSetName = "Moon")]
        [Switch]$Moon,
        [Parameter(ParameterSetName = "Pacman")]
        [Switch]$Pacman,
        [Parameter(ParameterSetName = "Propagate")]
        [Switch]$Propagate,
        [Parameter(ParameterSetName = "Puff")]
        [Switch]$Puff,
        [Parameter(ParameterSetName = "Pulse")]
        [Switch]$Pulse,
        [Parameter(ParameterSetName = "Ring")]
        [Switch]$Ring,
        [Parameter(ParameterSetName = "Rise")]
        [Switch]$Rise,
        [Parameter(ParameterSetName = "Rotate")]
        [Switch]$Rotate,
        [Parameter(ParameterSetName = "Scale")]
        [Switch]$Scale,
        [Parameter(ParameterSetName = "Skew")]
        [Switch]$Skew,
        [Parameter(ParameterSetName = "Square")]
        [Switch]$Square,
        [Parameter(ParameterSetName = "Sync")]
        [Switch]$Sync,

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Fade")]
        [Parameter(ParameterSetName = "Scale")]
        [int]$Height = 4,

        [Parameter(ParameterSetName = "Bar")]
        [Parameter(ParameterSetName = "Fade")]
        [Parameter(ParameterSetName = "Grid")]
        [Parameter(ParameterSetName = "Scale")]
        [int]$Width = 100,

        [Parameter(ParameterSetName = "Beat")]
        [Parameter(ParameterSetName = "Bounce")]
        [Parameter(ParameterSetName = "Circle")]
        [Parameter(ParameterSetName = "ClimbingBox")]
        [Parameter(ParameterSetName = "Clip")]
        [Parameter(ParameterSetName = "Clock")]
        [Parameter(ParameterSetName = "Dot")]
        [Parameter(ParameterSetName = "Grid")]
        [Parameter(ParameterSetName = "Hash")]
        [Parameter(ParameterSetName = "Moon")]
        [Parameter(ParameterSetName = "Pacman")]
        [Parameter(ParameterSetName = "Propagate")]
        [Parameter(ParameterSetName = "Puff")]
        [Parameter(ParameterSetName = "Pulse")]
        [Parameter(ParameterSetName = "Ring")]
        [Parameter(ParameterSetName = "Rise")]
        [Parameter(ParameterSetName = "Rotate")]
        [Parameter(ParameterSetName = "Skew")]
        [Parameter(ParameterSetName = "Square")]
        [Parameter(ParameterSetName = "Sync")]
        [int]$Size = 15,

        [Parameter(ParameterSetName = "Beat")]
        [Parameter(ParameterSetName = "Fade")]
        [Parameter(ParameterSetName = "Grid")]
        [Parameter(ParameterSetName = "Pacman")]
        [Parameter(ParameterSetName = "Pulse")]
        [Parameter(ParameterSetName = "Rise")]
        [Parameter(ParameterSetName = "Rotate")]
        [Parameter(ParameterSetName = "Scale")]
        [Parameter(ParameterSetName = "Sync")]
        [int]$Margin = 2,

        [Parameter(ParameterSetName = "Fade")]
        [Parameter(ParameterSetName = "Scale")]
        [int]$Radius = 2,

        [Parameter()]
        [string]$Color = "#36d7b7",
        [Parameter()]
        [Hashtable]$Style,
        [Parameter()]
        [int]$SpeedMultiplier = 1

    )
    
    End {

        $LoaderType = ''
        if ($Bar) {
            $LoaderType = 'Bar'
        }
        elseif ($Beat) {
            $LoaderType = 'Beat'
        }
        elseif ($Bounce) {
            $LoaderType = 'Bounce'
        }
        elseif ($Circle) {
            $LoaderType = 'Circle'
        }
        elseif ($ClimbingBox) {
            $LoaderType = 'ClimbingBox'
        }
        elseif ($Clip) {
            $LoaderType = 'Clip'
        }
        elseif ($Clock) {
            $LoaderType = 'Clock'
        }
        elseif ($Dot) {
            $LoaderType = 'Dot'
        }
        elseif ($Fade) {
            $LoaderType = 'Fade'
        }
        elseif ($Grid) {
            $LoaderType = 'Grid'
        }
        elseif ($Hash) {
            $LoaderType = 'Hash'
        }
        elseif ($Moon) {
            $LoaderType = 'Moon'
        }
        elseif ($Pacman) {
            $LoaderType = 'Pacman'
        }
        elseif ($Propagate) {
            $LoaderType = 'Propagate'
        }
        elseif ($Puff) {
            $LoaderType = 'Puff'
        }
        elseif ($Pulse) {
            $LoaderType = 'Pulse'
        }
        elseif ($Ring) {
            $LoaderType = 'Ring'
        }
        elseif ($Rise) {
            $LoaderType = 'Rise'
        }
        elseif ($Rotate) {
            $LoaderType = 'Rotate'
        }
        elseif ($Scale) {
            $LoaderType = 'Scale'
        }
        elseif ($Skew) {
            $LoaderType = 'Skew'
        }
        elseif ($Square) {
            $LoaderType = 'Square'
        }
        elseif ($Sync) {
            $LoaderType = 'Sync'
        }

        @{
            assetId         = $AssetId 
            isPlugin        = $true 
            type            = "ud-loader"
            id              = $Id

            height          = $Height
            width           = $Width
            color           = $Color
            style           = $Style
            size            = $Size
            margin          = $Margin
            speedMultiplier = $SpeedMultiplier
            loading         = $true
            radius          = $Radius
            loaderType      = $LoaderType
        }
    }
}