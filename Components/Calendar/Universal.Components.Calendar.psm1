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
        [ValidateSet('dayGridYear', 'dayGridMonth', 'dayGridWeek', 'dayGridDay', 'timeGridWeek', 'timeGridDay', 'listWeek', 'listDay', 'listMonth', 'listYear', 'multiMonthYear')]
        [string]$View = "dayGridMonth",
        [Parameter()]
        [Switch]$HideWeekends,
        [Parameter()]
        [int[]]$HiddenDays = @(),
        [Parameter()]
        [Switch]$HideDayHeader,
        [Parameter()]
        [DateTime]$InitialDate = (Get-Date)
    )
    
    End {
        if ($DateClicked) {
            $DateClicked.Register($Id + "DateClicked", $PSCmdlet)
        }

        @{
            assetId     = $AssetId 
            isPlugin    = $true 
            type        = "ud-calendar"
            id          = $Id

            events      = $Events
            dateClicked = $DateClicked
            renderEvent = $RenderEvent
            weekends    = -not $HideWeekends.IsPresent
            hiddenDays  = $HiddenDays
            dayHeaders  = -not $HideDayHeader.IsPresent
            initialDate = $InitialDate
            view        = $View
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
        [Parameter()]
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
        [string]$TextColor
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
    }
}