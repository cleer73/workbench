Events = require 'events'
request = require 'request'
LayoutView = require './view/layout'

($ app.document).ready ->
  app.events = new Events.EventEmitter()

  layout = new LayoutView 'body'
  layout.render()

  #   # DEMO, pull all PR's for a given repo.
  #   ###
  #   url = 'https://api.github.com/repos/seomoz/magichat/pulls'
  #   opt =
  #     headers:
  #       'User-Agent': 'request'
  #     auth:
  #       user: 'GITHUB-AUTH-KEY-HERE'
  #       pass: 'x-oauth-basic'
  #       sendImmediately: true
  #   console.log request.get url, opt, (error, response, body)->
  #     console.log JSON.parse(body)
  #   ###
