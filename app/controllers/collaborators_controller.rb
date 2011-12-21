class CollaboratorsController < ApplicationController
  def new
  end

  def create
    if current_user.invite_collaborator( params[:email], project )
      redirect_to project, :notice => 'Invitation sent'
    end
  end

  def destroy

  end

  def collaborator
    @collaborator ||= if params[:project_id]
      if params[:collaborator]
        Collaborator.new params[:collaborator]
      end
    end
  end

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end
  helper_method :project

end
