
{store} = require '../store'

exports.Sidebar = React.createClass
  displayName: 'Sidebar'

  getInitaState: ->
    store.get()
  componentDidMount: ->
    store.on 'change', =>
      @setState store.get()

  render: ->
    countTodo = store.count 'todo'
    countLater = store.count 'later'
    countDone = store.count 'done'
    $.div id: 'sidebar',
      $.div id: 'todo',
        $.span className: 'count',
          "#{countTodo}"
        'todo'
      $.div id: 'later',
        $.span className: 'count',
          "#{countLater}"
        'later'
      $.div id: 'done',
        $.span className: 'count',
          "#{countDone}"
        'done'