class Dodo.Views.TodoItemItem extends Backbone.View

  tagName: 'li'
  template: JST['todo_items/item']

  initialize: ->
    @model.bind('reset', @render, @)
    @render()

  render: ->
    $(@el).html(@template(model: @model))
    this
