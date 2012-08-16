class Dodo.Views.TodoListsIndex extends Backbone.View

  tagName: 'ul'
  className: 'todo-lists-list'
  template: JST['todo_lists/index']

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template())
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    view = new Dodo.Views.TodoListItem(model: item)
    @$el.append(view.el)
    this
