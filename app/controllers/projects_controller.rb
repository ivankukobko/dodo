class ProjectsController < ApplicationController
  respond_to :html, :json
  def index
    respond_to do |format|
      format.html{}
      format.json{
        render :json => projects.as_json()
      }
    end
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
      flash[:success] = t(:'projects.actions.create.success')
      redirect_to project
    else
      render :new
    end
  end

  def update
    if project.update_attributes params[:project]
      flash[:success] = t(:'projects.actions.update.success')
      redirect_to project
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
      begin
        current_user.projects.find(params[:id])
      rescue
        current_user.invitations.find_by_project_id(params[:id]).project
      end
    else
      # FIXME: find a way to build project with user
      #current_user.projects.build params[:project]
      Project.new params[:project]
    end
  end
  helper_method :project
end
