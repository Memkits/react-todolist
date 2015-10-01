
var
  Color $ require :color
  React $ require :react
  Immutable $ require :immutable

var
  configs $ require :../configs
  actions $ require :../actions

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

  :getInitialState $ \ ()
    {} (:mode :todo)

  :getVisibleTasks $ \ ()
    ... @props.store
      filter $ \\ (task)
        is (task.get :mode) @state.mode

  :onModeChange $ \ (mode)
    @setState $ {} (:mode mode)

  :onOrder $ \ (id index diffY)
    var
      steps $ cond (> diffY 0)
        Math.floor (/ diffY configs.step)
        Math.ceil (/ diffY configs.step)
      visibleTasks (@getVisibleTasks)
      target $ visibleTasks.get $ + index steps
    if (? target) $ do
      actions.swap id (target.get :id)
    , undefined

  :onMove $ \ (id diffX)
    console.log diffX

  :render $ \ ()
    var
      visibleTasks (@getVisibleTasks)

    div ({} (:style $ @styleRoot))
      div
        {} (:style $ @styleModes)
        modes.map $ \\ (mode)
          Mode $ {} (:mode mode) (:key mode)
            :isActive $ is mode @state.mode
            :onClick @onModeChange
      div ({} (:style $ @styleList))
        ... @props.store
          map $ \\ (task)
            var index
              visibleTasks.indexOf task
            Task $ {} (:task task) (:key $ task.get :id) (:index index)
              :isShown $ is (task.get :mode) @state.mode
              :onOrder @onOrder
              :onMove @onMove
          sortBy $ \ (el) el.key

  :styleRoot $ \ ()
    {} (:width ":100%") (:height ":100%") (:position :absolute)
      :overflow :auto
      :backgroundColor $ ... (Color) (hsl 0 50 50) (hslString)
      :backgroundImage $ + ":url(" bg ":)"
      :backgroundSize :cover
      :backgroundPosition ":center center"
      :padding ":40px 200px"

  :styleModes $ \ ()
    {}
      :display :flex
      :flexDirection :row
      :justifyContent :flex-end
      :marginBottom 40

  :styleList $ \ ()
    var
      visibleTasks (@getVisibleTasks)
    {}
      :overflow :visible
      :position :relative
      :height $ * (+ configs.height configs.space) visibleTasks.size
