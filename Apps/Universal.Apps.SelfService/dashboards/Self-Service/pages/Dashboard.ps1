New-UDPage -Url "/dashboard" -Name "Dashboard" -Content {
    New-UDAlert -Severity info -Text "The self-service portal provides services based on your service groups."

    New-UDTextbox -Label 'Search...' -HelperText 'Search for services available in the portal.' -FullWidth

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
                            New-UDLink -Text $_.Name -Url "service/$($_.Id)"
                        }
                    }
                }
            }
        }
    }
} -DefaultHomePage -Title "Self-Service Dashboard" -BackgroundRepeat