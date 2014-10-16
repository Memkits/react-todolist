
doctype

html
  head
    title Todolist
    meta (:charset utf-8)
    script(:src dist/vendor.min.js)
    link (:rel icon) (:href png/do.png)
    @if (@ dev)
      @block
        link (:rel stylesheet) (:href css/main.css)
        link (:rel stylesheet) (:href css/dev.css)
        script (:defer) (:src build/main.js)
      @block
        link (:rel stylesheet) (:href dist/main.min.css)
        link (:rel stylesheet) (:href css/build.css)
        script (:defer) (:src dist/main.min.js)

  body#app
