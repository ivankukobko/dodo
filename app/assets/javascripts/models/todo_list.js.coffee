class Dodo.Models.TodoList extends Backbone.Model

  project: ->
    if Dodo.projects
      Dodo.projects.get( @get('project_id') )

  todoItems: ->
    new Dodo.Collections.TodoItems(
      @get('todo_items')
    )
