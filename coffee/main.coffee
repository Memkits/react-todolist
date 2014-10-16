
React = require 'react'
$ = React.DOM

$.if = (cond, a, b) ->
  if cond then a else b
$.concat = (base, args...) ->
  list = [base]
  for item in args
    if item?
      list.push item
  list.join ' '

App = require './view/app'

store = require './store'

app = null
store.emit = ->
  app = App data: store.get()
  React.renderComponent app, document.body

store.emit()