class Dodo.Views.TodoItemsIndex extends Backbone.View

  tagName: 'ul'
  template: JST['todo_items/index']

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template)
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    itemView = new Dodo.Views.TodoItemItem(model: item)
    $(@el).append(itemView.el)
    this
