class Dodo.Views.TodoListsIndex extends Backbone.View

  tagName: 'ul'
  template: JST['todo_lists/index']

  render: ->
    $(@el).html(@template())
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    view = new Dodo.Views.TodoListItem(model: item)
    $(@el).append(view.el)
    this
