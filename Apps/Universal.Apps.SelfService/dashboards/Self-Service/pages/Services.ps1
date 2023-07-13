New-UDPage -Url "/Services" -Name "Services" -Content {
    $Scripts = Get-PSUScript 
    New-UDTable -Data $Scripts
} -Description "Manage services for the self-service portal." -BackgroundRepeat $true