
events = require 'events'
uid = require './util/uid'

exports.store = store = new events.EventEmitter

store.data =
  list: []
  mode: 'todo' # 'later', 'done'
  drag: undefined
  sort: undefined
  dest: undefined

store.get = ->
  @data

store.findIndex = (id) ->
  for item, index in @data.list
    if item.id is id
      return id
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
      item = @findItem id
      item.mode = @data.dest
      @emit 'change'

store.sort = (id) ->
  if @data.sort?
    if @data.sort isnt id
      item = @findItem id
      index = @findIndex id
      sortItem = @findItem @data.sort
      sortIndex = @findIndex @data.sort
      data[index] = sortItem
      data[sortIndex] = item
      @emit 'change'

store.add = ->
  item =
    id: uid.make()
    text: ''
    mode: @data.mode

  @data.list.unshift item
  @emit 'change'

store.edit = (id, text) ->
  item = @findIndex id
  item.text = text
  @emit 'change'

store.count = (mode) ->
  @data.list.filter (item) =>
    item.mode is mode
  .length