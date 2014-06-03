
{store} = require './store'
{action} = require './action'

$ = React.DOM

TodoItem = React.createClass
  displayName: 'TodoItem'

  toggle: ->
    action.toggle @props.data.id
  edit: (event) ->
    text = event.target.value
    action.edit @props.data.id, text

  remove: ->
    action.remove @props.data.id

  componentDidMount: ->
    @refs.input.getDOMNode().focus()

  render: ->
    if @props.data.done
      className = 'todo-item done'
    else
      className = 'todo-item'
    $.div className: className,
      $.input
        className: 'todo-done'
        type: 'checkbox'
        checked: @props.data.done
        onChange: @toggle
      $.input
        className: \
          if @props.data.text.trim().length > 0
            'todo-text'
          else
            'todo-text empty'
        onChange: @edit
        value: @props.data.text
        ref: 'input'
      $.button
        className: 'todo-remove'
        onClick: @remove
        'rm'

TodoList = React.createClass
  displayName: 'TodoList'
  add: ->
    action.add()

  getInitialState: ->
    @data = store.get()
    @data

  componentDidMount: ->
    store.on 'change', =>
      @setState store.get()

  render: ->
    list = @state.list.sort (item) ->
      item.done + item.id
    length = list.filter (item) ->
      not item.done
    .length
    todoNodes = list.map (item) =>
      TodoItem data: item, key: item.id
    $.div id: 'page',
      $.div {},
        $.span id: 'add', onClick: @add,
          'Add'
        $.span id: 'count', length
      $.div id: 'todo-list',
        todoNodes

exports.TodoList = TodoList