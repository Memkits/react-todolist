
var
  todo $ require :./todo

= module.exports $ \ (store actionType actionData)
  case actionType
    :add
      todo.add store actionData
    :edit
      todo.edit store actionData
    :move
      todo.move store actionData
    :remove
      todo.remove store actionData
    :swap
      todo.swap store actionData
    else store
