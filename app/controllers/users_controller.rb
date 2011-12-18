class UsersController < ApplicationController
  def new
  end

  def create
    if user.save
      self.current_user = user
      redirect_to user, :notice => t(:'users.create.success')
    else
      render :new
    end
  end

  def show
    redirect_to me_path
  end

  def edit
  end

  def update
    if user.update_attributes params[:user]
      redirect_to user, :notice => t(:'users.update.success')
    else
      render :edit
    end
  end

  def me
    render :show
  end

  def user
    @user ||= current_user || User.new(params[:user])
  end
  helper_method :user
end
