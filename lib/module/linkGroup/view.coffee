UUID = require 'node-uuid'

BaseView = require '../../view/base'

module.exports = class LinkGroupModuleView extends BaseView
  template: """
    <div class="header item">
      <i class="{{model.icon}} small icon"></i> {{model.title}}
    </div>

    {{#each model.links}}
      <a href="{{url}}"
        class="item"
        data-content-uuid="{{uuid}}"
        data-title="{{title}}"
        data-icon="{{icon}}"
        >{{title}}</a>
    {{/each}}
    """

  events: 
    'click:a': 'click'

  constructor: (selector, options) ->
    for link, i in options.model.links
      options.model.links[i].uuid = UUID.v4()
      options.model.links[i].icon = options.model.icon
    super

  click: (event) ->
    console.log 'LinkGroupModuleView', event
    event.preventDefault()
    app.events.emit 'content-browser', sidebarElement: event.toElement
    app.events.emit 'sidebar-selected', sidebarElement: event.toElement
