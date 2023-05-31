function New-PowerGUIApp {
    New-UDDashboard -Title 'PowerGUI' -Content {
        # Force loading of DLLs
        Get-Service | Out-Null
        Get-LocalUser | Out-Null
    
        $LocalSystem = @{
            Name     = 'Local System'
            Children = @(
                @{
                    Name    = "Processes"
                    Icon    = "Microchip"
                    Command = { Get-Process }
                }
                @{
                    Name    = "Services"
                    Icon    = "Server"
                    Command = { Get-Service }
                }
                @{
                    Name                  = "Event Log"
                    Icon                  = "FileLines"
                    Command               = { Get-EventLog -List }
                    IncludeChildrenInTree = $true
                }
                @{
                    Name                  = 'Drives'
                    Icon                  = 'HardDrive'
                    Command               = { Get-PSDrive }
                    IncludeChildrenInTree = $true
                }
                @{
                    Name    = "Users"
                    Icon    = "User"
                    Command = { Get-LocalUser }
                }
                @{  
                    Name    = "Groups"
                    Icon    = "Users"
                    Command = { Get-LocalGroup }
                }
            )
            Types    = @(
                @{
                    Type    = [System.Diagnostics.Process]
                    Columns = @(
                        New-UDTableColumn -Property "handles" -Title "Handles"
                        New-UDTableColumn -Property "id" -Title "Id"
                        New-UDTableColumn -Property "name" -Title "Name"
                        New-UDTableColumn -Property "NPM" -Title "NPM(K)"
                        New-UDTableColumn -Property "CPU" -Title "CPU(S)"
                    )
                    Actions = @(
                        @{
                            Name   = "Stop Process"
                            Action = { Stop-Process -Id $Args[0].Id }
                        }
                    )
                }
                @{
                    Type    = [System.ServiceProcess.ServiceController]
                    Columns = @(
                        New-UDTableColumn -Property "status" -Title "Status"
                        New-UDTableColumn -Property "name" -Title "Name"
                        New-UDTableColumn -Property "displayName" -Title "Display Name"
                    )
                    Actions = @(
                        @{
                            Name   = "Start Service"
                            Action = { Stop-Service -Id $Args[0].Id }
                        }
                        @{
                            Name   = "Stop Service"
                            Action = { Stop-Service -Id $Args[0].Id }
                        }
                    )
                }
                @{
                    Type       = [System.Diagnostics.EventLog]
                    Columns    = @(
                        New-UDTableColumn -Property "log" -Title "Log"
                        New-UDTableColumn -Property "entries" -Title "Entries" -Render { $EventData.Entries.Count }
                        New-UDTableColumn -Property "size" -Title "Size" 
                        New-UDTableColumn -Property "max" -Title "Max"
                        New-UDTableColumn -Property "retain" -Title "Retain"
                        New-UDTableColumn -Property "OverflowAction" -Title "Overflow Action"
                    )
                    TreeNodeId = { $Args[0].log }
                    Command    = { Get-EventLog -Log $Args[0].Log -Newest 100 }
                }
                @{
                    Type    = [System.Diagnostics.EventLogEntry]
                    Columns = @(
                        New-UDTableColumn -Property "timewritten" -Title "Time Written" #-Render { New-UDDateTime -InputObject $EventData.TimeWritten }
                        New-UDTableColumn -Property "entryType" -Title "Entry Type"
                        New-UDTableColumn -Property "source" -Title "Source"
                        New-UDTableColumn -Property "message" -Title "Message"
                    )
                }
                @{
                    Type       = [System.Management.Automation.PSDriveInfo]
                    Columns    = @(
                        New-UDTableColumn -Property "name" -Title "Name"
                        New-UDTableColumn -Property "used" -Title "Used"
                        New-UDTableColumn -Property "free" -Title "Free"
                        New-UDTableColumn -Property "provider" -Title "Provider"
                        New-UDTableColumn -Property "root" -Title "Root"
                    )
                    TreeNodeId = { $Args[0].Root }
                    Command    = { Get-ChildItem -Path $Args[0].Root }
                }
                @{
                    Type       = [System.IO.FileInfo]
                    Columns    = @(
                        New-UDTableColumn -Property "name" -Title "Name"
                    )
                    TreeNodeId = { $Args[0].FullName }
                    Command    = { Get-ChildItem -Path $Args[0].FullName }
                }
                @{
                    Type         = [System.IO.DirectoryInfo]
                    Columns      = @(
                        New-UDTableColumn -Property "name" -Title "Name"
                    )
                    TreeNodeId   = { $Args[0].FullName }
                    Command      = { Get-ChildItem -Path $Args[0].FullName }
                    TreeChildren = { Get-ChildItem -Path $Args[0].FullName -Directory }
                }
                @{
                    Type    = [Microsoft.PowerShell.Commands.LocalUser]
                    Columns = @(
                        New-UDTableColumn -Property "name" -Title "Name"
                        New-UDTableColumn -Property "enabled" -Title "Enabled"
                        New-UDTableColumn -Property "description" -Title "Description"
                    )
                }
                @{
                    Type    = [Microsoft.PowerShell.Commands.LocalGroup]
                    Columns = @(
                        New-UDTableColumn -Property "name" -Title "Name"
                        New-UDTableColumn -Property "description" -Title "Description"
                    )
                }
            )
        }
    
        $Session:Nodes = [System.Collections.ArrayList]::new()
        
        New-UDRow -Columns {
            New-UDColumn -SmallSize 4 -LargeSize 2 -Content {
                New-UDCard -Title 'Navigation Tree' -Content {
                    New-UDTreeView -Node {
                        $LocalSystem.Children | ForEach-Object {
                            $Session:Nodes.Add($_) | Out-Null
                            New-UDTreeNode -Name $_.name -Id $_.Name -Icon (New-UDIcon -Icon $_.Icon) -ExpandedIcon (New-UDIcon -Icon $_.Icon) 
                        }
                    } -OnNodeClicked {
                        $Type = $null
                        $Item = $Session:Nodes | Where-Object { 
                            $ChildNode = $_
                            $Type = $LocalSystem.Types | Where-Object { $_.Type -eq $ChildNode.GetType() }
                            $_.Name -eq $EventData.Id -or ($Type.TreeNodeId -and (& $Type.TreeNodeId $_) -EQ $EventData.Id)
                        } 
    
                        $Session:SelectedNode = $Item 
    
                        Sync-UDElement 'resultView'
    
                        if ($Item.IncludeChildrenInTree) {
                            & $Item.Command $Item | ForEach-Object {
                                $Session:Nodes.Add($_) | Out-Null
                                $ChildNode = $_
                                $Type = $LocalSystem.Types | Where-Object { $_.Type -eq $ChildNode.GetType() }
                                $NodeId = & $Type.TreeNodeId $ChildNode
                                New-UDTreeNode -Icon (New-UDIcon -Icon $Item.Icon) -ExpandedIcon (New-UDIcon -Icon $Item.Icon) -Name $NodeId -Id $NodeId
                            }
                        }
    
                        if ($Type.TreeChildren) {
                            & $Type.TreeChildren $Item | ForEach-Object {
                                $Session:Nodes.Add($_) | Out-Null
                                $ChildNode = $_
                                $Type = $LocalSystem.Types | Where-Object { $_.Type -eq $ChildNode.GetType() }
                                $NodeId = & $Type.TreeNodeId $ChildNode
                                New-UDTreeNode -Icon (New-UDIcon -Icon $Item.Icon) -ExpandedIcon (New-UDIcon -Icon $Item.Icon) -Name $NodeId -Id $NodeId
                            }
                        }
                    }
                }
    
            }
            New-UDColumn -SmallSize 8 -LargeSize 8 -Content {
                New-UDDynamic -Id 'resultView' -Content {
                    New-UDCard -Title 'Results' -Content {
                        if ($Session:SelectedNode -eq $null) {
                            New-UDAlert -Text "Select a node"
                        }
                        else {
                            $Type = $LocalSystem.Types | Where-Object { $_.Type -eq $Session:SelectedNode.GetType() }
                            if ($Session:SelectedNode.Command) {
                                $Results = & $Session:SelectedNode.Command
                                $Type = $LocalSystem.Types | Where-Object { $_.Type -eq ($Results | Select-Object -First 1).GetType() }
                                $Results = $Results | Select-Object $Type.Columns.Field
                                $Columns = $Type.Columns
                                $Session:Actions = $Type.Actions
                                Sync-UDElement -Id 'actions'
                            }
                            else {
                                $Results = & $Type.Command $Session:SelectedNode
                                $Type = $LocalSystem.Types | Where-Object { $_.Type -eq ($Results | Select-Object -First 1).GetType() }
                                $Results = $Results | Select-Object $Type.Columns.Field
                                $Columns = $Type.Columns
                                $Session:Actions = $Type.Actions
                                Sync-UDElement -Id 'actions'
                            }
    
                            New-UDTable -Data $Results -Columns $Columns -ShowExport -ShowPagination -PageSize 10 -ShowSearch -ShowSelection -DisableMultiSelect -OnRowSelection {
                                $Session:SelectedItem = $EventData
                                Sync-UDElement -Id 'actions'
                            } -ToolbarContent {
                                New-UDButton -Icon (New-UDIcon -Icon 'Refresh') -Text 'Refresh' -OnClick {
                                    $Session:SelectedItem = $null
                                    Sync-UDElement -Id 'actions'
                                    Sync-UDElement -Id 'resultView'
                                } -ShowLoading
                            }
                        }
                    }
                } -LoadingComponent {
                    New-UDProgress 
                }
            }
            New-UDColumn -SmallSize 2 -LargeSize 2 -Content {
                New-UDDynamic -Id 'actions' -Content {
                    New-UDCard -Title 'Actions' -Content {
                        New-UDStack -Direction column -Children {
                            $Session:Actions | ForEach-Object {
                                if (-not $_) { return }
                                $Disabled = $null -eq $Session:SelectedItem
    
                                $ScriptBlock = $_.Action
                            
                                $Action = {
                                    & $ScriptBlock $Session:SelectedItem
                                    $Session:Results = & $Session:SelectedNode.Command
                                    $Session:SelectedItem = $null
                                    Sync-UDElement -Id 'actions'
                                    Sync-UDElement -Id 'resultView'
                                }
    
                                New-UDButton -Text $_.Name -OnClick $Action -Style @{
                                    margin = '10px'
                                } -Disabled:$Disabled
                            }
                        }
                    }
    
                }
            }
        }
    }
}