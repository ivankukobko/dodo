class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :inviter, :class_name => 'User', :foreign_key => 'invited_by'

  PROJECT_ROLES = %w(owner collaborator)

  def owner?
    role_id == PROJECT_ROLES.index('owner')
  end

  def accept
    self.accepted_at = Time.now.utc
    save
  end
end
