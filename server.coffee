fs = require "fs"
express = require "express"
pile = require "pile"
request = require "request"
markdown = require "markdown-js"
jsdom = require("jsdom")
createjQuery = require('jQuery').create

app = express.createServer()

opts =
  urlRoot: "/node-pile/pile/"
  outputDirectory: __dirname + "/pile/min"

js = pile.createJSManager opts
css = pile.createCSSManager opts

asjQuery = (html, cb) ->
  jsdom.env html, [], (err, window) ->
    return cb? err if err
    cb null, jcreatejQuery window


app.configure ->
  js.bind app
  css.bind app

  css.addFile __dirname + "/style.styl"


js.addExec ->
  console.log  "Hello github pages!"

savePage = ->
  console.log "Start in production to save this page"


app.configure "production", ->
  savePage = (html) ->
    filePath = __dirname + "/index.html"
    fs.writeFile filePath, html, (err) ->
      throw err if err
      console.log "Wrote page to", filePath


app.configure "development", ->
  js.liveUpdate css



app.get "/", (req, res) ->
  request "https://raw.github.com/epeli/node-pile/master/README.md", (err, reqres, body) ->
    throw err if err
    res.render "index.jade",
      layout: false
      readme: markdown.makeHtml body
      body: 1233
    , (err, html) ->
      console.log err
      throw err if err

      # asjQuery html (err, $) ->
      #   console.log "KEE", $("h").html()

      # withIds = $("h1,h2,h3", html).each ->
      #   that = $ @
      #   that.attr "id", that.text().replace /[^a-zA-z]/g, ""
      # console.log "sdf", withIds.html()

      res.send html
      savePage html


app.listen 8080
