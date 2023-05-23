function New-UDCenter {
    <#
    .SYNOPSIS
    Center items within a dashboard.
    
    .DESCRIPTION
    Center items within a dashboard.
    
    .PARAMETER Content
    The items to center. 
    
    .EXAMPLE
    New-UDCenter -Content {
        New-UDTypography -Text 'Loading groups' -Variant h5
        New-UDProgress -Circular
    }
    #>
    param([ScriptBlock]$Content)

    New-UDElement -tag div -Content $Content -Attributes @{
        style = @{
            textAlign = 'center'
            width     = '100%'
        }
    }
}

function New-UDRight {
    <#
    .SYNOPSIS
    Pull items to the right
    
    .DESCRIPTION
    Pull items to the right
    
    .PARAMETER Content
    The content to move to the right.
    #>
    [CmdletBinding()]
    param([ScriptBlock]$Content)

    New-UDElement -Tag 'div' -Content $Content -Attributes @{
        style = @{
            "display"         = "flex"
            "justify-content" = "flex-end"
            "margin-left"     = "auto"
            "margin-right"    = "0"
            "align-items"     = "flex-end"
        }
    }
}

function New-UDConfirm {
    <#
    .SYNOPSIS
    Shows a confirm object in a modal, returns either true or false.

    .DESCRIPTION
    Shows a confirm object in a modal, returns either true or false.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Text = 'Are you sure?'
    )
    $Session:Result = $null
    Show-UDModal -Content {
        New-UDTypography -Text $Text
    } -Footer {
        New-UDButton -Text "Yes" -OnClick {
            $Session:Result = $true
            Hide-UDModal
        } -Style @{"border-radius" = "4px" }

        New-UDButton -Text "No" -OnClick {
            $Session:Result = $false
            Hide-UDModal
        } -Style @{"border-radius" = "4px" }

    } -Persistent
    while ($Session:Result -eq $null) {
        Start-Sleep -Milliseconds 100
    }
    return $Session:Result
}

function New-UDLineBreak {
    <#
    .SYNOPSIS
    Adds a line break to the dashboard.
    #>
    New-UDElement -Tag 'div' -Content {
        New-UDElement -Tag 'br'
    }
}


function Show-UDEventData {
    <#
    .SYNOPSIS
    Shows the $EventData object as JSON in a modal.
    
    .DESCRIPTION
    Shows the $EventData object as JSON in a modal.
    #>
    Show-UDModal -Content {
        New-UDElement -Tag 'pre' -Content {
            ConvertTo-Json -InputObject $EventData
        }
    }
}

function Reset-UDPage { 
    <#
    .SYNOPSIS
    Reloads the current page.
    
    .DESCRIPTION
    Reloads the current page. This uses JavaScript directly.
    #>
    Invoke-UDJavaScript "window.location.reload()"
}


function Show-UDObject {
    <#
    .SYNOPSIS
    Shows an object's properties in a modal.
    
    .DESCRIPTION
    Shows an object's properties in a modal.
    
    .PARAMETER InputObject
    The object to show.
    
    .EXAMPLE
    $EventData | Show-UDObject # removes the array data
    Show-UDObject -InputObject $eventData # better way to view
    #>
    param(
        [Parameter(ValueFromPipeline, Mandatory)]
        $InputObject
    )

    process {
        # Show-UDModal {
        #     $Data = @()
        #     $InputObject | Get-Member -MemberType Property | ForEach-Object {
        #         $Data += [PSCustomObject]@{
        #             Key   = $_.Name
        #             Value = $InputObject."$($_.Name)"
        #         } 
        #     }

        #     New-UDTable -Data $Data
        # } -MaxWidth 'xl' -FullWidth
        Show-UDModal -Header {
            New-UDTypography -Text $($inputObject.gettype()) -Variant h4
        } -Content {
            # New-UDTypography -Text "Type: $($eventdata.gettype())"
            New-UDElement -Tag 'pre' -Content {
                ConvertTo-Json -InputObject $inputObject
            }
        }
    }
}

function Get-UDCache {
    <#
    .SYNOPSIS
    Returns all items in the $Cache: scope.
    
    .DESCRIPTION
    Returns all items in the $Cache: scope.
    #>
    [UniversalDashboard.Execution.GlobalCachedVariableProvider]::Cache
}

function Show-UDVariable {
    <#
    .SYNOPSIS
    Shows variables and their values in a modal.
    
    .DESCRIPTION
    Shows variables and their values in a modal.
    
    .PARAMETER Name
    A name. If not specified, all variables are returned.
    
    .EXAMPLE
    Show-UDVariable -Name 'EventData'
    #>
    param($Name)

    Show-UDModal -Content {
        New-UDDynamic -Content {
            $Variables = Get-Variable -Name "*$Name"  

            New-UDTable -Title 'Variables' -Icon (New-UDIcon -Icon 'SquareRootVariable') -Data $Variables -Columns @(
                New-UDTableColumn -Property Name -ShowFilter
                New-UDTableColumn -Property Value -Render {
                    [string]$EventData.Value
                } -ShowFilter
            ) -ShowPagination -ShowFilter
        } -LoadingComponent {
            New-UDSkeleton
        }

    } -Footer {
        New-UDButton -Text 'Close' -OnClick {
            Hide-UDModal
        }
    } -FullScreen
}

function Show-UDThemeColorViewer {
    <#
    .SYNOPSIS
    Shows all the theme colors in a modal.
    
    .DESCRIPTION
    Shows all the theme colors in a modal.
    #>
    Show-UDModal -Header {
        New-UDTypography -Variant h3 -Content {
            New-UDIcon -Icon  Images
            "Themes"
        }
    } -Content {
        New-UDDynamic -Content {
            New-UDRow -Columns {
                Get-UDTheme | ForEach-Object {
                    New-UDColumn -SmallSize 4 -Content {
                        $Theme = Get-UDTheme -Name $_

                        New-UDStack -Direction row -Content {
                            New-UDCard -Title "$_ - Light" -Content {
                                New-UDElement -Content {
                                    "Background"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.light.palette.text.primary
                                        backgroundColor = $Theme.light.palette.background.default
                                    }
                                }  -Tag 'div'

                                New-UDElement -Content {
                                    "Primary"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.light.palette.text.primary
                                        backgroundColor = $Theme.light.palette.primary.main
                                    }
                                }  -Tag 'div'

                                New-UDElement -Content {
                                    "Secondary"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.light.palette.text.primary
                                        backgroundColor = $Theme.light.palette.secondary.main
                                    }
                                } -Tag 'div'
                            }

                            New-UDCard -Title "$_ - Dark" -Content {
                                New-UDElement -Content {
                                    "Background"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.dark.palette.text.primary
                                        backgroundColor = $Theme.dark.palette.background.default
                                    }
                                }  -Tag 'div'

                                New-UDElement -Content {
                                    "Primary"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.dark.palette.text.primary
                                        backgroundColor = $Theme.dark.palette.primary.main
                                    }
                                }  -Tag 'div'

                                New-UDElement -Content {
                                    "Secondary"
                                } -Attributes @{
                                    style = @{
                                        color           = $Theme.dark.palette.text.primary
                                        backgroundColor = $Theme.dark.palette.secondary.main
                                    }
                                } -Tag 'div'
                            }
                        }



                        # $Theme.light.palette.background.default
                        # $Theme.light.palette.text.primary
                        # $Theme.light.palette.primary.main
                        # $Theme.light.palette.secondary.main

                        # $Theme.dark.palette.background.default
                        # $Theme.dark.palette.text.primary
                        # $Theme.dark.palette.primary.main
                        # $Theme.dark.palette.secondary.main
                    }
                }
            }
        } -LoadingComponent {
            New-UDSkeleton 
        }

    } -FullWidth -MaxWidth xl
}