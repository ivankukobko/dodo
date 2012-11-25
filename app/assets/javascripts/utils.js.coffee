jQuery ->

  # default flashes display
  showFlash = ->
    $('.flash-message').stop(true, true).hide()
    $('.flash-message').slideDown('slow')
    setTimeout(
      ->
        $('.flash-message').slideUp('slow')
      ,
      7000
    )

  # helper method for nested forms
  remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val("1")
    $(link).closest(".fields").fadeOut()

  # helper method for nested forms
  add_fields = (link, association, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id))

  $('html').removeClass('no-js')
  showFlash()

  $.ajaxSetup(
    beforeSend: (e) ->
      $('#ajax').fadeIn()
    ,
    complete: ->
      $('#ajax').fadeOut()
    )

  $('.sortable').sortable(
    axis : 'y',
    items : 'article',
    forceHelperSize: true,
    handle : '.drag-handle',
    containment : 'parent',
    update : (event, ui) ->
      self = @
      sortedItems = $(self).sortable('serialize', { key: 'todo-item[]' })
      console.log(sortedItems)
      $.ajax(
        url : '/todo_items/sort',
        type: 'post',
        dataType: 'script',
        data : sortedItems,
        complete: ->
          $(self).effect('highlight')
      )
  )

  $('.todo-list, .todo-item').hover(
    ->
      $(@).addClass('hover')
    ,
    ->
      $(@).removeClass('hover')
  )

  $('.todo-item :checkbox').live('change', ->
    $(@).closest('form').submit()
  )

  $('.remote-link').live('click', (e) ->
    e.preventDefault()
    return false
  )

  $('.datepicker').datepicker(
    'dateFormat': 'yy-mm-dd',
    'showOn': 'both'
  )