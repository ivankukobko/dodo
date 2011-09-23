class SessionsController < ApplicationController

  skip_before_filter :require_authentication

  def new
  end

  def create
    email, password = params[:user][:email], params[:user][:password]
    if current_user = User.authenticate(email, password)
      session[:user_id] = current_user.id # should get rid of this
      redirect_to root_url, :notice => t(:'sessions.create.success')
    else
      redirect_to new_session_url, :error => t(:'sessions.create.error')
    end
  end

  def destroy
    current_user = nil
    reset_session
    redirect_to root_url, :notice => t(:'sessions.destroy.success')
  end

end
