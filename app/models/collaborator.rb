class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  PROJECT_ROLES = %w(owner collaborator)

  def owner?
    role_id == PROJECT_ROLES.index('owner')
  end
end
