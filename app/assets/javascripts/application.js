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
//= require ICanHaz.min

// default flashes display
function showFlash() {
  $('.flash-message').stop(true, true).hide();
  $('.flash-message').slideDown('slow');
  setTimeout(
    function(){
      $('.flash-message').slideUp('slow');
    },
    5000
  );
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

  //$('.link-show').live('click', function(){
    //$.getJSON( $(this).attr('href') + '/todo_items', function(data){
      //var TodoItems = data;
      //$('#todo-items').empty();
      //$(TodoItems).each(function(index, item){
        //ich['todo-item-template'](item).appendTo('#todo-items')
      //});
      //$('#todo-lists-container').show();
    //});
  //});

  //$.getJSON('/todo_lists', function(data){
    //var TodoLists = data;
    //$('#todo-lists').empty();
    //$(TodoLists).each(function(index, item){
      //ich['todo-list-template'](item).appendTo('#todo-lists')
    //});
  //});

  //$.getJSON('/todo_items', function(data){
    //var TodoItems = data;
    //$('#todo-items').empty();
    //$(TodoItems).each(function(index, item){
      //ich['todo-item-template'](item).appendTo('#todo-items')
    //});
  //});

  //$('#new_todo_list').submit(function(e){
    //e.preventDefault();
    //return false;
  //});

/* Knockoutjs integration */

  //[> todo list class <]
  //var TodoList = function(id, title, description, isComplete, ownerViewModel) {
    //// properties
    //this.id = id;
    //this.title = ko.observable(title);
    //this.description = ko.observable(description);
    //this.isComplete = ko.observable(isComplete);

    //// methods
    //this.remove = function() {
      //$.ajax({
        //url : '/todo_lists/' + this.id,
        ////data: { 'id' : this.id },
        //success : function(data) {
          //console.log('remove');
          //ownerViewModel.todoLists.remove(this)
        //},
        //type : 'delete',
        //dataType : 'json'
      //});
    //}
  //}

  //[> todo lists view model <]
  //var TodoListsViewModel = function(){
    //var self = this;
    //this.todoLists = ko.observableArray([]);
    //this.newTodoList = ko.observable();
    //this.newTodoTitle = ko.observable();

    //// Load initial state from server
    //this.refresh = function(){
      //$.get("/todo_lists", function(data) {
        //var mappedTodoLists = $.map(data, function(item) {
          //return new TodoList(item.id, item.title, item.description, item['is_complete?'], self)
        //});
        //self.todoLists(mappedTodoLists);
      //}, 'json');
    //}

    //this.addTodoList = function() {
      //alert('add todo list');
      //this.todoLists.push( new TodoList(null, this.newTodoTitle(), '', false, self ) )
      //this.newTodoTitle('');
      //this.refresh();
    //}

    //this.deleteTodoList = function() {
      //this.refresh();
    //}

    //this.refresh();
  //};

  //ko.applyBindings( new TodoListsViewModel() );

})(jQuery)
