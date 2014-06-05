
events = require 'events'
uid = require './util/uid'

exports.store = store = new events.EventEmitter

store.data = list: []

store.get = ->
  @data

store.remove = (id) ->
  for item, index in @data.list
    if item.id is id
      @data.list.splice index, 1
      @emit 'change'
      break

store.toggle = (id) ->
  for item, index in @data.list
    if item.id is id
      item.done = not item.done
      @emit 'change'
      break

store.add = (data) ->
  data =
    id: uid.make()
    text: ''
    done: no
  @data.list.unshift data
  @emit 'change'

store.edit = (id, text) ->
  for item, index in @data.list
    if item.id is id
      console.log 'item.text', text
      item.text = text
      @emit 'change'
      break
