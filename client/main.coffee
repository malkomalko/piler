
className = "selected"
gotoAnchor = ->
  id = window.location.hash
  console.log "adding to", $(id), "removing form", this
  $(".#{ className }").removeClass className
  elem = $(id).next().addClass className
  setTimeout ->
    elem.removeClass className
  , 500

$ ->
  $(window).bind "hashchange", gotoAnchor
  gotoAnchor()












