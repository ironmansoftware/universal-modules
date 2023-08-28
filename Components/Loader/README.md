## PowerShell Universal App Recharts

23 loader components built on [react-spinners](https://www.davidhu.io/react-spinners/storybook/?path=/docs/barloader--main) for PowerShell Universal Apps. 

## Installation

You can install this component as a PowerShell module using PowerShellGet or via PowerShell Universal.

```powershell
Install-Module Universal.Components.Loader
```

## Usage

```powershell
  New-UDLayout -Columns 4 -Content {
      @(   
          New-UDLoader -Bar -Style @{ position = 'relative' }
          New-UDLoader -Beat -Style @{ position = 'relative' }
          New-UDLoader -Bounce -Style @{ position = 'relative' }
          New-UDLoader -Circle  -Style @{ position = 'relative' }
          New-UDLoader -ClimbingBox -Style @{ position = 'relative' }
          New-UDLoader -Clip -Style @{ position = 'relative' }
          New-UDLoader -Clock -Style @{ position = 'relative' }
          New-UDLoader -Dot -Style @{ position = 'relative' }
          New-UDLoader -Fade -Style @{ position = 'relative' }
          New-UDLoader -Grid -Style @{ position = 'relative' }
          New-UDLoader -Hash -Style @{ position = 'relative' }
          New-UDLoader -Moon -Style @{ position = 'relative' }
          New-UDLoader -Pacman -Style @{ position = 'relative' }
          New-UDLoader -Propagate -Style @{ position = 'relative' }
          New-UDLoader -Puff -Style @{ position = 'relative' }
          New-UDLoader -Pulse -Style @{ position = 'relative' }
          New-UDLoader -Ring -Style @{ position = 'relative' }
          New-UDLoader -Rotate -Style @{ position = 'relative' }
          New-UDLoader -Scale -Style @{ position = 'relative' }
          New-UDLoader -Skew -Style @{ position = 'relative' }
          New-UDLoader -Square -Style @{ position = 'relative' }
          New-UDLoader -Sync -Style @{ position = 'relative' }
      ) | ForEach-Object {
          New-UDElement -Content { $_ } -Tag 'div' -Attributes @{
              style = @{
                  height = "50px"
              }
          }
      }
  }
```

![](./loaders.gif)

## Development

You will need NodeJS version 16.13.2 and the InvokeBuild module installed to build this module. 

You can run `Invoke-Build` within this directory to build this component.

```powershell
Invoke-Build
```

The output will be found within the output folder.