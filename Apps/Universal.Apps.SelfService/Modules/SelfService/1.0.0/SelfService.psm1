$DataDirectory = Join-Path $Repository "data"
$ServiceGroupPath = Join-Path $DataDirectory "servicegroups.json"
$ServicePath = Join-Path $DataDirectory "services.json"

function New-PSUService {
    param(
        $Name,
        $Description,
        $ServiceGroup
    )

    $Service = @{
        Name = $Name
        Description = $Description
        ServiceGroup = $ServiceGroup
    }

    [Array]$Services = Get-PSUService
    $Services += $Service

    if (-not (Test-Path $DataDirectory)) {
        New-Item $DataDirectory -ItemType Directory | Out-Null
    }

    $Services | ConvertTo-Json | Out-File -FilePath $ServicePath
}

function Get-PSUService {
    if (-not (Test-Path $ServicePath)) {
        return
    }

    Get-Content $ServicePath | ConvertFrom-Json
}

function Remove-PSUService {
    param($Name)

    $Services = Get-PSUService | Where-Object Name -ne $Name
    $Services | ConvertTo-Json | Out-File -FilePath $ServicePath
}

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
    Get-PSURole -Name $Name | Remove-PSURole

    $ServiceGroups = Get-PSUServiceGroup | Where-Object Name -ne $Name
    $ServiceGroups | ConvertTo-Json | Out-File -FilePath $ServiceGroupPath
}