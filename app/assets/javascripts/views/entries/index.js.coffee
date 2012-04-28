class Raffler.Views.EntriesIndex extends Backbone.View
  template: JST['entries/index']

  events:
    'submit #new_entry': 'createEntry'
    'click #draw': 'drawWinner'
    'click #newdraw': 'newFunction'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendEntry)
    this
    
  appendEntry: (entry) =>
    view = new Raffler.Views.Entry(model: entry)
    @$('#entries').append(view.render().el)

  drawWinner: (event) ->
    event.preventDefault()
    @collection.drawWinner()

  createEntry: (event) ->
    event.preventDefault()
    attributes = name: $('#new_entry_name').val()
    if attributes.name == "<script>"
      alert "you may not use a <script> tag"
    if attributes.name == "<tag>"
      alert "you may not use a <tag> tag"
    if attributes.name =="'"
      alert "protecting against an SQL injection"
    if attributes.name.length > 20
      alert "You many not use more than 20 characters"
    else
      @collection.create attributes,
        wait: true
        success: -> $('#new_entry')[0].reset()
        error: @handleError
      
  handleError: (entry, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  newFunction: ->
    alert @collection

  validate:(attributes) ->
    if attributes.name == ""
      alert "name cannot be blank"
      return false
    else
      return true
