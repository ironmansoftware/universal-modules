import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import { Legend } from 'recharts';

const UDComponent = props => {
    return <Legend {...props} />
}

export default withComponentFeatures(UDComponent)