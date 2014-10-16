
React = require 'react'
$ = React.DOM

{store} = require '../store'

module.exports = React.createClass
  displayName: 'Group'

  render: ->
    dest = store.get().dest
    mode = store.get().mode
    isDragging = store.get().dragging?

    $.div
      id: @props.name
      className: $.concat 'dest',
        if dest is @props.name then 'drag-to'
        if mode is @props.name then 'highlight'
        if isDragging then 'is-dragging'
      onClick: => store.mark 'mode', @props.name
      onDragEnter: => store.mark 'dest', @props.name
      $.span
        className: 'count'
        store.count @props.name
      @props.children