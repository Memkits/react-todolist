
{store} = require './store'

$ = React.DOM
$.if = (cond, a, b) ->
  if cond then a else b

Sidebar = React.createClass
  displayName: 'Sidebar'
  render: ->
    $.div id: 'side-bar',
      'Sidebar'

TodoItem = React.createClass
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

TodoList = React.createClass
  displayName: 'TodoList'
  add: ->
    store.add()

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

AppView = React.createClass
  displayName: 'AppView'
  render: ->

    $.div id: 'app-view',
      Sidebar {}
      TodoList {}

exports.AppView = AppView