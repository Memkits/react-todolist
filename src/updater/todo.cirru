
var
  schema $ require :../schema

= exports.add $ \ (store actionData)
  store.unshift $ schema.task.merge actionData

= exports.remove $ \ (store id)
  store.filterNot $ \ (task)
    is (task.get :id) id

= exports.move $ \ (store actionData)
  var
    id $ actionData.get :id
    mode $ actionData.get :mode
  store.map $ \ (task)
    cond (is (task.get :id) id)
      task.set :mode mode
      , task

= exports.swap $ \ (store actionData)
  var
    id1 $ actionData.get :id1
    id2 $ actionData.get :id2
    task1 $ store.find $ \ (task)
      is (task.get :id) id1
    task2 $ store.find $ \ (task)
      is (task.get :id) id2
  store.map $ \ (task)
    case (task.get :id)
      id1 task2
      id2 task1
      else task

= exports.edit $ \ (store actionData)
  var
    id $ actionData.get :id
    text $ actionData.get :text

  store.map $ \ (task)
    cond (is (task.get :id) id)
      task.set :text text
      , task

= exports.clear $ \ (store actionData)
  store.filterNot $ \ (task)
    is (task.get :mode) :done
