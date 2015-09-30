
var
  React $ require :react
  Color $ require :color

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-mode

  :propTypes $ {}
    :mode React.PropTypes.string.isRequired

  :styleRoot $ \ ()
    {}
      :color :white
      :fontSize 20
      :fontFamily ":Verdana, sans-serif"
      :marginTop 20
      :lineHeight :40px
      :backgroundColor $ ... (Color) (hsl 0 60 30 0.5) (hslString)
      :textAlign :center
      :width :160px

  :render $ \ ()
    div ({} (:style $ @styleRoot)) @props.mode
