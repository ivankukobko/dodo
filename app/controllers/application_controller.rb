class ApplicationController < ActionController::Base
  protect_from_forgery

  #rescue_from 'ActiveRecord::RecordNotFound', :with => :redirect_404

  before_filter :require_authentication

  protected

  def current_user
    if session[:user_id]
      @current_user ||= User.find session[:user_id]
    end
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
    unless current_user
      redirect_to new_session_url
    end
  end

  def require_authorization
    unless current_user
      unless current_user.administrator?
        flash[:error] = 'Unauthorized!'
        redirect_to root_url
      end
    end
  end
end
