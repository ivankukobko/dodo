class Dodo.Routers.Projects extends Backbone.Router
  routes:
    'projects/:id': 'show'


  show: (id) ->
    #new Dodo.Views.ProjectShow()
    alert 'Show!'
