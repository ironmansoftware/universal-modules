task MaterialDesign {
    $OutputPath = "$PSScriptRoot\Icons.MaterialDesign\output\Universal.Icons.MaterialDesign"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Icons.MaterialDesign\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Icons.MaterialDesign"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Icons.MaterialDesign\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Icons.MaterialDesign\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Icons.MaterialDesign\Universal.*.psm1 $OutputPath
}

task Feather {
    $OutputPath = "$PSScriptRoot\Icons.Feather\output\Universal.Icons.Feather"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Icons.Feather\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Icons.Feather"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Icons.Feather\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Icons.Feather\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Icons.Feather\Universal.*.psm1 $OutputPath
}

task Bootstrap {
    $OutputPath = "$PSScriptRoot\Icons.Bootstrap\output\Universal.Icons.Bootstrap"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Icons.Bootstrap\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Icons.Bootstrap"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Icons.Bootstrap\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Icons.Bootstrap\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Icons.Bootstrap\Universal.*.psm1 $OutputPath
}

task Tabler {
    $OutputPath = "$PSScriptRoot\Icons.Tabler\output\Universal.Icons.Tabler"
    Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\Icons.Tabler\public" -Force -ErrorAction SilentlyContinue -Recurse	
    Set-Location "$PSScriptRoot\Icons.Tabler"

    & {
        $ErrorActionPreference = 'SilentlyContinue'
        npm install
        npm run build
    }

    New-Item -Path $OutputPath -ItemType Directory

    Copy-Item $PSScriptRoot\Icons.Tabler\public\*.* $OutputPath
    Copy-Item $PSScriptRoot\Icons.Tabler\Universal.*.psd1 $OutputPath
    Copy-Item $PSScriptRoot\Icons.Tabler\Universal.*.psm1 $OutputPath
}

task Calendar {
    Invoke-Build -File "$PSScriptRoot\Calendar\component.build.ps1"
}

task Recharts {
    Invoke-Build -File "$PSScriptRoot\Recharts\component.build.ps1"
}

task TinyMCE {
    Invoke-Build -File "$PSScriptRoot\TinyMCE\component.build.ps1"
}

task Joyride {
    Invoke-Build -File "$PSScriptRoot\Joyride\component.build.ps1"
}


task . MaterialDesign, Feather, Bootstrap, Tabler, Calendar, TinyMCE, Recharts, Joyride