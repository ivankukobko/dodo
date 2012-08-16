class Dodo.Views.TodoListItem extends Backbone.View

  tagName: 'li'
  template: JST['todo_lists/item']

  initialize: ->
    @model.bind('reset', @render, @)
    @render()

  render: ->
    $(@el).html(@template(model: @model))
    todoItemsView = new Dodo.Views.TodoItemsIndex(
      collection: @model.todoItems()
    )
    $('.todo_items', @el).html(todoItemsView.el)
    this
