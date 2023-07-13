New-UDPage -Url "/Settings" -Name "Settings" -Content {
    New-UDAlert -Severity info -Text "General settings for the Self-Service portal."
    New-UDForm -Children {
        New-UDTextbox -Id 'email_server' -Label 'Email Server' -HelperText "The SMTP server to use for sending emails from the Self-Service App"
        New-UDTextbox -Id 'email_user' -Label 'Email User' -HelperText "The SMTP server to use for sending emails from the Self-Service App"
        New-UDTextbox -Id 'email_password' -Label 'Email Password' -HelperText "The SMTP server to use for sending emails from the Self-Service App" -Type password
    } -OnSubmit {

    }
}