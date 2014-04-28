BaseView = require './base'
BrowserView = require './browser'

module.exports = class ContentView extends BaseView
  templates:
    browser: """
      <iframe id="app-content-browser"
        src="{{url}}"
        nwdisable
        nwfaketop
        seamless
        frameborder="0"
        ></iframe>
      """

  events: 
    'content-browser:app': 'renderBrowser'

  renderBrowser: (url) =>
    @$el.html @templates.browser(url: url)
    @contentView = undefined

    if @browserView
      @browserView.navigate url
    else
      @browserView = new BrowserView '#app-content-browser'
    app.window.emit 'resize'
