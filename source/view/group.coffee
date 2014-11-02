
React = require 'react'
$ = React.DOM

store = require '../store'

module.exports = React.createFactory React.createClass
  displayName: 'Group'

  changeMode: ->
    @props.changeMode @props.name

  getInitialState: ->
    dragOver: no

  onDragEnter: ->
    @setState dragOver: yes

  onDragLeave: ->
    @setState dragOver: no

  onDragOver: (event) ->
    event.preventDefault()

  onDrop: ->
    store.move @props.dragging, @props.name
    @setState dragOver: no

  render: ->

    size = @props.data
    .filter (item) =>
      item.mode is @props.name
    .length

    $.div
      id: @props.name
      className: $.concat 'dest',
        if @state.dragOver then 'drag-to'
        if @props.mode is @props.name then 'highlight'
      onClick: @changeMode
      onDragEnter: @onDragEnter
      onDragLeave: @onDragLeave
      onDragOver: @onDragOver
      onDrop: @onDrop
      $.span
        className: 'count'
        size
      @props.children