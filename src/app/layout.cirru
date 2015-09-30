
var
  Color $ require :color
  React $ require :react
  Immutable $ require :immutable

var
  bg $ require :../../png/tulip.jpg
  Mode $ React.createFactory $ require :./mode
  Task $ React.createFactory $ require :./task

var
  ({}~ div) React.DOM

var modes $ [] :todo :later :done

= module.exports $ React.createClass $ {}
  :displayName :app-layout

  :propTypes $ {}
    :store $ . (React.PropTypes.instanceOf Immutable.List) :isRequired

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      div
        {} (:style $ @styleModes)
        modes.map $ \ (mode)
          Mode $ {} (:mode mode) (:key mode)
      div ({} (:style $ @styleList))
        @props.store.map $ \ (task)
          Task $ {} (:task task) (:key $ task.get :id)

  :styleRoot $ \ ()
    {} (:width ":100%") (:height ":100%") (:position :absolute)
      :overflow :auto
      :backgroundColor $ ... (Color) (hsl 0 50 50) (hslString)
      :backgroundImage $ + ":url(" bg ":)"
      :backgroundSize :cover
      :backgroundPosition ":center center"
      :display :flex
      :flexDirection :row
      :justifyContent :center
      :alignItems :flex-start

  :styleModes $ \ ()
    {}
      :width :20%

  :styleList $ \ ()
    {}
      :width :60%
      :height :100%
      :overflow :auto
