import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import { XAxis, YAxis } from 'recharts';

const UDComponent = props => {
    console.log(props)
    if (props.axis === 'x') {
        return <XAxis {...props} />
    } else {
        return <YAxis {...props} />
    }
}

export default withComponentFeatures(UDComponent)