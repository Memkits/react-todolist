
var
  shortid $ require :shortid
  recorder $ require :actions-recorder

= exports.add $ \ ()
  recorder.dispatch :add (shortid.generate)

= exports.remove $ \ (id)
  recorder.dispatch :remove id

= exports.edit $ \ (id text)
  recorder.dispatch :edit $ {}
    :id id
    :text text

= exports.move $ \ (id mode)
  recorder.dispatch :move $ {}
    :id :id
    :mode mode

= exports.swap $ \ (id1 id2)
  recorder.dispatch :swap $ {}
    :id1 id1
    :id2 id2
