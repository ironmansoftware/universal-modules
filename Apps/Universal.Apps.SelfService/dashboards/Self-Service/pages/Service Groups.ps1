New-UDPage -Url "/Service-Groups" -Name "Service Groups" -Content {
    New-UDAlert -Severity info -Text 'Service Groups allow you to group together services and assign those services to users.'
     
    New-UDButton -Text 'Create New Service Group' -Icon (New-UDIcon -Icon Users) -OnClick {
        Show-UDModal -Content {
            New-UDForm -Children {
                New-UDTextbox -Label 'Name' -HelperText 'The name of the Service Group.' -Id 'name'
                New-UDTextbox -Label 'Description' -HelperText 'A description for the Service Group.' -Id 'description'
                New-UDUpload -Text 'Image'
                New-UDTypography -Text "An image is optional" -Variant caption
            } -OnSubmit {
                New-PSUServiceGroup -Name $EventData.Name -Description $EventData.Description
                Sync-UDElement -Id 'serviceGroups'
                Hide-UDModal
            } -SubmitText "Create" -OnCancel {
                Hide-UDModal
            }
        } -Header {
            New-UDTypography -Variant h5 -Text "Create New Service Group"
        }
    }

    New-UDDynamic -Id 'serviceGroups' -Content {
        $ServiceGroups = Get-PSUServiceGroup 
        New-UDTable -Data $ServiceGroups -Columns @(
            New-UDTableColumn -Title 'Name' -Property 'Name'
            New-UDTableColumn -Title 'Description' -Property 'Description'
            New-UDTableColumn -Property 'Actions' -Render {
                New-UDButton -Text 'Delete' -Icon (New-UDIcon -Icon 'Trash') -OnClick {
                    Remove-PSUServiceGroup -Name $EventData.Name
                    Sync-UDElement -I 'serviceGroups'
                }
            }
        )
    }
}