class Dodo.Views.TodoItemsIndex extends Backbone.View

  template: JST['todo_items/index']

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template)
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    itemView = new Dodo.Views.TodoItemItem(model: item)
    $('ul', @el).append(itemView.el)
    this
