class Raffler.Views.CompaniesIndex extends Backbone.View

  template: JST['companies/index']

  events:
    'click #drawMap': 'drawVisualisation'
  
  render: ->
	  $(@el).html(@template(companies: "Companies goes here"))
	  this

  drawVisualisation: ->
    options = {
      zoom: 6
      center: new google.maps.LatLng(39,-98)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    @map = new google.maps.Map(this.$('#map')[0],options)
    @map.ready(this.render)

