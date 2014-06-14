
events = require 'events'
uid = require './util/uid'

exports.store = store = new events.EventEmitter

store.data =
  list: []
  mode: 'todo' # 'later', 'done'
  dragging: undefined
  dest: undefined

store.get = ->
  @data

store.findIndex = (id) ->
  for item, index in @data.list
    if item.id is id
      return index
  throw new Error "item #{id} not found"

store.findItem = (id) ->
  index = @findIndex id
  @data.list[index]

store.remove = (id) ->
  index = @findIndex id
  @data.list.splice index, 1
  @emit 'change'

store.move = (id) ->
  if @data.dest?
    if @data.dest isnt @data.mode
      index = @findIndex id
      item = @data.list.splice(index, 1)[0]
      item.mode = @data.dest
      @data.list.unshift item
      @emit 'change'

store.sort = (dest) ->
  if @data.dragging?
    if @data.dragging isnt dest
      a = @findIndex @data.dragging
      b = @findIndex dest
      d = @data.list
      [d[a], d[b]] = [d[b], d[a]]
      @emit 'change'

store.add = ->
  item =
    id: uid.make()
    text: ''
    mode: @data.mode

  @data.list.unshift item
  @emit 'change'

store.edit = (id, text) ->
  item = @findItem id
  item.text = text
  @emit 'change'

store.count = (mode) ->
  @data.list.filter (item) =>
    item.mode is mode
  .length

store.mark = (key, id) ->
  @data[key] = id
  @emit 'change'

store.unmark = (key) ->
  @data[key] = undefined
  @emit 'change'