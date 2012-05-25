class CollaboratorsController < ApplicationController

  def update
    if collaborator.update_attributes params[:collaborator]
      flash[:success] = 'Collaboration permissions updated'
    else
      flash[:error] = 'Cannot update collaboration permissions'
    end
    redirect_to collaborator.project
  end

  def destroy
    collaborator.destroy
    redirect_to root_url, :notice => 'You left project'
  end

  def collaborator
    @collaborator ||= if params[:project_id]
      #if params[:collaborator]
      current_user.collaborators.find_by_project_id params[:project_id]
      #end
    end
  end

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end
  helper_method :project

end
