
{store} = require '../store'
{TodoItem} = require './item'

exports.TodoList = React.createClass
  displayName: 'TodoList'

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
      TodoItem item: item, key: item.id
    $.div id: 'list',
      todoNodes
