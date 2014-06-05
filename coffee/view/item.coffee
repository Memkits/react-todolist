
{store} = require '../store'

exports.TodoItem = React.createClass
  displayName: 'TodoItem'

  toggle: ->
    store.toggle @props.data.id
  edit: (event) ->
    text = event.target.value
    store.edit @props.data.id, text

  remove: ->
    store.remove @props.data.id

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->
    isEempty = @props.data.text.trim().length is 0
    isDone = @props.data.done
    $.div
      className: $.if isDone,
        'todo-item done'
        'todo-item'
      $.input
        className: 'todo-done'
        type: 'checkbox'
        checked: @props.data.done
        onChange: @toggle
      $.input
        className: $.if isEempty,
          'todo-text empty'
          'todo-text'
        onChange: @edit
        value: @props.data.text
        ref: 'input'
      $.button
        className: 'todo-remove'
        onClick: @remove
        'rm'
