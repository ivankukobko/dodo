class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  PROJECT_ROLES = %w(owner collaborator)

  def is_owner?
    role_id == PROJECT_ROLES.index('owner')
  end

  def is_collaborator?
    role_id == PROJECT_ROLES.index('collaborator')
  end
end
