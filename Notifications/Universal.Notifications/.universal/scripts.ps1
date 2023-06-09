New-PSUScript -Module "Universal.Notifications" -Command "Send-PSUFailedJobEmail" -Description "Sends an email when a job fails." 
New-PSUScript -Module "Universal.Notifications" -Command "Send-PSUFailedJobSlackNotification" -Description "Sends a Slack notification when a job fails." 
New-PSUScript -Module "Universal.Notifications" -Command "Send-PSUFailedJobTeamsNotification" -Description "Sends a Microsoft Teams notification when a job fails." 
