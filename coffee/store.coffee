
uid = require './util/uid'

store = []

try
  raw = localStorage.getItem 'react-todolist'
  store = (JSON.parse raw) or []

window.onbeforeunload = ->
  raw = JSON.stringify store
  localStorage.setItem 'react-todolist', raw

exports.emit = ->
  console.log 'emit!'

exports.get = ->
  store

exports.findIndex = (id) ->
  for item, index in store
    if item.id is id
      return index
  throw new Error "item #{id} not found"

exports.findItem = (id) ->
  index = @findIndex id
  store[index]

exports.remove = (id) ->
  index = @findIndex id
  store.splice index, 1
  @emit()

exports.move = (id, dest) ->
  index = @findIndex id
  item = store.splice(index, 1)[0]
  item.mode = dest
  store.unshift item
  @emit()

exports.swap = (dest, dragging) ->
  a = @findIndex dragging
  b = @findIndex dest
  d = store
  [d[a], d[b]] = [d[b], d[a]]
  @emit()

exports.add = (mode) ->
  item =
    id: uid.make()
    text: ''
    mode: mode

  store.unshift item
  @emit()

exports.edit = (id, text) ->
  item = @findItem id
  item.text = text
  @emit()
