class UsersController < ApplicationController

  skip_before_filter :require_authentication, :only => [:new, :create]

  def new
  end

  def create
    if user.save
      current_user = User.authenticate(user.email, user.password)
      redirect_to root_url, :notice => t(:'users.create.success')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if user.update_attributes param[:user]
      redirect_to user, :notice => t(:'users.update.success')
    else
      render :edit#, :error => t(:'users.update.error')
    end
  end

  def user
    @user = current_user || User.new(params[:user])
  end
  helper_method :user
end
