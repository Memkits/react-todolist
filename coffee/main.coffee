
window.$ = $ = React.DOM
$.if = (cond, a, b) ->
  if cond then a else b

{AppView} = require './view/app'

{store} = require './store'

try
  raw = localStorage.getItem 'react-todolist'
  store.data.list = (JSON.parse raw) or []
  store.emit 'change'

window.onbeforeunload = ->
  raw = JSON.stringify store.data.list
  localStorage.setItem 'react-todolist', raw

React.renderComponent (AppView {}),
  document.querySelector('#app')

document.body.addEventListener 'keydown', (event) ->
  if event.keyCode is 13
    if event.currentTarget is document.body
      store.add()