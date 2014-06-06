
{store} = require '../store'

exports.TodoItem = React.createClass
  displayName: 'TodoItem'

  edit: (event) ->
    text = event.currentTarget.value
    store.edit @props.item.id, text

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->

    $.div
      className: 'todo-item'
      $.div
        className: 'dragging'
      $.input
        className: 'todo-text'
        onChange: @edit
        ref: 'input'
        @props.item.text