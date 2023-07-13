New-UDPage -Url "/service/:service" -Name "Service" -Content {
    $Script = Get-PSUScript -Id $Service
    New-UDForm -Script $Script.FullPath
} -Title 'Service'