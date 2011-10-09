
jQuery.fn.addAnchor = ->
  usedIds = {}
  @.each ->
    that = $ @
    id = that.text()
    id = id.replace /\ /g, "-"
    id = id.replace /[^\-a-zA-Z0-9]/g, ""
    id = id.toLowerCase()
    finalId = id
    i = 1
    while usedIds[finalId]
      finalId = "#{ id }-#{ i }"
      i += 1

    that.attr "id", finalId
    usedIds[finalId] = true
    that.append "<a class='anchor' href='##{ finalId }'>&para;</a>"

