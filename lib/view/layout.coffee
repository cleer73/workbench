BaseView = require './base'
SidebarView = require './sidebar'

module.exports = class LayoutView extends BaseView
  template: """
    <div id="app-sidebar">Layout &gt; Sidebar</div>
    <div id="app-content">
      <div id="app-custom-welcome">
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
    """

  templates:
    browser: """
      <div id="app-browser-{{uuid}}">
        <div class="ui inverted  menu">
          <a href="#app-browser-back"
            class="item"
            data-content-uuid="{{uuid}}"
            ><i class="arrow left icon"></i></a>
          <a href="#app-browser-forward"
            class="item"
            data-content-uuid="{{uuid}}"
            ><i class="arrow right icon"></i></a>
          <div class="item">
            <i class="{{icon}} icon"></i> {{title}}
          </div>
          <div class="right menu">
            <a href="#app-browser-refresh"
              class="item"
              data-content-uuid="{{uuid}}"
              ><i class="refresh icon"></i></a>
          </div>
        </div>

        <iframe src="{{src}}"
          nwdisable
          nwfaketop
          seamless
          frameborder="0"
          ></iframe>
      </div>
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
      iconsClasses = 

      html = @templates.browser
        title: ($ options.sidebarElement).data 'title'
        icon: ($ options.sidebarElement).data 'icon'
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

    @$el.find '#app-content iframe:visible,#app-content>div:visible'
      .css 'height', adjustedHeight
      .css 'width', adjustedWidth

    @sidebarView.$el.css 'height', (adjustedHeight - 30)
