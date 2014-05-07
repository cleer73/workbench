BaseView = require './base'

module.exports = class BrowserView extends BaseView
  template: """
    <div class="ui inverted menu app-browser-menu">
      <a href="#app-browser-back"
        class="item"
        data-content-uuid="{{uuid}}"
        ><i class="arrow left icon"></i></a>
      <a href="#app-browser-forward"
        class="item"
        data-content-uuid="{{uuid}}"
        ><i class="arrow right icon"></i></a>
      <div class="item">
        <i class="{{model.icon}} icon"></i> {{model.title}}
      </div>
      <div class="right menu">
        <a href="#app-browser-refresh"
          class="item"
          data-content-uuid="{{uuid}}"
          ><i class="refresh icon"></i></a>
      </div>
    </div>

    <iframe src="{{model.src}}"
      class="app-browser-iframe app-resize-container"
      nwdisable
      nwfaketop
      seamless
      frameborder="0"
      style="width: 100%;"
      ></iframe>
    """

  events:
    'resize:window': 'resize'

  update: ->
    unless clickedUrl is @browserEl.attr('src')
      @browserEl.attr 'src', clickedUrl

  render: ->
    super
    @resize()

  show: ->
    @$el.show()

  resize: =>
    $browserEl = @$el.find 'iframe'
    height = @$el.height()

    adjustedHeight = height - 46 # 65
    # if app.config.package.window.toolbar
    #   adjustedHeight -= 41

    $browserEl.css 'height', adjustedHeight
