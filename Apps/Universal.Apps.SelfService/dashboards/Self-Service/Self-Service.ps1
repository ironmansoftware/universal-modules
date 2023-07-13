Import-Module C:\ProgramData\UniversalAutomation\Repository\Modules\SelfService\1.0.0\SelfService.psm1 -Force

$Navigation = @(
     New-UDListItem -Label "Dashboard" -Href '/dashboard' -Icon (New-UDIcon -Icon 'Home')
     New-UDListItem -Label "Services" -Href '/services' -Icon (New-UDIcon -Icon 'Play')
     New-UDListItem -Label "Service Groups" -Href '/service-groups' -Icon (New-UDIcon -Icon 'LayerGroup')
     New-UDListItem -Label "Approvals" -Href '/approvals' -Icon (New-UDIcon -Icon 'CheckCircle')
     New-UDListItem -Label "History" -Href '/history' -Icon (New-UDIcon -Icon 'TimeLine')
     New-UDListItem -Label "Users" -Href '/users' -Icon (New-UDIcon -Icon 'Users')
     New-UDListItem -Label "Settings" -Href '/settings' -Icon (New-UDIcon -Icon 'Gear')
)

New-UDApp -Title 'Self-Service' -Pages @(
    Get-UDPage -Name 'Dashboard'
    Get-UDPage -Name 'Services'
    Get-UDPage -Name 'Service'
    Get-UDPage -Name 'Service Groups'
    Get-UDPage -Name 'Settings'
    Get-UDPage -Name 'Users'
    Get-UDPage -Name 'History'
    Get-UDPage -Name 'New Service'
) -Navigation $Navigation -NavigationLayout Permanent