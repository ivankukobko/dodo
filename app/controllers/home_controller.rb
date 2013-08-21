class HomeController < ApplicationController
  def index
    p todo_lists
  end

  def projects
    @projects ||= current_user.projects.joins(:todo_lists)
  end
  helper_method :projects

  def todo_lists
    @todo_lists ||= current_user.todo_lists.unattached.includes(:todo_items)
  end
  helper_method :todo_lists

end
