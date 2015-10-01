
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign

var
  ({}~ div span) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-mode

  :propTypes $ {}
    :mode React.PropTypes.string.isRequired
    :isActive React.PropTypes.bool.isRequired
    :onClick React.PropTypes.func.isRequired
    :count React.PropTypes.number.isRequired

  :onClick $ \ ()
    @props.onClick @props.mode

  :render $ \ ()
    div
      {} (:style $ @styleRoot) (:onClick @onClick)
      , @props.mode
      span ({} (:style $ @styleNumber)) @props.count

  :styleRoot $ \ ()
    assign
      {}
        :color :white
        :fontFamily ":Verdana, sans-serif"
        :marginLeft 20
        :lineHeight :40px
        :textAlign :center
        :width :160px
        :cursor :pointer
        :transitionDuration :300ms
        :fontSize 14
      cond @props.isActive
        {}
          :backgroundColor $ ... (Color) (hsl 0 60 30 0.3) (hslString)
        {}
          :backgroundColor $ ... (Color) (hsl 0 60 30 0.1) (hslString)

  :styleNumber $ \ ()
    {}
      :fontSize :12px
      :marginLeft :10px
      :color $ ... (Color) (hsl 0 100 100 0.5) (hslString)
