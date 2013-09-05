jQuery ->

  # default flashes display
  showFlash = ->
    $('.flash-message').each (index) ->
      $.gritter.add(
        title: $(@).data('title')
        text: $(@).html()
      )
  showFlash()

  # helper method for nested forms
  remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val("1")
    $(link).closest(".fields").fadeOut()

  # helper method for nested forms
  add_fields = (link, association, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id))


  # $.ajaxSetup(
    # beforeSend: (e) ->
      # $('#ajax').fadeIn()
    # ,
    # complete: ->
      # $('#ajax').fadeOut()
    # )

  $
  $('.sortable').sortable(
    axis : 'y'
    items : 'article'
    distance: 10
    forceHelperSize: true
    placeholder: "ui-placeholder"
    containment : 'parent'
    connectWith: '.connected-sortable'
    handle: '.drag-handle'
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
  ).disableSelection()

  $('.todo-list, .todo-item').hover(
    ->
      $(@).addClass('hover')
    ,
    ->
      $(@).removeClass('hover')
  )

  $('.datepicker').datepicker(
    'dateFormat': 'yy-mm-dd',
    'showOn': 'both'
  )
