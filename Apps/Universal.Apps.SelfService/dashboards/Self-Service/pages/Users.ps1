New-UDPage -Url "/Users" -Name "Users" -Content {
    New-UDAlert -Severity info -Text 'Manage users that have access to the Self-Service portal.'

    New-UDButton -Text 'Add New User' -Icon (New-UDIcon -Icon Plus) -OnClick {
        Show-UDModal -Content {
            New-UDForm -Children {
                New-UDTextbox -Label 'User Name' -HelperText 'The user name of the user.' -Id 'username'
                New-UDAutocomplete -Multiple -OnLoadOptions {
                    Get-PSUServiceGroup | Where-Object Name -Match $Body | Select-Object -ExpandProperty Name | ConvertTo-Json
                } -Label 'Service Groups'
                New-UDTypography -Variant caption -Text "Assign the user to serivce groups to provide them access to the services in the groups."
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


    $Users = Get-PSUIdentity 
    New-UDTable -Data $Users -Columns @(
        New-UDTableColumn -Property 'Name'
        New-UDTableColumn -Property 'Roles' -Render {
            $EventData.Roles | ForEach-Object {
                New-UDChip -Label $_
            }
        }
    )
}