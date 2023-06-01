# Active Directory Roles

Generates and assigns roles based on Active Directory groups.

## Installation

Installing this module will invoke `Get-ADGroup` against the current domain in PowerShell Universal. For each group found, a role will be created and automatically assigned to users via claim to role mapping. 

## Requirements

- PowerShell Universal v4
- Active Directory Module 
- Windows Authentication