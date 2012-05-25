class InvitationsController < ApplicationController
  def new
  end

  def create
    if current_user.invite_user_to_project( params[:email], project )
      redirect_to project, :notice => 'Invitation sent'
    end
  end

  def destroy
    invitation.destroy
    redirect_to root_url
  end

  def accept
    if invitation.accept!
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
    else
      Invitation.new params[:invitations]
    end
  end

  def project
    @project ||= if params[:project_id]
      current_user.projects.find params[:project_id]
    end
  end
  helper_method :project

end
