BaseView = require './base'
SidebarView = require './sidebar'

module.exports = class LayoutView extends BaseView
  template: """
    <div id="app-sidebar">Layout &gt; Sidebar</div>
    <div id="app-content">Layout &gt; Content</div>
    """

  templates:
    browser: """
      <iframe id="app-browser-{{uuid}}"
        src="{{src}}"
        nwdisable
        nwfaketop
        seamless
        frameborder="0"
        ></iframe>
      """
    custom: """
      <div id="app-custom-{{uuid}}"></div>
      """

  events:
    'resize:window': 'resize'
    'content-browser:app': 'renderBrowser'

  contentViews: {}

  render: ->
    @$el.html @template()

    @sidebarView = new SidebarView '#app-sidebar'
    @sidebarView.render()

    @resize()

  renderBrowser: (url) =>
    if @$el.find('#app-browser').length
      @$el.find('#app-browser').attr('src', url)
    else
      @$el.find('#app-content').html @templates.browser(url: url)

    @resize()

  resize: (width, height) =>
    width ?= app.window.width
    height ?= app.window.height

    if app.config.package.window.toolbar is true
      adjustedHeight = height - 54 # no toolbar
    else
      adjustedHeight = height - 22 # toolbar
    adjustedWidth = width - 331;

    @$el.find '#app-browser'
      .css 'height', adjustedHeight
      .css 'width', adjustedWidth

    @sidebarView.$el.css 'height', (adjustedHeight - 30)
