BaseView = require '../../view/base'

module.exports = class LinkModuleView extends BaseView
  template: """
    <a href="{{url}}" class="header item">
      <i class="{{icon}} small icon"></i> {{title}}
    </a>
    """

  events: 
    'click:a': 'click'

  click: (event) ->
    event.preventDefault()
    app.events.emit 'content-browser', event.toElement.href
    app.events.emit 'sidebar-selected', event.toElement

  render: ->
    @$el.html @template(@options)
