class HomeController < ApplicationController
  def index
  end

  def todo_lists
    @todo_lists ||= current_user.todo_lists
  end
  helper_method :todo_lists

end
