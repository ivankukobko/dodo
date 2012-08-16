class Dodo.Routers.Projects extends Backbone.Router

  routes:
    'projects/:id': 'show'
    'projects/:id/edit': 'edit'

  show: (id) ->
    model = Dodo.projects.get(id)
    new Dodo.Views.ProjectShow(model: model)

  edit: (id) ->
    alert('edit')
