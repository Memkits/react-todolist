
var
  fs $ require :fs
  webpack $ require :webpack

= module.exports $ {}
  :entry $ {}
    :vendor $ []
      , :webpack-dev-server/client?http://repo:8080
      , :webpack/hot/dev-server
      , :react :immutable
    :main $ [] :./src/main

  :output $ {}
    :path :build/
    :filename :[name].js
    :publicPath :http://repo:8080/build/

  :resolve $ {}
    :extensions $ [] :.js :.cirru :

  :module $ {}
    :loaders $ []
      {} (:test /\.cirru$) (:loader :react-hot!cirru-script) (:ignore /node_modules)
      {} (:test "/\.(png|jpg|gif)$") (:loader :url-loader)
        :query $ {} (:limit 100)
      {} (:test /\.css$) $ :loader :style!css!autoprefixer
      {} (:test /\.json$) $ :loader :json

  :plugins $ []
    new webpack.optimize.CommonsChunkPlugin :vendor :vendor.js
