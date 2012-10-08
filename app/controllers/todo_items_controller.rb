class TodoItemsController < ApplicationController
  inherit_resources
  belongs_to :todo_list

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

private

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
