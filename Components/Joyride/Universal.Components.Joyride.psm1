$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

$IndexMap = Get-ChildItem "$PSScriptRoot\index.*.bundle.map"
[UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexMap.FullName) | Out-Null

function New-UDJoyride {
    <#
    .SYNOPSIS
    Create awesome tours for your app!
    
    .DESCRIPTION
    Create awesome tours for your app!
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.

    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [ScriptBlock]$Steps,
        [Parameter()]
        [Switch]$Continuous,
        [Parameter()]
        [Switch]$DisableCloseOnEsc,
        [Parameter()]
        [Switch]$DisableOverlay,
        [Parameter()]
        [Switch]$DisableOverlayClose,
        [Parameter()]
        [Switch]$DisableScrolling,
        [Parameter()]
        [Switch]$DisableScrollParentFix,
        [Parameter()]
        [Switch]$HideBackButton,
        [Parameter()]
        [Switch]$HideCloseButton,
        [Parameter()]
        [Hashtable]$Locale,
        [Parameter()]
        [int]$ScrollOffset = 20,
        [Parameter()]
        [int]$ScrollDuration = 300,
        [Parameter()]
        [Switch]$ScrollToFirstStep,
        [Parameter()]
        [Switch]$ShowProgress,
        [Parameter()]
        [Switch]$ShowSkipButton,
        [Parameter()]
        [Switch]$SpotlightClicks,
        [Parameter()]
        [int]$SpotlightPadding = 10,
        [Parameter()]
        [int]$StepIndex = 0,
        [Parameter()]
        [Hashtable]$Styles,
        [Parameter()]
        [bool]$Run = $true,
        [Parameter()]
        [Endpoint]$Callback,
        [Parameter()]
        [Switch]$JoyrideDebug
    )
    
    End {
        if ($Callback) {
            $Callback.Register($Id, $PSCmdlet)
        }

        $Props = @{
            assetId                = $AssetId 
            isPlugin               = $true 
            type                   = "ud-joyride"
            id                     = $Id

            steps                  = & $Steps
            continuous             = $Continuous.IsPresent
            disableCloseOnEsc      = $DisableCloseOnEsc.IsPresent
            disableOverlay         = $DisableOverlay.IsPresent
            disableOverlayClose    = $DisableOverlayClose.IsPresent
            disableScrolling       = $DisableScrolling.IsPresent
            disableScrollParentFix = $DisableScrollParentFix.IsPresent
            hideBackButton         = $HideBackButton.IsPresent
            hideCloseButton        = $HideCloseButton.IsPresent
            locale                 = $Locale
            scrollOffset           = $ScrollOffset
            scrollDuration         = $ScrollDuration
            scrollToFirstStep      = $ScrollToFirstStep.IsPresent
            showProgress           = $ShowProgress.IsPresent
            showSkipButton         = $ShowSkipButton.IsPresent
            spotlightClicks        = $SpotlightClicks.IsPresent
            spotlightPadding       = $SpotlightPadding
            styles                 = $Styles
            run                    = $Run
            callback               = $Callback
            debug                  = $JoyrideDebug.IsPresent
        }

        if ($PSBoundParameters.ContainsKey("StepIndex")) {
            $Props["stepIndex"] = $StepIndex
        }

        $Props
    }
}

function New-UDJoyrideStep {
    param(
        [Parameter(Mandatory)]
        [ScriptBlock]$Content,
        [Parameter(Mandatory)]
        [string]$Target,
        [Parameter()]
        [Switch]$DisableBeacon,
        [Parameter()]
        [ValidateSet("click", "hover")]
        [string]$Event = "click",
        [Parameter()]
        [Switch]$IsFixed,
        [Parameter()]
        [int]$Offset = 10,
        [Parameter()]
        [ValidateSet("top", "top-start", "top-end", "bottom", "bottom-start", "bottom-end", "left", "left-start", "left-end", "right", "right-start", "right-end", "auto", "center")]
        [string]$Placement = "bottom",
        [Parameter()]
        [ValidateSet("top", "bottom", "left", "right")]
        [string]$PlacementBeacon = "bottom",
        [Parameter()]
        [Hashtable]$Styles,
        [Parameter()]
        [string]$Title,
        [Parameter()]
        [Switch]$DisableCloseOnEsc,
        [Parameter()]
        [Switch]$DisableOverlay,
        [Parameter()]
        [Switch]$DisableOverlayClose,
        [Parameter()]
        [Switch]$DisableScrolling,
        [Parameter()]
        [Switch]$DisableScrollParentFix,
        [Parameter()]
        [Switch]$HideBackButton,
        [Parameter()]
        [Switch]$HideCloseButton,
        [Parameter()]
        [Hashtable]$Locale,
        [Parameter()]
        [Switch]$ShowProgress,
        [Parameter()]
        [Switch]$ShowSkipButton,
        [Parameter()]
        [Switch]$SpotlightClicks,
        [Parameter()]
        [int]$SpotlightPadding = 10
    )

    @{
        content                = & $Content
        target                 = $Target
        disableBeacon          = $DisableBeacon.IsPresent
        event                  = $Event.ToLower()
        isFixed                = $IsFixed.IsPresent
        offset                 = $Offset
        placement              = $Placement.ToLower()
        placementBeacon        = $PlacementBeacon.ToLower()
        styles                 = $Styles
        title                  = $Title
        disableCloseOnEsc      = $DisableCloseOnEsc.IsPresent
        disableOverlay         = $DisableOverlay.IsPresent
        disableOverlayClose    = $DisableOverlayClose.IsPresent
        disableScrolling       = $DisableScrolling.IsPresent
        disableScrollParentFix = $DisableScrollParentFix.IsPresent
        hideBackButton         = $HideBackButton.IsPresent
        hideCloseButton        = $HideCloseButton.IsPresent
        locale                 = $Locale
        showProgress           = $ShowProgress.IsPresent
        showSkipButton         = $ShowSkipButton.IsPresent
        spotlightClicks        = $SpotlightClicks.IsPresent
        spotlightPadding       = $SpotlightPadding
    }
}

function New-UDJoyrideStyle {
    param(
        [Parameter()]
        [string]$ArrowColor = "#fff",
        [Parameter()]
        [string]$BackgroundColor = "#fff",
        [Parameter()]
        [string]$BeaconSize = "36px",
        [Parameter()]
        [string]$OverlayColor = "rgba(0, 0, 0, 0.5)",
        [Parameter()]
        [string]$PrimaryColor = "#f04",
        [Parameter()]
        [string]$SpotlightShadow = "0 0 15px rgba(0, 0, 0, 0.5)",
        [Parameter()]
        [string]$TextColor = "#333",
        [Parameter()]
        [int]$Width, 
        [Parameter()]
        [int]$ZIndex = 100
    )

    $Props = @{
        arrowColor      = $ArrowColor
        backgroundColor = $BackgroundColor
        beaconSize      = $BeaconSize
        overlayColor    = $OverlayColor
        primaryColor    = $PrimaryColor
        spotlightShadow = $SpotlightShadow
        textColor       = $TextColor
        zIndex          = $ZIndex
    }

    if ($PSBoundParameters.ContainsKey("Width")) {
        $Props.Add("width", $Width)
    }

    $Props
}

function New-UDJoyrideLocale {
    param(
        [Parameter()]
        [string]$Back = "Back",
        [Parameter()]
        [string]$Close = "Close",
        [Parameter()]
        [string]$Last = "Last",
        [Parameter()]
        [string]$Next = "Next",
        [Parameter()]
        [string]$Skip = "Skip",
        [Parameter()]
        [string]$Open = "Open the dialog"
    )

    @{
        back  = $Back
        close = $Close
        last  = $Last
        next  = $Next
        skip  = $Skip
        open  = $Open
    }
}
