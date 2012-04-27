window.Raffler =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Raffler.Routers.Companies()
    new Raffler.Routers.Entries()
    new Raffler.Routers.Fundings()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Raffler.init()

