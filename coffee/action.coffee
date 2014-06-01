
{dispatcher} = require './store'

id =
  _cache: 0
  _date: (new Date).getTime()
  make: ->
    @_cache += 1
    "_id#{@_date}-#{@_cache}"

exports.action = action =
  add: ->
    data =
      id: id.make()
      text: ''
      done: no
    dispatcher.emit 'add', data

  remove: (id) ->
    dispatcher.emit 'remove', id

  toggle: (id) ->
    dispatcher.emit 'toggle', id

  edit: (id, text) ->
    dispatcher.emit 'edit', id, text