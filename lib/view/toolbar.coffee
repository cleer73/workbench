BaseView = require './base'

module.exports = class ToolbarView extends BaseView
  view: """
    <div id="app-toolbar" class="ui inverted blue pointing menu" style="display:block;">
    {{#list links}}
      <a href="#app-toolbar/event/{{event}}" class="item"><i class="{{icon}} large icon"></i></a>
    {{/list}}
    </div>
    """

  buttons: 
    1:
      icon: 'text file'
      event: 'metdata/toggle'
    2:
      icon: 'refresh'
      event: 'content/refresh'
      class: 'right'
