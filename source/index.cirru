
doctype

html
  head
    title Todolist
    meta (:charset utf-8)
    script(:src build/vendor.min.js)
    link (:rel icon) (:href png/do.png)
    @if (@ dev)
      @block
        link (:rel stylesheet) (:href source/main.css)
        link (:rel stylesheet) (:href source/dev.css)
        script (:defer) (:src build/main.js)
      @block
        link (:rel stylesheet) (:href build/main.min.css)
        script (:defer) (:src build/main.min.js)

  body
