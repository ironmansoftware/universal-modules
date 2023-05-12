import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import Joyride from 'react-joyride';

const UDComponent = props => {
    return <Joyride {...props} key={props.id} />
}

export default withComponentFeatures(UDComponent)