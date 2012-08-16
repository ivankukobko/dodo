class DashboardController < ApplicationController
  def index
  end

private

  def projects
    @projects ||= current_user.projects
  end
  helper_method :projects

  def todo_lists
    @todo_lists ||= current_user.todo_lists
  end
  helper_method :todo_lists
end
