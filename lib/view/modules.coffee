BaseView = require './base'
LinkModuleView = require '../module/link/view'
LinkGroupModuleView = require '../module/linkGroup/view'
GithubModuleView = require '../module/github/view'

module.exports = class ModulesView extends BaseView
  template: """
    {{#each items}}
    <div id="{{type}}-{{@index}}"></div>
    {{/each}}
    """
  model: app.config.modules

  modules: {}

  render: ->
    @$el.html @template(items: @model)

    for item, index in @model
      key = "#{item.type}-#{index}"
      selector = "\##{key}"
      currentModule = switch item.type
        when "link" then new LinkModuleView selector, item.options
        when "linkGroup" then new LinkGroupModuleView selector, item.options
        when "github" then new GithubModuleView selector, item.options
        else render: -> return

      currentModule.render()
      @modules[key] = currentModule
