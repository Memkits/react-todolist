
dom = require 'coffee-react-dom'

data = [
  text: 'just a'
  done: no
,
  text: 'just b'
  done: yes
]

TodoItem = React.createClass
  displayName: 'TodoItem'
  render: ->
    data = @props.data
    dom ->
      @div class: 'todo-item',
        @div class: 'todo-text', data.text
        @div class: 'todo-done', data.done.toString()

TodoList = React.createClass
  displayName: 'TodoList'
  render: ->
    todoNodes = data.map (item) =>
      TodoItem data: item
    dom ->
      @div class: 'todo-list',
        todoNodes

React.renderComponent (TodoList {}),
  document.querySelector('#app')