
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




# $ ->
#   toc = $ ".toc "
# 
#   toc.append parent = $ "<ul><l"
# 
# 
#   $("h1,h2,h3,h4,h5").each (e) ->
#     cb $(this).text()






