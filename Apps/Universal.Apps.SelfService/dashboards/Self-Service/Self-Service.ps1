Import-Module C:\ProgramData\UniversalAutomation\Repository\Modules\SelfService\1.0.0\SelfService.psm1 -Force

New-UDApp -Title 'Self-Service' -Pages @(
    Get-UDPage -Name 'Dashboard'
    Get-UDPage -Name 'Services'
    Get-UDPage -Name 'Service'
    Get-UDPage -Name 'Service Groups'
)