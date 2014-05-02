Events = require 'events'

UUID = require 'node-uuid'
Handlebars = require 'handlebars'

module.exports = class BaseView
  template: ""

  options: {}

  model: {}

  constructor: (@selector, @options) ->
    @$el = ($ @selector)
    @uuid = UUID.v4()
    @model = @options?.model ? @model
    @template = Handlebars.compile @template
    if @templates?
      for key, template of @templates
        # console.log key, template
        @templates[key] = Handlebars.compile template

    @delegateEvents()

  render: ->
    @$el.html @template
      uuid: @uuid
      model: @model

  delegateEvents: ->
    for event, callback of @events
      [event, context] = event.split ':'

      unless @[callback]?
        console.log 'ERROR:', "Callback #{callback} could not be found."
        return

      switch context
        when 'window' then app.window.on event, @[callback]
        when 'app' then app.events.on event, @[callback]
        else @$el.delegate context, event, @[callback]
