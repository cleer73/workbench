BaseView = require './base'
SidebarView = require './sidebar'
BrowserView = require './browser'

module.exports = class LayoutView extends BaseView
  template: """
    <div id="app-sidebar">Layout &gt; Sidebar</div>
    <div id="app-content">
      <div id="app-custom-{{uuid}}">
      <div style="padding: 0px 20px;">
        <div class="ui grid">
          <div class="row">
          <div class="sixteen wide column">
            <h1>Welcome</h1>
            <p>Someday this will be a fancy "this is how you use this app" screen, for when you first start it up.</p>
          </div>
          </div>
        </div>
      </div>
      </div>
    </div>
    </div>
    """

  templates:
    browser: """
      <div id="app-browser-{{uuid}}"></div>
      """
    custom: """
      <div id="app-custom-{{uuid}}"></div>
      """

  events:
    'resize:window': 'resize'
    'content-browser:app': 'renderBrowser'

  contentViews: {}

  render: ->
    super

    @sidebarView = new SidebarView '#app-sidebar'
    @sidebarView.render()

    @resize()

  renderBrowser: (options) =>
    uuid = ($ options.sidebarElement).data 'content-uuid'
    clickedUrl = options.sidebarElement.href

    @$el.find('#app-content>:visible').hide()

    if @contentViews.hasOwnProperty uuid
      @contentViews[uuid].show()
    else
      @$el.find('#app-content').append @templates.browser(uuid: uuid)
      @contentViews[uuid] = new BrowserView "\#app-browser-#{uuid}",
        uuid: uuid
        model:
          title: ($ options.sidebarElement).data 'title'
          icon: ($ options.sidebarElement).data 'icon'
          src: clickedUrl
      @contentViews[uuid].render()

    @contentUUID = uuid
    @resize()

  renderCustom: (options) =>
    uuid = ($ options.sidebarElement).data('content-uuid')

    @$el.find('#app-content>*').hide()

    unless @contentViews.hasOwnProperty uuid
      html = @templates.custom uuid: uuid
      @$el.find('#app-content').append html
      @contentViews[uuid] = new options.customView "\#app-custom-#{uuid}"
      @contentViews[uuid].render()

    @contentViews[uuid].$el.show()
    @contentViews[uuid].update()
    @resize()

  resize: (width, height) =>
    width ?= app.window.width
    height ?= app.window.height

    if app.config.package.window.toolbar is true
      adjustedHeight = height - 54 # no toolbar
    else
      adjustedHeight = height - 22 # toolbar
    adjustedWidth = width - 331;

    # Resize the primary content elements
    @$el.find '#app-content>div:visible'
      .css 'height', adjustedHeight
      .css 'width', adjustedWidth

    # Resize the sidebar content
    @sidebarView.resize adjustedWidth, adjustedHeight

    # Resize any module content
    for uuid, view of @contentViews
      if view.$el.is(':visible') and view.hasOwnProperty 'resize'
        view.resize adjustedWidth, adjustedHeight
