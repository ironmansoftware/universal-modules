$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

Get-ChildItem "$PSScriptRoot\*.bundle.js" | ForEach-Object {
    if ($_.Name -eq $IndexJS.Name) {
        return
    }
    [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName) | Out-Null
}


function New-UDTinyMCE {
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$InitialValue,
        [Parameter()]
        [Hashtable]$Init = @{},
        [Parameter()]
        [Endpoint]$OnEditorChange
    )

    End {

        if ($OnEditorChange) {
            $OnEditorChange.Register($Id, $PSCmdlet)
        }

        @{
            assetId        = $AssetId 
            isPlugin       = $true 
            type           = "ud-tinymce"
            id             = $Id

            initialValue   = $InitialValue
            init           = $init
            onEditorChange = $OnEditorChange
        }
    }
}