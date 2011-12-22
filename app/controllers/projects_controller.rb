class ProjectsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    # FIXME: make more obvious and incapsulated
    # way to assign project owner
    project.users = [current_user]
    if project.save
      redirect_to project, :notice => t(:'projects.actions.create.success')
    else
      render :new
    end
  end

  def update
    if project.update_attributes params[:project]
      redirect_to project, :notice => t(:'projects.actions.update.success')
    else
      render :edit
    end
  end

  def destroy
    project.destroy
    redirect_to root_url, :notice => t(:'projects.actions.destroy.success')
  end

  def projects
    @projects ||= current_user.projects
  end
  helper_method :projects

  def project
    @project ||= if params[:id]
      current_user.projects.find params[:id]
    else
      # FIXME: find a way to build project with user
      #current_user.projects.build params[:project]
      Project.new params[:project]
    end
  end
  helper_method :project
end
