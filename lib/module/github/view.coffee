BaseView = require '../../view/base'

module.exports = class GithubModuleView extends BaseView
  template: """
    <a href="https://status.github.com/" class="header item">
      <i class="github alternate small icon"></i> Github
    </a>

    {{#each repositories}}
      {{#if name}}
        <a href="https://github.com/{{name}}/pulls" class="item">{{title}}</a>
      {{/if}}
      {{#if repositories}}
        <div class="item">
          {{title}}
          <div class="menu">
            {{#each repositories}}
              <a href="https://github.com/{{name}}/pulls" class="item">{{title}}</a>
            {{/each}}
          </div>
        </div>
      {{/if}}
    {{/each}}
    """

  events: 
    'click:a': 'click'

  click: (event) ->
    event.preventDefault()
    app.events.emit 'content-browser', sidebarElement: event.toElement
    app.events.emit 'sidebar-selected', sidebarElement: event.toElement

  render: ->
    @$el.html @template(@options)
