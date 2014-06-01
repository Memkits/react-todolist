
dom = require 'coffee-react-dom'

{store} = require './store'
{action} = require './action'

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
    data = @props.data
    view = @
    if data.done
      className = 'todo-item done'
    else
      className = 'todo-item'
    dom ->
      @div className: className,
        @input
          className: 'todo-done'
          type: 'checkbox'
          checked: data.done
          onChange: view.toggle
        @input
          className: \
            if data.text.trim().length > 0
              'todo-text'
            else
              'todo-text empty'
          onChange: view.edit
          value: data.text
          ref: 'input'
        @button
          className: 'todo-remove'
          onClick: view.remove
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
    view = @
    dom ->
      @div id: 'page',
        @div @,
          @span id: 'add', onClick: view.add,
            'Add'
          @span id: 'count', length
        @div id: 'todo-list',
          todoNodes

exports.TodoList = TodoList