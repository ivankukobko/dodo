class ProjectsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    if project.save
      redirect_to project, :notice => 'project created'
    else
      render :new
    end
  end

  def update
    if project.update_attributes params[:project]
      redirect_to project, :notice => 'project updated'
    else
      render :edit
    end
  end

  def destroy
    project.destroy
    redirect_to :index, :notice => 'project destroyed'
  end

  def projects
    @projects ||= current_user.projects
  end
  helper_method :projects

  def project
    @project ||= if params[:id]
      current_user.projects.find params[:id]
    else
      current_user.projects.build params[:project]
    end
  end
  helper_method :project
end
