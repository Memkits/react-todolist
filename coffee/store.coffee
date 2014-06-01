

events = require 'events'

dispatcher = new events.EventEmitter
store = new events.EventEmitter

exports.dispatcher = dispatcher
exports.store = store

store.data =
  list: []

store.remove = (id) ->
  for item, index in @data.list
    if item.id is id
      @data.list.splice index, 1
      break

store.toggle = (id) ->
  for item, index in @data.list
    if item.id is id
      item.done = not item.done
      break

store.add = (data) ->
  @data.list.push data

store.edit = (id, text) ->
  for item, index in @data.list
    if item.id is id
      item.text = text
      break

store.get = ->
  @data

dispatcher.on 'add', (data) ->
  store.add data
  store.emit 'change'

dispatcher.on 'remove', (id) ->
  store.remove id
  store.emit 'change'

dispatcher.on 'toggle', (id) ->
  store.toggle id
  store.emit 'change'

dispatcher.on 'edit', (id, text) ->
  store.edit id, text
  store.emit 'change'