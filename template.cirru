
var
  stir $ require :stir-template
  ({}~ html head title meta link script body div) stir

var
  style $ stir.createFactory :style

= module.exports $ \ (data)
  return $ stir.render
    stir.doctype
    html null
      head null
        title null ":Todolist"
        meta $ {} (:charset :utf-8)
        link $ {} (:rel :icon)
          :href :png/do.png
        cond (not data.dev)
          link $ {} (:rel :stylesheet)
            :href data.style
          , undefined
        script $ {} (:src data.vendor) (:defer true)
        script $ {} (:src data.main) (:defer true)
        style null ":body * {box-sizing: border-box;}"
      body ({} (:style ":margin: 0;"))
