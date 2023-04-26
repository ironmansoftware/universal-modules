# Universal.Notifications

A collection of functions for sending notifications in PowerShell Universal. 

## Send-PSUFailedJobEmail 

This notification can be used with a trigger to send a failed job email. You will need to configure the following variables for this to work. 

```powershell
New-PSUVariable -Name "EmailServer" -Value '' -Description "The SMTP server to use for email. " 
New-PSUVariable -Name "EmailUser" -Value '' -Description "The username for authenticaitng to your email server. " 
New-PSUVariable -Name "ToEmail" -Value '' -Description "The email address to send email notifications to. " 
New-PSUVariable -Name "FromEmail" -Value '' -Description "The email address to send notifications from." 
New-PSUVariable -Name "EmailPassword" -Vault "BuiltInLocalVault" -Description "The password for authenticating against the email server. "
```

Once the variables are configured, you can setup a trigger to send emails. 

```powershell
New-PSUTrigger -Name "Failed Job Email" -EventType "JobFailed" -TriggerScript "Universal.Notifications\Send-PSUFailedJobEmail"
```

## Send-PSUFailedJobSlackNotification

This command can be used with a trigger to send a failed job Slack notification. You will need to configure the following variables for this to work. 

```powershell
New-PSUVariable -Name "SlackUrl" -Description "The Slack web hook URL."
```


Once the variables are configured, you can setup a trigger to send notifications. 

```powershell
New-PSUTrigger -Name "Failed Job Slack Notification" -EventType "JobFailed" -TriggerScript "Universal.Notifications\Send-PSUFailedJobSlackNotification"
```

## Send-PSUFailedJobTeamsNotification

This command can be used with a trigger to send a failed job Microsoft Teams notification. You will need to configure the following variables for this to work. 

```powershell
New-PSUVariable -Name "TeamsUrl" -Description "The Microsoft teams web hook URL."
```

Once the variables are configured, you can setup a trigger to send notifications. 

```powershell
New-PSUTrigger -Name "Failed Job Teams Notification" -EventType "JobFailed" -TriggerScript "Universal.Notifications\Send-PSUFailedJobTeamsNotification"
```
