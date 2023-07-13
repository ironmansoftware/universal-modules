New-UDPage -Url "/New-Service" -Name "New Service" -Content {
    New-UDAlert -Text 'Create a new service for your users.' -Severity info
    New-UDForm -Children {
        New-UDTextbox -Id 'name' -Label 'Name' -HelperText 'The name of the service the end user will see.' -FullWidth
        New-UDTextbox -Id 'description' -Label 'Description' -HelperText 'The description of the service.' -FullWidth
        New-UDAutocomplete -Label 'Script' -Id 'script' -FullWidth
        New-UDTypography -Variant caption -Text "The script to run when the user invokes this service."
        New-UDSelect -Option {
            Get-PSUServiceGroup | ForEach-Object {
                New-UDSelectOption -Name $_.Name -Value $_.Name
            }
        } -Label 'Service Group' -FullWidth -Id 'ServiceGroup'
        New-UDTypography -Variant caption -Text "The service group that this service is associated with."
    } -OnSubmit {
        New-PSUService -Name $EventData.Name -Description $EventData.Description -ServiceGroup $EventData.ServiceGroup
        Invoke-UDRedirect "/services"
    }
}