$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

function New-UDCalendar {
    <#
    .SYNOPSIS
    A calendar component for PowerShell Universal apps.
    
    .DESCRIPTION
    A calendar component for PowerShell Universal apps.
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.

    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [Hashtable[]]$Events = @(),
        [Parameter()]
        [Endpoint]$DateClicked,
        [Parameter()]
        [Endpoint]$EventClicked,
        [Parameter()]
        [ValidateSet('dayGridYear', 'dayGridMonth', 'dayGridWeek', 'dayGridDay', 'timeGridWeek', 'timeGridDay', 'listWeek', 'listDay', 'listMonth', 'listYear', 'multiMonthYear')]
        [string]$View = "dayGridMonth",
        [Parameter()]
        [Switch]$HideWeekends,
        [Parameter()]
        [int[]]$HiddenDays = @(),
        [Parameter()]
        [Switch]$HideDayHeader,
        [Parameter()]
        [DateTime]$InitialDate = (Get-Date),
        [Parameter()]
        [ValidateSet("de", "it", "fr", "es")]
        [string]$Locale,
        [Parameter()]
        [string]$SlotMinTime = "00:00:00",
        [Parameter()]
        [string]$SlotMaxTime = "24:00:00"
    )
    
    End {
        if ($DateClicked) {
            $DateClicked.Register($Id + "DateClicked", $PSCmdlet)
        }

        if ($EventClicked) {
            $EventClicked.Register($Id + "EventClicked", $PSCmdlet)
        }

        @{
            assetId      = $AssetId 
            isPlugin     = $true 
            type         = "ud-calendar"
            id           = $Id

            events       = $Events
            dateClicked  = $DateClicked
            renderEvent  = $RenderEvent
            weekends     = -not $HideWeekends.IsPresent
            hiddenDays   = $HiddenDays
            dayHeaders   = -not $HideDayHeader.IsPresent
            initialDate  = $InitialDate
            view         = $View
            locale       = if ($Locale) { $Locale.ToLower() } else { $null }
            eventClicked = $EventClicked
            slotMinTime  = $SlotMinTime
            slotMaxTime  = $SlotMaxTime
        }
    }
}

function New-UDCalendarEvent {
    <#
    .SYNOPSIS
    A calendar event for the calendar component.
    
    .DESCRIPTION
    A calendar event for the calendar component.
    
    .PARAMETER Id
    The ID for this component. If not specified, a GUID will be generated.
    
    .PARAMETER Title
    The title of this event.
    
    .PARAMETER Start
    The start date of this event.
    
    .PARAMETER End
    The end date of this event.
    
    .PARAMETER AllDay
    Indicates if this event is an all day event.
    
    .PARAMETER Url
    The URL to navigate to when clicking on this event.
    #>
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(), 
        [Parameter(ParameterSetName = 'Title')]
        [string]$Title,
        [Parameter()]
        [DateTime]$Start = (Get-Date),
        [Parameter()]
        [DateTime]$End,
        [Parameter()]
        [Switch]$AllDay,
        [Parameter()]
        [string]$Url,
        [Parameter()]
        [string]$ClassName,
        [Parameter()]
        [string]$BackgroundColor,
        [Parameter()]
        [string]$BorderColor,
        [Parameter()]
        [string]$TextColor,
        [Parameter(ParameterSetName = 'Content')]
        [ScriptBlock]$Content
    )

    @{
        id              = $Id
        title           = $Title
        start           = $Start
        end             = if ($PSBoundParameters.ContainsKey('End')) { $End } else { $null }
        allDay          = $AllDay.IsPresent
        url             = $Url
        className       = $ClassName
        backgroundColor = $BackgroundColor
        borderColor     = $BorderColor
        textColor       = $TextColor
        content         = if ($Content) { & $Content } else { $null }
    }
}