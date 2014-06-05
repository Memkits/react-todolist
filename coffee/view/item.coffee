
{store} = require '../store'

exports.TodoItem = React.createClass
  displayName: 'TodoItem'

  edit: (event) ->
    text = event.currentTarget.value
    store.edit @props.item.id, text

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->
    isEmpty = @props.item.text.trim().length is 0
    $.div
      className: 'todo-item'
      $.input
        className: $.if isEmpty,
          'todo-text empty'
          'todo-text'
        onChange: @edit
        ref: 'input'
        @props.item.text