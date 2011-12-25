class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :inviter, :class_name => 'User', :foreign_key => 'invited_by'

  def accept!
    self.accepted_at = Time.now.utc
    save
    project.collaborators.create( :user => self.user, :role_id => Collaborator::PROJECT_ROLES.index('collaborator') )
  end
end
