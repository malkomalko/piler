
fs = require "fs"
jsdom = require "jsdom"

cs = require "coffee-script"
serverSidejQuery = fs.readFileSync(__dirname + '/client/vendor/jquery.js').toString()
serverSidejQuery += cs.compile fs.readFileSync(__dirname + '/client/addanchor.jquery.coffee').toString()
serverSidejQuery += cs.compile fs.readFileSync(__dirname + '/client/generatetoc.jquery.coffee').toString()

asJQuery = (html, modifier, cb) ->
  jsdom.env html: html, src: [serverSidejQuery], done: (err, window) ->
    return cb? err if err

    if typeof modifier is "function"
      modifier window.$
    else
      for mod in modifier
        mod window.$

    doctype = (window.document.doctype or '') + "\n"
    cb? null, doctype + window.document.documentElement.outerHTML

module.exports = asJQuery
