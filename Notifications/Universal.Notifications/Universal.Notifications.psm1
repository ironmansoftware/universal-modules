function Send-PSUFailedJobEmail {
    param($Job)

    $JobId = $Job.Id
    $Script = $Job.ScriptFullPath
    $Message = "The job $JobId for script $Script failed."
    
    Email {
        EmailBody -FontFamily 'Calibri' -Size 15 {
            EmailTextBox {
                $Message
            }
            EmailHtml { 
                "<a href='$ApiUrl/admin/automation/jobs/$JobId'>View Job</a>"
            }
        }
    } -To $ToEmail -From $FromEmail -Server $EmailServer -Subject $Message -Username $EmailUser -Password $EmailPassword
}

function Send-PSUFailedJobSlackNotification {
    param($Job)

    if ($Job -eq $null) {
        return
    }

    $JobId = $Job.Id
    $Script = $Job.ScriptFullPath
    $Message = "The job $JobId for script $Script failed."
    $payload = @{
        text   = $Message
        blocks = @(
            @{
                type = "section"
                text = @{
                    type = "plain_text"
                    text = $Message
                }
            }
            @{
                type       = "actions"
                'block_id' = "actionblock123"
                elements   = @(
                    @{
                        type = "button"
                        text = @{
                            type = "plain_text"
                            text = "View Job"
                        }
                        url  = "$ApiUrl/admin/automation/jobs/$JobId"
                    }
                )
            }

        )
    } | ConvertTo-Json -Depth 10

    Invoke-RestMethod $SlackUrl -Body $payload -Method POST -ContentType 'application/json' | Out-Null
}