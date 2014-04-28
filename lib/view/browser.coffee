BaseView = require './base'

module.exports = class BrowserView extends BaseView

  events:
    'update-url:app': 'render'

  constructor: (selector, options) ->
    console.log 'BrowserView.constructor()'
    super selector, options

  navigate: (url) ->
    $browser = @$el.find 'iframe'

    unless $browser.attr 'src' is url
      $browser.attr 'src', url
