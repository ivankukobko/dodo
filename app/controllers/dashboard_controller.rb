class DashboardController < ApplicationController
  def index
  end

private

  def projects
    @projects ||= current_user.projects
  end
  helper_method :projects
end
