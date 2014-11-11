
React = require 'react'
$ = React.DOM

store = require '../store'
config = require '../config'

module.exports = React.createFactory React.createClass
  displayName: 'TodoItem'

  getInitialState: ->
    dragging: no

  edit: (event) ->
    text = event.currentTarget.value
    store.edit @props.data.id, text

  componentDidMount: ->
    el = @refs.input.getDOMNode()
    if el.value.trim().length is 0
      el.focus()

  onDragStart: (event) ->
    @setState dragging: yes
    @props.changeDragging @props.data.id

  onDragEnd: ->
    @setState dragging: no
    @props.changeDragging null

  onDragEnter: ->
    if @props.dragging isnt @props.data.id
      store.swap @props.data.id, @props.dragging

  onChange: (event) ->
    store.edit @props.data.id, event.target.value

  onBlur: (event) ->
    text = event.target.value.trimLeft()
    if text.length is 0
      store.remove @props.data.id

  onKeyDown: (event) ->
    if event.keyCode is 27
      @refs.input.getDOMNode().blur()

  render: ->

    $.div
      draggable: yes
      className: $.concat 'todo-item',
        if @state.dragging then 'dragging'
      onDragEnter: @onDragEnter
      onDragStart: @onDragStart
      onDragEnd: @onDragEnd
      style:
        top: "#{config.oneHeight * @props.index}px"
      $.input
        ref: 'input'
        onChange: @onChange
        onBlur: @onBlur
        onKeyDown: @onKeyDown
        value: @props.data.text
