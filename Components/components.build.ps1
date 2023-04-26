task MaterialDesign {
    $OutputPath = "$PSScriptRoot\MaterialDesign\output\Universal.Icons.MaterialDesign"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\MaterialDesign\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\MaterialDesign"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\MaterialDesign\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\MaterialDesign\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\MaterialDesign\Universal.*.psm1 $OutputPath
}

task Feather {
    $OutputPath = "$PSScriptRoot\Feather\output\Universal.Icons.Feather"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Feather\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Feather"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Feather\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Feather\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Feather\Universal.*.psm1 $OutputPath
}

task Bootstrap {
    $OutputPath = "$PSScriptRoot\Bootstrap\output\Universal.Icons.Bootstrap"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Bootstrap\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Bootstrap"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Bootstrap\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Bootstrap\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Bootstrap\Universal.*.psm1 $OutputPath
}

task Tabler {
    $OutputPath = "$PSScriptRoot\Tabler\output\Universal.Icons.Tabler"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Tabler\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Tabler"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Tabler\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Tabler\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Tabler\Universal.*.psm1 $OutputPath
}

task Calendar {
    Invoke-Build "$PSScriptRoot\Calendar\component.build.ps1"
}

task . MaterialDesign, Feather, Bootstrap, Tabler, Calendar