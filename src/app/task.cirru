
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

var getBasePosition $ \ (mode)
  case mode
    :todo 0
    :later 100
    :done 200

= module.exports $ React.createClass $ {}
  :displayName :app-task

  :propTypes $ {}
    :task $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired
    :index React.PropTypes.number.isRequired
    :isShown React.PropTypes.bool.isRequired
    :onOrder React.PropTypes.func.isRequired
    :onContextMenu React.PropTypes.func.isRequired

  :getInitialState $ \ ()
    {}
      :diffY 0
      :isTouching false

  :componentWillMount $ \ ()
    = @private $ {}
      :initialX null
      :initialY null
      :index @props.index

  :onBlur $ \ (event)
    if (is event.target.value :) $ do
      actions.remove $ @props.task.get :id
    , undefined

  :onChange $ \ (event)
    actions.edit (@props.task.get :id) event.target.value

  :onTouchStart $ \ (event)
    var touch $ . event.touches 0
    = @private $ {}
      :initialTop $ * @props.index configs.step
      :initialY touch.screenY
      :initialX touch.screenX
    @setState $ {} (:isTouching true)

  :onTouchEnd $ \ (event)
    var position $ +
      getBasePosition $ @props.task.get :mode
      or @state.diffX 0
    var mode $ case true
      (< position 50) :todo
      (<= position 150) :later
      (>= position 150) :done
    actions.move (@props.task.get :id) mode
    @setState $ {} (:isTouching false) (:diffY 0) (:diffX 0)
    , undefined

  :onTouchMove $ \ (event)
    event.preventDefault
    var
      touch $ . event.touches 0
      diffY $ - touch.screenY @private.initialY
      diffX $ - touch.screenX @private.initialX
      offsetY $ - (+ diffY @private.initialTop) $ * @props.index configs.step

    @setState $ {} (:diffX diffX) (:diffY diffY)
    if (> (Math.abs offsetY) configs.step)
      do
        @props.onOrder (@props.task.get :id) @props.index offsetY
    , undefined

  :onContextMenu $ \ (event)
    @props.onContextMenu $ @props.task.get :id
    event.preventDefault

  :render $ \ ()
    input
      {} (:ref input) (:style $ @styleRoot)
        :onChange @onChange
        :onBlur @onBlur
        :value $ @props.task.get :text
        :autoFocus $ is (. (@props.task.get :text) :length) 0
        :onTouchStart @onTouchStart
        :onTouchMove @onTouchMove
        :onTouchEnd @onTouchEnd
        :onContextMenu @onContextMenu

  :styleRoot $ \ ()
    var top $ cond @props.isShown
      cond @state.isTouching
        + @private.initialTop @state.diffY
        * @props.index configs.step
      - 0 configs.step
    assign
      {}
        :color :white
        :fontFamily ":Verdana, sans-serif"
        :width :100%
        :lineHeight :40px
        :height :40px
        :marginTop 20
        :padding ":0 20px"
        :outline :none
        :border :none
        :display :block
        :fontSize :14px
        :position :absolute
        :top top
        :left $ cond @props.isShown @state.diffX 0
        :backgroundColor $ ... (Color) (hsl 0 40 40 0.4) (hslString)
      cond @props.isShown
        {}
          :opacity 1
        {}
          :opacity 0
      cond @state.isTouching
        {}
          :transitionDuration :0ms
        {}
          :transitionDuration :300ms
