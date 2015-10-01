
var
  React $ require :react
  Color $ require :color
  assign $ require :object-assign
  Immutable $ require :immutable

var
  actions $ require :../actions

var
  ({}~ div input) React.DOM
  modes $ [] :todo :later :done

= module.exports $ React.createClass $ {}
  :displayName :app-editor

  :propTypes $ {}
    :task $ . (React.PropTypes.instanceOf Immutable.Map) :isRequired
    :showTop React.PropTypes.bool.isRequired
    :onClose React.PropTypes.func.isRequired

  :onChange $ \ (event)
    actions.edit (@props.task.get :id) event.target.value

  :onModeChange $ \ (mode)
    actions.move (@props.task.get :id) mode

  :onClose $ \ ()
    @props.onClose

  :onTop $ \ ()
    actions.top (@props.task.get :id)

  :render $ \ ()
    div ({} (:style $ @styleRoot))
      div ({} (:style $ @styleBox))
        div ({} (:style $ @styleControl))
          div ({} (:style $ @styleButton) (:onClick @onClose)) :close
        input $ {} (:style $ @styleText)
          :value $ @props.task.get :text
          :onChange @onChange
        cond @props.showTop
          div ({} (:style $ @styleControl))
            div ({} (:style $ @styleButton) (:onClick @onTop)) :top
          , undefined
        div ({} (:style $ @styleControl))
          modes.map $ \\ (mode)
            var
              onClick $ \\ () (@onModeChange mode)
              isSelected $ is mode (@props.task.get :mode)
            div
              {} (:style $ @styleButton isSelected) (:onClick onClick)
                :key mode
              , mode

  :styleRoot $ \ ()
    {}
      :position :fixed
      :width :100%
      :height :100%
      :display :flex
      :flexDirection :row
      :justifyContent :center
      :alignItems :center
      :top 0
      :left 0
      :backgroundColor $ ... (Color) (hsl 0 10 10 0.8) (hslString)

  :styleBox $ \ ()
    {}
      :width :600px
      :height :200px

  :styleText $ \ ()
    {}
      :width :100%
      :height :40px
      :lineHeight :40px
      :fontSize :16px
      :fontFamily ":Verdana, Helvetica, sans-serif"
      :backgroundColor $ ... (Color) (hsl 0 30 40 0.3) (hslString)
      :border :none
      :outline :none
      :padding ":0 10px"
      :color :white

  :styleControl $ \ ()
    {}
      :display :flex
      :flexDirection :row
      :justifyContent :flex-end
      :margin :10px

  :styleButton $ \ (isSelected)
    assign
      {}
        :width :100px
        :height :40px
        :lineHeight :40px
        :marginLeft :20px
        :color :white
        :fontFamily ":Verdana, Helvetica, sans-serif"
        :fontSize :14px
        :textAlign :center
        :cursor :pointer
      cond isSelected
        {}
          :backgroundColor $ ... (Color) (hsl 0 10 80 0.4) (hslString)
        {}
          :backgroundColor $ ... (Color) (hsl 0 10 50 0.4) (hslString)
