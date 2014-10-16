
React = require 'react'
$ = React.DOM

Item = require './item'
Group = require './group'

store = require '../store'
config = require '../config'

module.exports = React.createClass
  displayName: 'AppView'

  getInitialState: ->
    mode: 'todo'
    dragging: null

  componentDidMount: ->
    document.body.addEventListener 'keydown', (event) =>
      if event.keyCode is 13
        event.preventDefault()
        @add()

  add: ->
    store.add @state.mode

  changeMode: (mode) ->
    @setState mode: mode

  changeDragging: (id) ->
    @setState dragging: id

  render: ->
    todoItems = @props.data
    .filter (item) =>
      item.mode is @state.mode
    .map (item, index) =>
      key: item.id
      item: Item
        index: index
        data: item, key: item.id
        dragging: @state.dragging, changeDragging: @changeDragging
    .sort (a, b) ->
      switch
        when a.key < b.key then -1
        when a.key > b.key then 1
        else 0
    .map (item) ->
      item.item

    minHeight = todoItems.length * config.oneHeight

    $.div id: 'app-view',
      $.div
        id: 'sidebar'
        Group
          name: 'todo', data: @props.data
          changeMode: @changeMode, mode: @state.mode
          dragging: @state.dragging
          'todo'
        Group
          name: 'later', data: @props.data
          changeMode: @changeMode, mode: @state.mode
          dragging: @state.dragging
          'later'
        Group
          name: 'done', data: @props.data
          changeMode: @changeMode, mode: @state.mode
          dragging: @state.dragging
          'done'
      $.div
        id: 'list'
        style:
          minHeight: minHeight
        if todoItems.length
          todoItems
        else
          $.div
            id: 'placeholder',
            onClick: @add
            'Hit Return to add.'