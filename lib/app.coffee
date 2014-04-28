Events = require 'events'
request = require 'request'
LayoutView = require './view/layout'

($ app.document).ready ->
  app.events = new Events.EventEmitter()

  layout = new LayoutView 'body'
  layout.render()

  # # DEMO, pull all PR's for a given repo.
  # entity = "ENTITY-NAME" # A username or organization name
  # project = "PROJECT-NAME" # The name of the project
  # url = "https://api.github.com/repos/${entity}/#{project}/pulls"
  # opt =
  #   headers:
  #     'User-Agent': 'request'
  #   auth:
  #     user: 'GITHUB-AUTH-KEY-HERE'
  #     pass: 'x-oauth-basic'
  #     sendImmediately: true
  # console.log request.get url, opt, (error, response, body)->
  #   console.log JSON.parse(body)
