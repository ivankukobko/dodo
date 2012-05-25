class Invitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :inviter, :class_name => 'User', :foreign_key => 'invited_by'

  after_create :send_notification

  def accept!
    self.accepted_at = Time.now.utc
    save
    project.collaborators.create( :user => self.user, :role_id => Collaborator::PROJECT_ROLES.index('collaborator') )
  end

  def send_notification
    #user exists
    if user.password.blank?
      UserMailer.invitation_notification(self).deliver
    # new user, has newly generated password
    else
      UserMailer.new_user_invitation_notification(self).deliver
    end
  end
end
