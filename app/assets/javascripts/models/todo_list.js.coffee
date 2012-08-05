class Dodo.Models.TodoList extends Backbone.Model

  project: ->
    if Dodo.projects
      Dodo.projects.get( @get('project_id') )

  todoItems: ->
    new Dodo.Collections.TodoItems(
      new Dodo.Collections.TodoItems(
        @project().get('todo_items')
      ).where('todo_list_id': @get('id'))
    )
