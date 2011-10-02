fs = require "fs"
express = require "express"
pile = require "pile"

app = express.createServer()

js = pile.createJSManager
  outputDirectory: __dirname + "/pile/min"
css = pile.createCSSManager
  outputDirectory: __dirname + "/pile/min"

app.configure ->
  js.bind app
  css.bind app

  css.addFile __dirname + "/style.styl"


js.addExec ->
  alert "Hello github pages!"

savePage = ->
  console.log arguments
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
  res.render "index.jade",
    layout: false
    body: 1233
  , (err, html) ->
    throw err if err
    res.send html
    savePage html


app.listen 8080
