BaseView = require './base'
ModulesView = require './modules'
ToolbarView = require './toolbar'

module.exports = class SidebarView extends BaseView
  template: """
    <div id="app-modules" class="ui blue vertical fluid menu">
    </div>
    """
    # <div id="app-toolbar" class="ui inverted blue pointing menu"></div>
    # <div id="app-metadata"></div>

  render: ->
    @$el.html @template(items: app.config.modules)

    @modulesView = new ModulesView '#app-modules'
    # @toolbarView = new ToolbarView '#app-toolbar'
    # @metadataView = new MetadataView '#app-metadata'

    @modulesView.render()
    # @toolbarView.render()
    # @metadataView.render()
