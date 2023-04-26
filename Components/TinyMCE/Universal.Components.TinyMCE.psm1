$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

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