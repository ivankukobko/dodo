class Dodo.Routers.TodoLists extends Backbone.Router

  routes:
    '': 'index'

  index: ->
    todoListsView = new Dodo.Views.TodoListsIndex(
      collection: Dodo.todo_lists
    )
    $('#views-inner').html(todoListsView.el)
