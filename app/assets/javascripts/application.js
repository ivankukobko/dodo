// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

(function(){
  $('html').removeClass('no-js');


  $('.sortable').sortable({
    axis : 'y',
    items : 'article',
    cursor : 'crosshair',
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

  $('.todo-item').hover(
    function(){
      $(this).addClass('hover');
    },
    function(){
      $(this).removeClass('hover');
    }
  );

  $('.todo-item :checkbox').change(function(){
    $(this).closest('form').submit();
  });

})(jQuery)
