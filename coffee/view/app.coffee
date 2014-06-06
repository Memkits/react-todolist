
{Sidebar} = require './sidebar'
{TodoList} = require './list'

AppView = React.createClass
  displayName: 'AppView'
  render: ->
    $.div id: 'app-view',
      TodoList {}
      Sidebar {}

exports.AppView = AppView