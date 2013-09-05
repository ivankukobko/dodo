class TodoItemsController < ApplicationController
  inherit_resources
  belongs_to :project, optional: true

  def destroy
    destroy!{ root_url }
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
    redirect_to parent || :back, notice: 'Complete'
  end

  def uncomplete
    todo_item.update_attribute :is_complete, false
    redirect_to parent || :back, notice: 'Incomplete'
  end

private

  def begin_of_association_chain
    current_user
  end

  def resource
    @todo_item ||= if params[:id]
      collection.find params[:id]
    else
      TodoItem.new params[:todo_item], project_id: parent.id, user_id: current_user.id
    end
  end

  def todo_items
    collection
  end
  helper_method :todo_items

  def todo_item
    resource
  end
  helper_method :todo_item

end
