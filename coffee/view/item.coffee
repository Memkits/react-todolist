
{store} = require '../store'

exports.TodoItem = React.createClass
  displayName: 'TodoItem'

  edit: (event) ->
    text = event.currentTarget.value
    store.edit @props.item.id, text

  componentDidMount: ->
    el = @refs.input.getDOMNode()
    if el.value.trim().length is 0
      el.focus()

  render: ->

    isDragging = @props.item.id is store.get().dragging

    $.div
      className: $.if isDragging,
        'todo-item dragging'
        'todo-item'
      onDragEnter: (event) =>
        store.sort @props.item.id
      $.input
        className: 'todo-text'
        ref: 'input'
        value: @props.item.text
        onChange: (event) =>
          store.edit @props.item.id, event.target.value
        onBlur: (event) =>
          text = event.target.value.trimLeft()
          if text.length is 0
            store.remove @props.item.id
        onKeyDown: (event) =>
          if event.keyCode is 27
            @blurEl()
      $.div
        className: 'drag'
        draggable: yes
        onDragStart: (event) =>
          store.mark 'dragging', @props.item.id
        onDragEnd: (event) =>
          store.move @props.item.id
          store.unmark 'dragging'
          store.unmark 'dest'

  blurEl: ->
    @refs.input.getDOMNode().blur()