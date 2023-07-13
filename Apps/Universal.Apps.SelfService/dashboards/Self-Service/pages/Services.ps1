New-UDPage -Url "/Services" -Name "Services" -Content {
    New-UDAlert -Severity info -Text "Provide services to your end users."
    New-UDButton -Icon (New-UDIcon -Icon 'plus') -Text 'Create New Service' -OnClick {
        Invoke-UDRedirect "/new-service"
    }

    New-UDDynamic -Id 'services' -Content {
        $Services = Get-PSUService 
        New-UDTable -Data $Services -Columns @(
            New-UDTableColumn -Title 'Name' -Property 'Name'
            New-UDTableColumn -Title 'Description' -Property 'Description'
            New-UDTableColumn -Title 'Service Group' -Property 'ServiceGroup'
            New-UDTableColumn -Property 'Actions' -Render {
                New-UDButton -Text 'Delete' -Icon (New-UDIcon -Icon 'Trash') -OnClick {
                    Remove-PSUService -Name $EventData.Name
                    Sync-UDElement -I 'services'
                }
            }
        )
    }
} -Description "Manage services for the self-service portal." -DefaultHomePage -BackgroundRepeat