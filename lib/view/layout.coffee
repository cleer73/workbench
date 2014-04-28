BaseView = require './base'
SidebarView = require './sidebar'
ContentView = require './content'

module.exports = class LayoutView extends BaseView
  template: """
    <div id="app-sidebar">Layout &gt; Sidebar</div>
    <div id="app-content">Layout &gt; Content</div>
    """

  events:
    'resize:window': 'resize'

  resize: (width, height) =>
    width ?= app.window.width
    height ?= app.window.height

    if app.config.package.window.toolbar is true
      adjustedHeight = height - 54 # no toolbar
    else
      adjustedHeight = height - 22 # toolbar
    adjustedWidth = width - 331;

    @contentView.$el.find '>div,>iframe'
      .css 'height', adjustedHeight
      .css 'width', adjustedWidth

    @sidebarView.$el.css 'height', (adjustedHeight - 30)

  render: ->
    @$el.html @template()

    @sidebarView = new SidebarView '#app-sidebar'
    @contentView = new ContentView '#app-content'

    @sidebarView.render()
    @contentView.render()

    @resize()
