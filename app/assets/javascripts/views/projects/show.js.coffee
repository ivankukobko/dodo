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
    view = new Dodo.Views.TodoListsIndex(
      el: '.todo_lists'
      collection: @model.todoLists()
    )
    view.render()
    this
