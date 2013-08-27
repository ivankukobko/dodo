class TodoListsController < ApplicationController
  inherit_resources

  private

  def begin_of_association_chain
    current_user
  end

  def todo_lists
    collection
  end
  helper_method :todo_lists

  def todo_list
    resource
  end
  helper_method :todo_list

end
