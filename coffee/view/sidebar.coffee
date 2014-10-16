
React = require 'react'
$ = React.DOM

{store} = require '../store'

exports.Sidebar = React.createClass
  displayName: 'Sidebar'

  getInitaState: ->
    store.get()
  componentDidMount: ->
    store.on 'change', =>
      @setState store.get()

  render: ->
    countTodo = store.count 'todo'
    countLater = store.count 'later'
    countDone = store.count 'done'
    dest = store.get().dest
    mode = store.get().mode
    isDragging = store.get().dragging?

    $.div
      id: 'sidebar'
      $.div
        id: 'todo'
        className: $.concat 'dest',
          if dest is 'todo' then 'drag-to'
          if mode is 'todo' then 'highlight'
          if isDragging then 'is-dragging'
        onClick: => store.mark 'mode', 'todo'
        onDragEnter: => store.mark 'dest', 'todo'
        $.span
          className: 'count'
          "#{countTodo}"
        'todo'
      $.div
        id: 'later'
        className: $.concat 'dest',
          if dest is 'later' then 'drag-to'
          if mode is 'later' then 'highlight'
        onClick: => store.mark 'mode', 'later'
        onDragEnter: => store.mark 'dest', 'later'
        $.span
          className: 'count'
          "#{countLater}"
        'later'
      $.div
        id: 'done'
        className: $.concat 'dest',
          if dest is 'done' then 'drag-to'
          if mode is 'done' then 'highlight'
        onClick: => store.mark 'mode', 'done'
        onDragEnter: => store.mark 'dest', 'done'
        $.span
          className: 'count'
          "#{countDone}"
        'done'