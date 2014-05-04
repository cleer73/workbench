BaseView = require '../../view/base'

module.exports = class LinkModuleView extends BaseView
  template: """
    <a href="{{model.url}}"
      class="header item"
      data-content-uuid="{{uuid}}"
      data-title="{{model.title}}"
      data-icon="{{model.icon}}"
      ><i class="{{model.icon}} small icon"></i> {{model.title}}
    </a>
    """

  events: 
    'click:a': 'click'

  click: (event) ->
    event.preventDefault()
    console.log 'LinkModuleView', event.toElement
    app.events.emit 'content-browser', sidebarElement: event.toElement
    app.events.emit 'sidebar-selected', sidebarElement: event.toElement
