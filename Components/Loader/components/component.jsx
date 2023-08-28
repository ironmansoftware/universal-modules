import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'

import * as Loaders from 'react-spinners';

const UDComponent = props => {
    var loader = Loaders[props.loaderType + 'Loader']
    debugger
    return React.createElement(loader, props)
}

export default withComponentFeatures(UDComponent)