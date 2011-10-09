$ = jQuery

$.fn.generateToc = (from) ->
  toc = this
  prevDepth = 1

  $(from).each (e) ->
    depth = this.tagName[1]
    title = $(this).clone()
    title.children().remove()
    title = title.text()
    title = title.replace /\(.*\)/g, ""

    link = $ "<a>",
      text: title
      href: "#" + $(this).data "link"

    item = $ "<div>",
      class: "toc-item d#{depth}"


    toc.append item.append link


