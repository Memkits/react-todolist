
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
    list = @state.list
    .filter (item) =>
      item.mode is @state.mode
    length = list.filter (item) ->
      not item.done
    .length
    todoNodes = list.map (item) =>
      TodoItem item: item, key: item.id

    $.div
      id: 'list'
      onDragEnter: => store.unmark 'dest'
      $.if (todoNodes.length > 0),
        todoNodes
        $.div id: 'placeholder',
          'Press Enter to start...'