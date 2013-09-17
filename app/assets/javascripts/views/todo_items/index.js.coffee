class Dodo.Views.TodoItemsIndex extends Backbone.View

  el: ".script_sortable-toggle"
  events:
    'click .script_sort-switch':  'toggleSortable'

  initialize: ->
    @drawControls()
    @$el.addClass(@hasControlsClassName)
    @$el.sortable(
      axis : 'y'
      items : 'article'
      delay: 500
      distance: 10
      forceHelperSize: true
      placeholder: "ui-placeholder"
      containment : 'parent'
      connectWith: '.connected-sortable'
      # handle: '.drag-handle'
      update : (event, ui) ->
        self = this
        sortedItems = $(self).sortable('serialize', { key: 'todo-item[]' })
        $.ajax(
          url : '/tasks/sort'
          type: 'post'
          dataType: 'script'
          data : sortedItems
          complete: ->
            $(self).effect('highlight')
        )
    ).disableSelection().sortable('disable')

  drawControls: ->
    controls = JST['util/sortable_controls']
    @$el.prepend(controls)


  toggleSortable: (e)->
    value = $(e.target).val()
    console.log value
    if value == '1'
      @$el.addClass('sortable')
      @$el.sortable('enable')
    else
      @$el.removeClass('sortable')
      @$el.sortable('disable')

