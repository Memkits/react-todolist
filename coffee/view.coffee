
dom = require 'coffee-react-dom'

{store} = require './store'

TodoItem = React.createClass
  displayName: 'TodoItem'
  render: ->
    data = @props.data
    dom ->
      @div className: 'todo-item',
        @div className: 'todo-text', data.text
        @div className: 'todo-done', data.done.toString()

TodoList = React.createClass
  displayName: 'TodoList'
  render: ->
    data = store.get()
    todoNodes = data.map (item) =>
      TodoItem data: item
    dom ->
      @div className: 'todo-list',
        todoNodes

exports.TodoList = TodoList