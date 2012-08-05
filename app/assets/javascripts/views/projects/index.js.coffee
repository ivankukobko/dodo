class Dodo.Views.ProjectsIndex extends Backbone.View

  el: '#aside-inner'
  template: JST['projects/index']

  initialize: ->
    #@collection.fetch()
    #@collection.bind('reset', @render, @)
    @render()

  render: ->
    $(@el).html(@template())
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    view = new Dodo.Views.ProjectItem({model: item})
    $("ul.projects", @el).append(view.el)
    this


