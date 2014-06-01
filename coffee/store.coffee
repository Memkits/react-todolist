

events = require 'events'

dispatcher = new events.EventEmitter
store = new events.EventEmitter

exports.dispatcher = dispatcher
exports.store = store

store.data = []

store.remove = (id) ->
  for item, index in @data
    if item.id is id
      @data.splice index, 1
      break

store.toggle = (id) ->
  for item, index in @data
    if item.id is id
      @data.done = not @data.done
      break

store.get = ->
  @data

dispatcher.on 'add', (data) ->
  store.data.push data

dispatcher.on 'remove', (id) ->
  store.remove id

dispatcher.on 'toggle', (id) ->
  store.toggle id
