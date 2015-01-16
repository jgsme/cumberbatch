React = require 'react'
{div, h1, p, button} = React.DOM
cumberbatch = require 'cumberbatch-name'

Container = React.createClass
  getInitialState: ->
    name: cumberbatch()

  onClick: -> @setState name: cumberbatch()

  styles:
    container:
      textAlign: 'center'
      fontFamily: 'Cutive Mono, monospace'
    p:
      fontSize: '5em'
    button:
      fontSize: '1em'
      color: '#fff'
      backgroundColor: '#555'
      border: '0'
      outline: '0'

  render: ->
    div {key: 'container', style: @styles.container}, [
      h1 {key: 'title'}, "What's Your Benedict Cumberbatch Name? Online"
      p {key: 'name', style: @styles.p}, @state.name
      button {onClick: @onClick, key: 'button', style: @styles.button}, 'Regenerate'
    ]

React.render React.createElement(Container), document.body
