
var
  React $ require :react
  recorder $ require :actions-recorder
  Immutable $ require :immutable

var
  schema $ require :./schema
  updater $ require :./updater

var
  Page $ React.createFactory $ require :./app/page

require :../style/main.css
require :actions-recorder/style/actions-recorder.css

var initialStore schema.store

try
  do
    var raw $ localStorage.getItem :react-todolist
    var data $ JSON.parse (or raw :[])
    = initialStore $ ...
      Immutable.fromJS (or data ([]))
      filter $ \ (item) (? item)
  err

-- = window.onbeforeunload $ \ ()
  var raw $ JSON.stringify (recorder.getState)
  localStorage.setItem :react-todolist-dev raw

recorder.setup $ {}
  :initial initialStore
  :records (Immutable.List)
  :updater updater
  :inProduction true

var render $ \ (store core)
  React.render
    Page $ {} (:store store) (:core core)
    , document.body

recorder.request render
recorder.subscribe render
