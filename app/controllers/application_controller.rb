class ApplicationController < ActionController::Base
  protect_from_forgery

  #rescue_from 'ActiveRecord::RecordNotFound', :with => :redirect_404

  before_filter :require_authentication

  protected

  def projects
    @projects ||= current_user.projects.includes(:todo_items)
  end
  helper_method :projects

  def project
    @project ||= current_user.projects.find_by_id params[:project_id]
  end
  helper_method :project

  def todo_items
    @todo_items ||= current_user.todo_items.unattached
  end
  helper_method :todo_items

  def current_user
    if session[:user_id]
      @current_user ||= User.find session[:user_id]
    end
  rescue
    @current_user = nil
  end
  helper_method :current_user

  def current_user= user
    session[:user_id] = user.id
    @current_user = user
  rescue
    @current_user = session[:user_id] = nil
  end
  helper_method :current_user=

  def redirect_404
    flash[:error] = 'Not found!'
    redirect_to root_url
  end

  def require_authentication
    redirect_to(new_session_url, alert: t(:'auth.error.not_signed_in')) and return unless current_user
  end

  def require_authorization
    redirect_to(root_url, alert: t(:'auth.errors.not_authorized')) and return unless current_user.administrator?
  end

end
