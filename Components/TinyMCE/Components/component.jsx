import React, { useRef } from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import BundledEditor from './BundledEditor'

const UDComponent = props => {
  const editorRef = useRef(null);

  return (<BundledEditor
    onInit={(evt, editor) => editorRef.current = editor}
    {...props}
    onEditorChange={(value) => {
      if (props.onEditorChange) {
        props.onEditorChange(value)
      }
    }}
  />)
}

export default withComponentFeatures(UDComponent)