window.Dodo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @projects = new Dodo.Collections.Projects( $('#aside-inner').data('projects') )
    new Dodo.Views.ProjectsIndex(
      collection: @projects
    )
    @projects_router = new Dodo.Routers.Projects()

$(document).ready ->
  Dodo.init()
