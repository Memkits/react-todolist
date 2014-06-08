
doctype

html
  head
    title Todolist
    meta (:charset utf-8)
    link (:rel stylesheet) (:href css/style.css)
    link (:rel icon) (:href png/do.png)
    @if (@ inDev) $ @block
      link (:rel stylesheet) (:href css/resource-dev.css)
      script (:src bower_components/react/react.js)
    @if (@ inBuild) $ @block
      link (:rel stylesheet) (:href css/resource-build.css)
      script (:src http://cdn.staticfile.org/react/0.10.0/react.min.js)
    script (:defer) (:src build/main.js)

  body#app