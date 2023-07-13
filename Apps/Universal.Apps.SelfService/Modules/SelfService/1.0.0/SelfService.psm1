$DataDirectory = Join-Path $Repository "data"
$ServiceGroupPath = Join-Path $DataDirectory "servicegroups.json"

function New-PSUServiceGroup {
    param(
        $Name,
        $Description
    )

    $ServiceGroup = @{
        Name = $Name 
        Description = $Description
    }

    New-PSUTag -Name $Name -Description $Description
    New-PSURole -Name $Name -Description $Description

    [Array]$ServiceGroups = Get-PSUServiceGroup
    $ServiceGroups += $ServiceGroup

    if (-not (Test-Path $DataDirectory)) {
        New-Item $DataDirectory -ItemType Directory | Out-Null
    }

    $ServiceGroups | ConvertTo-Json | Out-File -FilePath $ServiceGroupPath
}

function Get-PSUServiceGroup {
    if (-not (Test-Path $ServiceGroupPath)) {
        return
    }

    Get-Content $ServiceGroupPath | ConvertFrom-Json
}

function Remove-PSUServiceGroup {
    param($Name)

    Get-PSUTag -Name $Name | Remove-PSUTag
    #TODO: Get-PSURole -Name $Name | Remove-PSURole

    $ServiceGroups = Get-PSUServiceGroup | Where-Object Name -ne $Name
    $ServiceGroups | ConvertTo-Json | Out-File -FilePath $ServiceGroupPath
}