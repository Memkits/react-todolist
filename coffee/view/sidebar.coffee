
React = require 'react'
$ = React.DOM

{store} = require '../store'

Group = require './group'

exports.Sidebar = React.createClass
  displayName: 'Sidebar'

  getInitaState: ->
    store.get()
  componentDidMount: ->
    store.on 'change', =>
      @setState store.get()

  render: ->

    $.div
      id: 'sidebar'
      Group name: 'todo',
        'todo'
      Group name: 'later',
        'later'
      Group name: 'done',
        'done'