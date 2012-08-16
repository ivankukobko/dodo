window.Dodo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @projects = new Dodo.Collections.Projects(
      $('#aside-inner').data('projects')
    )

    @todo_lists = new Dodo.Collections.TodoLists(
      $('#aside-inner').data('lists')
    )

    new Dodo.Views.ProjectsIndex(
      collection: @projects
    )

    @projects_router    = new Dodo.Routers.Projects()
    @todo_lists_router  = new Dodo.Routers.TodoLists()
    Backbone.history.start()
    this

$(document).ready ->
  Dodo.init()
