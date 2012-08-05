class Dodo.Models.Project extends Backbone.Model

  todoLists: ->
    new Dodo.Collections.TodoLists(@get('todo_lists'))
