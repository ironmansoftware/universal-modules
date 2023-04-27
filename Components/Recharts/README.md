## PowerShell Universal App Recharts

A chart component built on Recharts for PowerShell Universal Apps. 

## Installation

You can install this component as a PowerShell module using PowerShellGet or via PowerShell Universal.

```powershell
Install-Module Universal.Components.Calendar
```

## Usage

### Area Chart

```powershell
$Data = "[
  {
    name: 'Page A',
    uv: 4000,
    pv: 2400,
    amt: 2400,
  },
  {
    name: 'Page B',
    uv: 3000,
    pv: 1398,
    amt: 2210,
  },
  {
    name: 'Page C',
    uv: 2000,
    pv: 9800,
    amt: 2290,
  },
  {
    name: 'Page D',
    uv: 2780,
    pv: 3908,
    amt: 2000,
  },
  {
    name: 'Page E',
    uv: 1890,
    pv: 4800,
    amt: 2181,
  },
  {
    name: 'Page F',
    uv: 2390,
    pv: 3800,
    amt: 2500,
  },
  {
    name: 'Page G',
    uv: 3490,
    pv: 4300,
    amt: 2100,
  },
]" | ConvertFrom-Json

New-UDRechart -Type 'Area' -Data $Data -Content {
        New-UDRechartAxis -Axis "x" -DataKey "name" -Type 'category'
        New-UDRechartAxis -Axis "y" -Type 'number'
        New-UDRechartLegend
        New-UDRechartArea -Type 'monotone' -DataKey 'uv' -stroke "#8884d8" -fill "#444fff" 
} -Height 500 -Width 500
```

### Bar Chart

```powershell
$Data = "[
  {
    name: 'Page A',
    uv: 4000,
    pv: 2400,
    amt: 2400,
  },
  {
    name: 'Page B',
    uv: 3000,
    pv: 1398,
    amt: 2210,
  },
  {
    name: 'Page C',
    uv: 2000,
    pv: 9800,
    amt: 2290,
  },
  {
    name: 'Page D',
    uv: 2780,
    pv: 3908,
    amt: 2000,
  },
  {
    name: 'Page E',
    uv: 1890,
    pv: 4800,
    amt: 2181,
  },
  {
    name: 'Page F',
    uv: 2390,
    pv: 3800,
    amt: 2500,
  },
  {
    name: 'Page G',
    uv: 3490,
    pv: 4300,
    amt: 2100,
  },
]" | ConvertFrom-Json

New-UDRechart -Type 'Bar' -Data $Data -Content {
        New-UDRechartAxis -Axis "x" -DataKey "name" -Type 'category'
        New-UDRechartAxis -Axis "y" -Type 'number'
        New-UDRechartLegend
        New-UDRechartBar -DataKey 'uv' -fill "#8884d8" 
        New-UDRechartBar -DataKey 'pv' -fill "#82ca9d" 
} -Height 500 -Width 500
```


### Line Chart

```powershell
$Data = "[
  {
    name: 'Page A',
    uv: 4000,
    pv: 2400,
    amt: 2400,
  },
  {
    name: 'Page B',
    uv: 3000,
    pv: 1398,
    amt: 2210,
  },
  {
    name: 'Page C',
    uv: 2000,
    pv: 9800,
    amt: 2290,
  },
  {
    name: 'Page D',
    uv: 2780,
    pv: 3908,
    amt: 2000,
  },
  {
    name: 'Page E',
    uv: 1890,
    pv: 4800,
    amt: 2181,
  },
  {
    name: 'Page F',
    uv: 2390,
    pv: 3800,
    amt: 2500,
  },
  {
    name: 'Page G',
    uv: 3490,
    pv: 4300,
    amt: 2100,
  },
]" | ConvertFrom-Json

New-UDRechart -Type 'Line' -Data $Data -Content {
        New-UDRechartAxis -Axis "x" -DataKey "name" -Type 'category'
        New-UDRechartAxis -Axis "y" -Type 'number'
        New-UDRechartLegend
        New-UDRechartLine -DataKey 'uv' -stroke "#8884d8" 
        New-UDRechartLine -DataKey 'pv' -stroke "#82ca9d" 
} -Height 500 -Width 500
```

### Pie Chart

```powershell
$data01 = "[
  { name: 'Group A', value: 400 },
  { name: 'Group B', value: 300 },
  { name: 'Group C', value: 300 },
  { name: 'Group D', value: 200 },
]" | ConvertFrom-Json

$data02 = "[
  { name: 'A1', value: 100 },
  { name: 'A2', value: 300 },
  { name: 'B1', value: 100 },
  { name: 'B2', value: 80 },
  { name: 'B3', value: 40 },
  { name: 'B4', value: 30 },
  { name: 'B5', value: 50 },
  { name: 'C1', value: 100 },
  { name: 'C2', value: 200 },
  { name: 'D1', value: 150 },
  { name: 'D2', value: 50 },
]" | ConvertFrom-Json

New-UDRechart -Type 'Pie' -Height 500 -Width 500 -Content {
  New-UDRechartPie -Data $data01 -dataKey 'value' -Cx '50%' -Cy '50%' -OuterRadius 60 -Fill "#8884d8"
  New-UDRechartPie -Data $data02 -dataKey 'value' -Cx '50%' -Cy '50%' -InnerRadius 70 -OuterRadius 90 -Fill "#82ca9d" -Label
}
```

### Scatter Chart

```powershell
$data = "[
  { x: 100, y: 200, z: 200 },
  { x: 120, y: 100, z: 260 },
  { x: 170, y: 300, z: 400 },
  { x: 140, y: 250, z: 280 },
  { x: 150, y: 400, z: 500 },
  { x: 110, y: 280, z: 200 },
]" | ConvertFrom-Json

New-UDRechart -Type 'Scatter' -Height 500 -Width 500 -Content {
  New-UDRechartTooltip
  New-UDRechartAxis -Axis "x" -DataKey "x" -Type 'number' -Name 'stature' -Unit 'cm'
  New-UDRechartAxis -Axis "y" -DataKey "y" -Type 'number' -Name 'weight' -Unit 'kg'
  New-UDRechartScatter -Name 'A school' -Data $data -Fill "#8884d8"
}
```

## Development

You will need NodeJS version 16.13.2 and the InvokeBuild module installed to build this module. 

You can run `Invoke-Build` within this directory to build this component.

```powershell
Invoke-Build
```

The output will be found within the output folder.