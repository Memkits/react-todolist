
{store} = require '../store'

exports.TodoItem = React.createClass
  displayName: 'TodoItem'

  edit: (event) ->
    text = event.currentTarget.value
    store.edit @props.item.id, text

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->

    isDragging = @props.item.id is store.get().dragging

    $.div
      className: 'todo-item'
      onDragEnter: (event) =>
        store.sort @props.item.id
      $.div
        className: $.if isDragging,
          'drag dragging'
          'drag'
        draggable: yes
        onDragStart: (event) =>
          store.mark 'dragging', @props.item.id
        onDragEnd: (event) =>
          store.unmark 'dragging', @props.item.id
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