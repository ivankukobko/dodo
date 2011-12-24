class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :inviter, :class_name => 'User', :foreign_key => 'invited_by'

  default_scope order('collaborators.accepted_at ASC')

  PROJECT_ROLES = %w(owner collaborator)

  def is_owner?
    role_id == PROJECT_ROLES.index('owner')
  end

  def is_collaborator?
    role_id == PROJECT_ROLES.index('collaborator')
  end

  def accept!
    self.accepted_at = Time.now.utc
    save
  end
end
