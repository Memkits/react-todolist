
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign

var
  ({}~ div) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-mode

  :propTypes $ {}
    :mode React.PropTypes.string.isRequired
    :isActive React.PropTypes.bool.isRequired
    :onClick React.PropTypes.func.isRequired

  :onClick $ \ ()
    @props.onClick @props.mode

  :render $ \ ()
    div
      {} (:style $ @styleRoot) (:onClick @onClick)
      , @props.mode

  :styleRoot $ \ ()
    assign
      {}
        :color :white
        :fontFamily ":Verdana, sans-serif"
        :marginLeft 20
        :lineHeight :40px
        :backgroundColor $ ... (Color) (hsl 0 60 30 0.2) (hslString)
        :textAlign :center
        :width :160px
        :cursor :pointer
        :transitionDuration :300ms
      cond @props.isActive
        {}
          :fontSize 20
        {}
          :fontSize 14
