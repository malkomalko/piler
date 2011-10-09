$ = jQuery

$.fn.addAnchor = ->
  usedIds = {}
  @.each ->
    that = $ @
    id = $.trim that.text()
    id = id.replace /\ /g, "-"
    id = id.replace /[^\-a-zA-Z0-9]/g, ""
    finalId = id = id.toLowerCase()
    i = 1
    while usedIds[finalId]
      finalId = "#{ id }-#{ i }"
      i += 1

    # that.attr "id", finalId
    usedIds[finalId] = true
    that.append "<a class='anchor' href='##{ finalId }'>#</a>"
    that.before "<span class='anchor' id='#{ finalId }'> #{ finalId }  </span>"


