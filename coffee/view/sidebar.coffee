
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
    dest = store.get().dest

    $.div id: 'sidebar',
      $.div
        id: 'todo'
        className: if dest is 'todo' then 'drag-to'
        onClick: => store.mark 'mode', 'todo'
        onDragEnter: => store.mark 'dest', 'todo'
        onDragLeave: => store.unmark 'dest'
        $.span
          className: 'count'
          "#{countTodo}"
        'todo'
      $.div
        id: 'later'
        className: if dest is 'later' then 'drag-to'
        onClick: => store.mark 'mode', 'later'
        onDragEnter: => store.mark 'dest', 'later'
        onDragLeave: => store.unmark 'dest'
        $.span
          className: 'count'
          "#{countLater}"
        'later'
      $.div
        id: 'done'
        className: if dest is 'done' then 'drag-to'
        onClick: => store.mark 'mode', 'done'
        onDragEnter: => store.mark 'dest', 'done'
        onDragLeave: => store.unmark 'dest'
        $.span
          className: 'count'
          "#{countDone}"
        'done'