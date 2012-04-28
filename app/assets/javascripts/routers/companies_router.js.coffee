class Raffler.Routers.Companies extends Backbone.Router
  routes:
    '': 'index'
    'companies/:id' : 'show'

  initialize: ->
    @collection = []
    @companies = new Raffler.Collections.Companies()
    @companies.fetch()
    @collection.push(@companies)
    @funding = new Raffler.Collections.Fundings()
    @funding.fetch()
    @collection.push(@funding)

  index: ->
    view = new Raffler.Views.CompaniesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"