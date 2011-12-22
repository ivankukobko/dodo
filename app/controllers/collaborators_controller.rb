class CollaboratorsController < ApplicationController
  def new
  end

  def create
    if current_user.invite_collaborator( params[:email], project )
      redirect_to project, :notice => 'Invitation sent'
    end
  end

  def destroy
    collaborator.destroy
    redirect_to root_url
  end

  def accept
    if invitation.accept
      flash[:success] = t :'collaborator.invitations.accept.success'
      redirect_to invitation.project
    else
      flash[:error] = t :'collaborator.invitations.accept.error'
      redirect_to root_url
    end
  end

  def collaborator
    @collaborator ||= if params[:project_id]
      if params[:collaborator]
        Collaborator.new params[:collaborator]
      end
    end
  end

  def invitation
    @invitation ||= if params[:id]
      current_user.invitations.find(params[:id])
    end
  end

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end
  helper_method :project

end
