class SessionsController < ApplicationController

  skip_before_filter :require_authentication

  def new; end

  def create
    # Login through authentication form
    if params[:user]
      email, password = params[:user][:email], params[:user][:password]
      if self.current_user = User.authenticate(email, password)
        flash[:success] = t(:'sessions.create.success')
      else
        flash[:error] = t(:'sessions.create.error')
        redirect_to new_session_url and return
      end
    # Login through oauth
    elsif auth_hash
      unless authentication = Authentication.find_from_hash(auth_hash)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        authentication = Authentication.create_from_hash(auth_hash, current_user)
      end
      # Log the authorizing user in if he is not yet.
      unless current_user
        self.current_user = authentication.user
      end
    end
    redirect_to root_url
  end

  def destroy
    self.current_user = nil
    reset_session
    redirect_to root_url, :notice => t(:'sessions.destroy.success')
  end

  def failure
    flash[:error] = t(:'authentication.failure')
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
