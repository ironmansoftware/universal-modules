import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import * as MDIcons from 'react-icons/md';
import { IconContext } from 'react-icons/lib';
const UDComponent = props => {
    return <IconContext.Provider value={{ ...props }}>
        {React.createElement(MDIcons[props.icon])}
    </IconContext.Provider>
}

export default withComponentFeatures(UDComponent)