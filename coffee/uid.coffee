
module.exports =
  _cache: 0
  _date: (new Date).getTime()
  make: ->
    @_cache += 1
    "_id#{@_date}-#{@_cache}"
