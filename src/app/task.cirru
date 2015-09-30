
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign
  Immutable $ require :immutable

var
  configs $ require :../configs
  actions $ require :../actions

var
  ({}~ div input) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-task

  :propTypes $ {}
    :task $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired
    :index React.PropTypes.number.isRequired
    :isShown React.PropTypes.bool.isRequired

  :getInitialState $ \ ()
    {}
      :isEditing false
      :diffY 0
      :isTouching false

  :componentWillMount $ \ ()
    = @private $ {}

  :onClick $ \ (event)
    @setState
      {} (:isEditing true)

  :onBlur $ \ (event)
    @setState $ {}
      :isEditing false

  :onChange $ \ (event)
    actions.edit (@props.task.get :id) event.target.value

  :onTouchStart $ \ (event)
    var touch $ . event.touches 0
    = @private $ {}
      :y touch.screenY
      :x touch.screenX
      :index @props.index
    @setState $ {} (:isTouching true)

  :onTouchEnd $ \ (event)
    @setState $ {} (:isTouching false) (:diffY 0) (:diffX 0)

  :onTouchMove $ \ (event)
    event.preventDefault
    var touch $ . event.touches 0
    @setState $ {}
      :diffY $ - touch.screenY @private.y
      :diffX $ - touch.screenX @private.x

  :render $ \ ()
    cond @state.isEditing
      input
        {} (:ref input) (:style $ @styleRoot) (:onBlur @onBlur)
          :onChange @onChange
          :value $ @props.task.get :text
      div
        {} (:style $ @styleRoot) (:onClick @onClick)
          :onTouchStart @onTouchStart
          :onTouchMove @onTouchMove
          :onTouchEnd @onTouchEnd
        @props.task.get :text

  :styleRoot $ \ ()
    var top $ cond @props.isShown
      cond @state.isTouching
        +
          * @props.index configs.step
          , @state.diffY
        * @props.index configs.step
      , 0
    assign
      {}
        :color :white
        :fontFamily ":Verdana, sans-serif"
        :width :100%
        :lineHeight :40px
        :marginTop 20
        :padding ":0 20px"
        :outline :none
        :border :none
        :display :block
        :fontSize :14px
        :position :absolute
        :top top
        :left @state.diffX
      cond @props.isShown
        {}
          :opacity 1
        {}
          :opacity 0.1
      cond @state.isTouching
        {}
          :transitionDuration :0ms
        {}
          :transitionDuration :400ms
      cond @state.isEditing
        {}
          :backgroundColor $ ... (Color) (hsl 0 60 20 0.5) (hslString)
        {}
          :backgroundColor $ ... (Color) (hsl 0 60 40 0.5) (hslString)