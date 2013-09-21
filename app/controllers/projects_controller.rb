class ProjectsController < ApplicationController
  inherit_resources
  respond_to :html, :json

  def create
    # FIXME: make more obvious and encapsulated
    # way to assign project owner
    resource.users = [current_user]
    create!
  end

  private

  def begin_of_association_chain
    current_user
  end

  def projects
    collection
  end
  helper_method :projects

  def resource
    @project ||= if params[:id]
      end_of_association_chain.find params[:id]
    else
      begin_of_association_chain.projects.build params[:project]
    end
  end

  def project
    resource
  end
  helper_method :project

end

