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

  click: (event) ->
    event.preventDefault()
    ($ '#app-modules .item').removeClass 'active'
    ($ event.toElement).addClass 'active'
    app.events.emit 'content-browser', event.toElement.href

  render: ->
    @$el.html @template(@options)
