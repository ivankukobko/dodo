class Dodo.Routers.Projects extends Backbone.Router

  routes:
    '': 'index'
    'projects/:id': 'show'
    'projects/:id/edit': 'edit'

  index: ->
    new Dodo.Views.TodoListsIndex()

  show: (id) ->
    model = Dodo.projects.get(id)
    new Dodo.Views.ProjectShow(model: model)

  edit: (id) ->
    alert('edit')
