
request = require "request"
semver = require "semver"
_  = require 'underscore'


module.exports = class GithubRepo

  constructor: (@user, @name, @point) ->
    @cache = {}

  useLatestTag: (cb) ->
    request "http://github.com/api/v2/json/repos/show/#{ @user }/#{ @name }/tags", (err, reqress, body) =>
      return cb? err if err
      tags = _.map JSON.parse(body).tags, (hash, tag) -> tag
      tags.sort (a, b) -> semver.gt a, b
      @point =  _.last tags
      cb? null, @point


  getFile: (filename, cb) ->
    if not @point
      throw new Error "no point set for #{ @user }/#{ @name }"

    if contents = @cache[filename]
      return cb null, contents

    request "https://raw.github.com/#{ @user }/#{ @name }/#{ @point }/#{ filename }", (err, reqres, body) =>
      return cb? err if err
      @cache[filename] = body
      cb null, body
