window.Dodo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Dodo.Views.TodoItemsIndex()
    @
$(document).ready ->
  Dodo.init()
