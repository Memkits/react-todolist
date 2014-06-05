
{Sidebar} = require './sidebar'
{TodoList} = require './list'

AppView = React.createClass
  displayName: 'AppView'
  render: ->
    $.div id: 'app-view',
      Sidebar {}
      TodoList {}

exports.AppView = AppView