BaseView = require '../../view/base'
SystemMetersCustomView = require './custom'

module.exports = class SystemMetersModuleView extends BaseView
  template: """
    <a href="#custom-content" class="header item">
      <i class="dashboard small icon"></i> System Meters
    </a>

    <div class="menu">
    {{#each sidebarMeter}}
      <div class="item">{{this}}</div>
    {{/each}}
    </div>
    """

  events:
    'click:a': 'click'

  click: (event) ->
    event.preventDefault()
    app.events.emit 'content-custom', SystemMetersCustomView
    app.events.emit 'sidebar-selected', event.toElement
