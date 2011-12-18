class SessionsController < ApplicationController

  skip_before_filter :require_authentication

  def new
  end

  def create
    email, password = params[:user][:email], params[:user][:password]
    if self.current_user = User.authenticate(email, password)
      redirect_to root_url, :notice => t(:'sessions.create.success')
    else
      redirect_to new_session_url, :error => t(:'sessions.create.error')
    end
  end

  def destroy
    self.current_user = nil
    reset_session
    redirect_to root_url, :notice => t(:'sessions.destroy.success')
  end

end
