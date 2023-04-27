import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import {
    LineChart,
    AreaChart,
    BarChart,
    CartesianGrid,
    Area,
    Legend,
    XAxis,
    YAxis,
    Line,
    Bar,
    PieChart,
    Pie,
    ScatterChart,
    Scatter,
    Tooltip
} from 'recharts';

const renderFeature = (feature, props) => {
    switch (feature) {
        case 'ud-rechart-axis':
            if (props.axis === 'x') {
                return <XAxis dataKey={props.dataKey} type={props.axisType} name={props.name} unit={props.unit} />
            } else {
                return <YAxis dataKey={props.dataKey} type={props.axisType} name={props.name} unit={props.unit} />
            }
        case 'ud-rechart-area':
            return <Area type={props.areaType} dataKey={props.dataKey} fill={props.fill} stroke={props.stroke} />
        case 'ud-rechart-legend':
            return <Legend />
        case 'ud-rechart-line':
            return <Line type={props.lineType} dataKey={props.dataKey} stroke={props.stroke} />
        case 'ud-rechart-bar':
            return <Bar dataKey={props.dataKey} fill={props.fill} />
        case 'ud-rechart-pie':
            return <Pie data={props.data} dataKey={props.dataKey} fill={props.fill} cx={props.cx} cy={props.cy} label={props.label} innerRadius={props.innerRadius} outerRadius={props.outerRadius} />
        case 'ud-rechart-scatter':
            return <Scatter data={props.data} name={props.name} fill={props.fill} />
        case 'ud-rechart-tooltip':
            return <Tooltip />
        default:

            return null;
    }
}

const UDComponent = props => {
    const chartProps = {
        width: props.width,
        height: props.height,
        data: props.data,
        margin: props.margin
    }

    const children = props.children.map((child) => renderFeature(child.type, child))

    switch (props.chartType) {
        case 'line':
            return <LineChart {...chartProps}>{children}</LineChart>
        case 'area':
            return <AreaChart {...chartProps}>{children}</AreaChart>
        case 'bar':
            return <BarChart {...chartProps}>{children}</BarChart>
        case 'pie':
            return <PieChart {...chartProps}>{children}</PieChart>
        case 'scatter':
            return <ScatterChart {...chartProps}>{children}</ScatterChart>

    }
}

export default withComponentFeatures(UDComponent)