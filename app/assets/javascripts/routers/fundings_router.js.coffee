class Raffler.Routers.Fundings extends Backbone.Router
  routes:
    'fundings': 'index'

  initialize: ->
    @fundings = new Raffler.Collections.Fundings()
    @fundings.fetch()

  index: ->
    view = new Raffler.Views.FundingsIndex(collection: @fundings)