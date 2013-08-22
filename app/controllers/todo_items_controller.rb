class TodoItemsController < ApplicationController
  inherit_resources
  belongs_to :todo_list, optional: true

  def destroy
    destroy!{ parent_url }
  end

  def sort
    params[:'todo-item'].each_with_index do |item, index|
      todo_item = TodoItem.find(item)
      todo_item.update_attribute :position, index
    end if params[:'todo-item']
    render :nothing => true
  end

  def complete
    todo_item.update_attribute :is_complete, true
    redirect_to todo_item.todo_list, notice: 'Complete'
  end

  def uncomplete
    todo_item.update_attribute :is_complete, false
    redirect_to todo_item.todo_list, notice: 'Incomplete'
  end

private

  def begin_of_association_chain
    current_user
  end

  def todo_list
    parent
  end
  helper_method :todo_list

  def todo_items
    collection
  end
  helper_method :todo_items

  def todo_item
    resource
  end
  helper_method :todo_item
end
