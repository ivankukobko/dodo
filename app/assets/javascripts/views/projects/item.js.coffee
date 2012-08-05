class Dodo.Views.ProjectItem extends Backbone.View

  tagName: 'li'
  template: JST['projects/item']

  events:
    'click a': 'showDetails'

  initialize: ->
    @model.bind('reset', @render, @)
    @render()

  render: ->
    $(@el).html(@template(model: @model))
    this

  showDetails: (event) ->
    event.preventDefault()
    id = @model.get('id')
    Dodo.projects_router.navigate "projects/#{id}", trigger: true
    #new Dodo.Views.ProjectShow(model: @model)
