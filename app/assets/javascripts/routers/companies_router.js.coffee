class Raffler.Routers.Companies extends Backbone.Router
  routes:
    'companies': 'index'
    'companies/:id' : 'show'
		
  index: ->
    view = new Raffler.Views.CompaniesIndex()
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Entry #{id}"