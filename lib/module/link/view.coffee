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
    app.events.emit 'content-browser', sidebarElement: event.toElement
    app.events.emit 'sidebar-selected', sidebarElement: event.toElement
