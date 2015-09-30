
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign
  Immutable $ require :immutable

var
  actions $ require :../actions

var
  ({}~ div input) React.DOM

= module.exports $ React.createClass $ {}
  :displayName :app-task

  :propTypes $ {}
    :task $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired

  :getInitialState $ \ ()
    {}
      :isEditing false
      :diffY 0
      isTouching false

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
      :acc 0
      :y touch.screenY
    @setState $ {} (:isTouching true)

  :onTouchEnd $ \ (event)
    var touch $ . event.touches 0
    = @private.acc @state.diffY
    @setState $ {} (:isTouching false) (:diffY 0)

  :onTouchMove $ \ (event)
    event.preventDefault
    var touch $ . event.touches 0
    @setState $ {}
      :diffY $ + @private.acc $ - touch.screenY @private.y

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
    assign
      {}
        :color :white
        :fontFamily ":Verdana, sans-serif"
        :backgroundColor $ ... (Color) (hsl 0 60 40 0.5) (hslString)
        :lineHeight :40px
        :marginTop 20
        :padding ":0 20px"
        :outline :none
        :border :none
        :display :block
        :fontSize :14px
      cond @state.isTouching
        {}
          :transform $ + ":translate(0px, " @state.diffY :px ":)"
          :transitionDuration :0ms
        {}
          :transform $ + ":translate(0px, 0px)"
          :transitionDuration :400ms
