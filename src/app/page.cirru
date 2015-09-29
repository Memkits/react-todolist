
var
  React $ require :react
  Immutable $ require :immutable

var
  Layout $ React.createFactory $ require :./layout

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-page

  :propTypes $ {}
    :store $ . (React.PropTypes.instanceOf Immutable.List) :isRequired
    :core React.PropTypes.object.isRequired

  :styleRoot $ \ ()
    {}

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      Layout ({} (:store @props.store))
