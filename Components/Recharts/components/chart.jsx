import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import { AreaChart, CartesianGrid, Area, Legend, XAxis, YAxis } from 'recharts';

const renderFeature = (feature, props) => {
    switch (feature) {
        case 'ud-rechart-axis':
            if (props.axis === 'x') {
                return <XAxis dataKey={props.dataKey} />
            } else {
                return <YAxis />
            }
        case 'ud-rechart-area':
            return <Area type={props.areaType} dataKey={props.dataKey} fill={props.fill} stroke={props.stroke} />
        case 'ud-rechart-legend':
            return <Legend />
        default:

            return null;
    }
}

const UDComponent = props => {
    const children = props.render(props.children);

    return (
        <AreaChart
            width={props.width}
            height={props.height}
            data={props.data}
            margin={props.margin}
        >
            <CartesianGrid strokeDasharray="3 3" />
            {props.children.map((child) => renderFeature(child.type, child))}
        </AreaChart>
    );
}

export default withComponentFeatures(UDComponent)