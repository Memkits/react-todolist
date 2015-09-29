
var
  React $ require :react
  Immutable $ require :immutable

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-layout

  :propTypes $ {}
    :store $ . (React.PropTypes.instanceOf Immutable.List) :isRequired

  :styleRoot $ \ ()
    {}

  :render $ \ ()
    div ({} (:style $ @styleRoot))
