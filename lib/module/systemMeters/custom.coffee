BaseView = require '../../view/base'

module.exports = class SystemMetersCustomView extends BaseView
  template: """
    <h1>Hi from a custom module</h1>
    """

  update: ->
    @$el.append '<p>Click&hellip;</p>'
