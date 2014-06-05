
{store} = require '../store'
{TodoItem} = require './item'

exports.TodoList = React.createClass
  displayName: 'TodoList'
  add: ->
    store.add()

  getInitialState: ->
    store.get()

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
