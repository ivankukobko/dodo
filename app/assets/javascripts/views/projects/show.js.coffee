class Dodo.Views.ProjectShow extends Backbone.View

  el: '#views-inner'
  template: JST['projects/show']

  initialize: ->
    @model.bind('reset', @render, @)
    @render()

  render: ->
    $(@el).html(@template(model: @model))
    @appendTodoLists()
    this

  appendTodoLists: ->
    todoListsView = new Dodo.Views.TodoListsIndex(
      collection: @model.todoLists()
    )
    $('.todo_lists', @el).append(todoListsView.el)
    this
