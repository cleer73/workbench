BaseView = require './base'
ToolbarView = require './toolbar'

# TODO: Refactor to load these dynamically, by config
LinkModuleView = require '../module/link/view'
LinkGroupModuleView = require '../module/linkGroup/view'
GithubModuleView = require '../module/github/view'

module.exports = class SidebarView extends BaseView
  template: """
    <div id="app-modules" class="ui blue vertical fluid menu">
      {{#each model.modules}}
      <div id="{{type}}-{{@index}}"></div>
      {{/each}}
    </div>
    """

  model: 
    modules: app.config.modules

  modules: {}

  render: ->
    @$el.html @template(@model)
    @renderModules()

  renderModules: ->
    for item, index in @model.modules
      key = "#{item.type}-#{index}"
      selector = "\##{key}"
      currentModule = switch item.type
        when "github" then new GithubModuleView selector, model: item.options
        when "link" then new LinkModuleView selector, model: item.options
        when "linkGroup" then new LinkGroupModuleView selector, model: item.options
        else render: -> return # TODO: Review later, seems to work, but is untrusted.

      currentModule.render()
      @modules[key] = currentModule

  updateSelected: (options) ->
    ($ '#app-modules .item')
      .removeClass('active')
    ($ options.sidebarElement)
      .addClass('active')
      .parents('div.item')
      .addClass('active')
