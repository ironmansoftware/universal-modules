New-UDPage -Url "/dashboard" -Name "Dashboard" -Content {
    New-UDExpansionPanelGroup -Children {
        Get-PSUTag | Where-Object Name -NE "Self-Service" | ForEach-Object {
            if ($Roles -notcontains $_.Name) {
                return
            }

            New-UDExpansionPanel -Title $_.Name -Children {
                New-UDTypography -Text $_.Description
                New-UDRow -Columns {
                    Get-PSUScript -Tag $_.Name | ForEach-Object {
                        New-UDColumn -LargeSize 3 -Content {
                            New-UDCard -Title $_.Name -Text $_.Description 
                            New-UDLink -Text $_.Name -url "service/$($_.Id)"
                        }
                    }
                }
            }
        }
    }
} -Title "Self-Service Dashboard" -BackgroundRepeat $true