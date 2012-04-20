window.Raffler =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Raffler.Routers.Entries()
    new Raffler.Routers.Companies()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Raffler.init()