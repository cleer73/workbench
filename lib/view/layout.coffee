BaseView = require './base'
SidebarView = require './sidebar'

module.exports = class LayoutView extends BaseView
  template: """
    <div id="app-sidebar">Layout &gt; Sidebar</div>
    <div id="app-content">
      <div id="app-custom-welcome">
      <div class="ui grid">
        <div class="row">
        <div class="four wide column">
          Column 1
        </div>
        <div class="four wide column">
          Column 2
        </div>
        <div class="four wide column">
          Column 3
        </div>
        <div class="four wide column">
          Column 4
        </div>
        </div>
      </div>
      </div>
    </div>
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

  renderBrowser: (options) =>
    uuid = ($ options.sidebarElement).data 'content-uuid'
    clickedUrl = options.sidebarElement.href

    @$el.find('#app-content>*').hide()

    if @contentViews.hasOwnProperty uuid
      unless clickedUrl is @contentViews[uuid].attr('src')
        @contentViews[uuid].attr('src', clickedUrl)
      @contentViews[uuid].show()
    else
      html = @templates.browser
        uuid: uuid
        src: clickedUrl
      @$el.find('#app-content').append html
      @contentViews[uuid] = @$el.find("#app-browser-#{uuid}")

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

    @$el.find '#app-content>iframe:visible,#app-content>div:visible'
      .css 'height', adjustedHeight
      .css 'width', adjustedWidth

    @sidebarView.$el.css 'height', (adjustedHeight - 30)
