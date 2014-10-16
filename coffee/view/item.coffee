
React = require 'react'
$ = React.DOM

store = require '../store'
config = require '../config'

module.exports = React.createClass
  displayName: 'TodoItem'

  getInitialState: ->
    dragging: no

  edit: (event) ->
    text = event.currentTarget.innerText
    store.edit @props.data.id, text

  componentDidMount: ->
    el = @refs.input.getDOMNode()
    if el.innerText.trim().length is 0
      el.focus()

  onDragStart: ->
    @setState dragging: yes
    @props.changeDragging @props.data.id

  onDragEnd: ->
    @setState dragging: no
    @props.changeDragging null

  onDragEnter: ->
    if @props.dragging isnt @props.data.id
      store.swap @props.data.id, @props.dragging

  onKeyUp: (event) ->
    store.edit @props.data.id, event.target.innerText

  onBlur: (event) ->
    text = event.target.innerText.trimLeft()
    if text.length is 0
      store.remove @props.data.id

  onKeyDown: (event) ->
    if event.keyCode is 27
      @refs.input.getDOMNode().blur()

  render: ->

    $.div
      contentEditable: yes
      draggable: yes
      ref: 'input'
      className: $.concat 'todo-item',
        if @state.dragging then 'dragging'
      onDragEnter: @onDragEnter
      onDragStart: @onDragStart
      onDragEnd: @onDragEnd
      onKeyUp: @onKeyUp
      onBlur: @onBlur
      onKeyDown: @onKeyDown
      style:
        top: "#{config.oneHeight * @props.index}px"
      @props.data.text
