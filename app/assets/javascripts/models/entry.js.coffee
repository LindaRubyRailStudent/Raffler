class Raffler.Models.Entry extends Backbone.Model
  win: ->
    @set(winner: true)
    @save()
    @trigger('highlight')

  validate: (attrs) ->
    alert attrs