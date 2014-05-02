BaseView = require '../../view/base'

module.exports = class LinkGroupModuleView extends BaseView
  template: """
    <div class="header item">
      <i class="{{icon}} small icon"></i> {{title}}
    </div>

    {{#each links}}
      <a href="{{url}}" class="item">{{title}}</a>
    {{/each}}
    """

  events: 
    'click:a': 'click'

  constructor: (selector, options) ->
    for link, i in options.model.links
      options.model.links[i].uuid = UUID.v4()
    super

  click: (event) ->
    console.log 'LinkGroupModuleView', event
    event.preventDefault()
    app.events.emit 'content-browser', sidebarElement: event.toElement
    app.events.emit 'sidebar-selected', sidebarElement: event.toElement
