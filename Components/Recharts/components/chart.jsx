import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import { AreaChart, ResponsiveContainer } from 'recharts';


const UDComponent = props => {
    return (
        <ResponsiveContainer width="100%" height="100%">
            <AreaChart
                width={props.width}
                height={props.height}
                data={props.data}
                margin={props.margin}
            >
                {props.render(props.children)}
            </AreaChart>
        </ResponsiveContainer>
    );
}

export default withComponentFeatures(UDComponent)