task Build {
    $OutputPath = "$PSScriptRoot\output\Universal.Components.Joyright"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Universal.*.psm1 $OutputPath
}

task . Build