
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

  render: ->
    data = @props.data
    view = @
    if data.done
      className = 'todo-item todo-done'
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
          className: 'todo-text'
          onBlur: view.edit
          data.text

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
      item.done
    todoNodes = list.map (item) =>
      TodoItem data: item, key: item.id
    view = @
    dom ->
      @div className: 'page',
        @div id: 'page',
          @div id: 'add', onClick: view.add,
            'Add'
        @div id: 'todo-list',
          todoNodes

exports.TodoList = TodoList