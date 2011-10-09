fs = require "fs"
express = require "express"
pile = require "pile"
markdown = require "markdown-js"
request = require "request"
parseGithubCode = require "./parsegithubcode"
asJQuery = require "./asjquery"

_  = require 'underscore'
_.mixin require 'underscore.string'


GithubRepo = require "./githubrepo"

port = 8080
repo = new GithubRepo "epeli", "node-pile"



app = express.createServer()

opts =
  urlRoot: "/#{ repo.name }/pile/"
  outputDirectory: __dirname + "/pile/min"

js = pile.createJSManager opts
css = pile.createCSSManager opts

app.configure ->
  js.bind app
  css.bind app


js.addFile __dirname + "/client/vendor/jquery.js"
js.addFile __dirname + "/client/vendor/highlight/highlight.pack.js"
js.addFile __dirname + '/client/addanchor.jquery.coffee'
js.addFile "main", __dirname + '/client/main.coffee'

css.addFile __dirname + "/client/vendor/highlight/styles/solarized_dark.css"
css.addFile __dirname + "/stylesheets/style.styl"


js.addExec -> $ ->
  hljs.initHighlightingOnLoad()

savePage = (html, cb) -> cb null

app.configure "production", ->
  savePage = (html, cb) ->
    filePath = __dirname + "/index.html"
    fs.writeFile filePath, html, (err) ->
      return cb? err if err
      cb? null
      console.log "Wrote page to", filePath


app.configure "development", ->
  js.liveUpdate css



postProcess = ($) ->

  $("h1,h2,h3,h4,h5").addAnchor()
  $(".version").text "docs for #{ repo.point }"
  $(".toc").generateToc("h2,h3,h4,h5")



app.get "/", (req, res) ->
  repo.getFile "README.md", (err, contents) ->
    throw err if err
    contents = parseGithubCode contents
    res.render "index.jade",
      layout: false
      readme: markdown.makeHtml contents
      body: 1233
    , (err, html) ->
      throw err if err
      asJQuery html, postProcess, (err, html) ->
        savePage html, (err) ->
          throw err if err
          res.send html




console.log "Loading the latest tag"
repo.useLatestTag (err, tag) ->
  if custom = process.argv[3]
    repo.point = custom

  throw err if err
  console.log "The tag is #{ tag }. Listening on http://127.0.0.1:#{ port }"
  app.listen 8080

app.on "listening", ->
  request "http://127.0.0.1:#{ port }", (err) ->
    throw err if err
    if process.argv[2] is "build" and process.env.NODE_ENV is "production"
      console.log "build static page succesfully"
      process.exit 0


