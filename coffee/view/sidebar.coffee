
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
    isTodo = dest is 'todo'
    isLater = dest is 'later'
    isDone = dest is 'done'

    $.div
      id: 'sidebar'
      $.div
        id: 'todo'
        className: $.if isTodo,
          'dest drag-to'
          'dest'
        onClick: => store.mark 'mode', 'todo'
        onDragEnter: => store.mark 'dest', 'todo'
        $.span
          className: 'count'
          "#{countTodo}"
        'todo'
      $.div
        id: 'later'
        className: $.if isLater,
          'dest drag-to'
          'dest'
        onClick: => store.mark 'mode', 'later'
        onDragEnter: => store.mark 'dest', 'later'
        $.span
          className: 'count'
          "#{countLater}"
        'later'
      $.div
        id: 'done'
        className: $.if isDone,
          'dest drag-to'
          'dest'
        onClick: => store.mark 'mode', 'done'
        onDragEnter: => store.mark 'dest', 'done'
        $.span
          className: 'count'
          "#{countDone}"
        'done'