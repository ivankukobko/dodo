// default flashes display
function showFlash() {
  $('.flash-message').stop(true, true).hide();
  $('.flash-message').slideDown('slow');
  setTimeout(
    function(){
      $('.flash-message').slideUp('slow');
    },
    7000
  );
}

// helper method for nested forms
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").fadeOut();
}

// helper method for nested forms
function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

(function(){
  $('html').removeClass('no-js');
  showFlash();

  $.ajaxSetup({
    beforeSend: function(e) {
      $('#ajax').fadeIn();
    },
    complete: function() {
      $('#ajax').fadeOut();
    }
  });

  $('.sortable').sortable({
    axis : 'y',
    items : 'article',
    forceHelperSize: true,
    handle : '.drag-handle',
    containment : 'parent',
    update : function(event, ui){
      var self = this;
      var sortedItems = $(self).sortable('serialize', { key: 'todo-item[]' })
      console.log(sortedItems);
      $.ajax({
        url : '/todo_items/sort',
        type: 'post',
        dataType: 'script',
        data : sortedItems,
        complete: function(){
          $(self).effect('highlight');
        }
      });
    }
  });

  $('.todo-list, .todo-item').hover(
    function(){
      $(this).addClass('hover');
    },
    function(){
      $(this).removeClass('hover');
    }
  );

  $('.todo-item :checkbox').live('change', function(){
    $(this).closest('form').submit();
  });

  $('.remote-link').live('click', function(e){
    e.preventDefault();
    return false;
  });

  $('.datepicker').datepicker({
    'dateFormat': 'yy-mm-dd',
    'showOn': 'both'
  });
})(jQuery)
