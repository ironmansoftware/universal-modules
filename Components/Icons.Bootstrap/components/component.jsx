import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import * as Icons from 'react-icons/bs';
import { IconContext } from 'react-icons/lib';
const UDComponent = props => {
    return <IconContext.Provider value={{ ...props }}>
        {React.createElement(Icons[props.icon])}
    </IconContext.Provider>
}

export default withComponentFeatures(UDComponent)