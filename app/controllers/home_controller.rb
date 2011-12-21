class HomeController < ApplicationController
  def index
  end

  def projects
    @projects ||= current_user.projects
  end
  helper_method :projects

  def todo_lists
    @todo_lists ||= current_user.todo_lists.unattached
  end
  helper_method :todo_lists

end
