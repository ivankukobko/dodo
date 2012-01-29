class UserMailer < ActionMailer::Base
  default from: "admin@dodo.co.ua"

  def registration_notification user
    @user = user
    mail(
      :to => @user.email,
      :subject => t(:'site.email_notifications.registration')
    )
  end

  def invitation_notification invitation
    @user = invitation.user
    @project = invitation.project
    @inviter = invitation.inviter
    mail(
      :to => @user.email,
      :subject => t(:'site.email_notifications.registration')
    )
  end

  def new_user_invitation_notification invitation
    @user = invitation.user
    @project = invitation.project
    mail(
      :to => @user.email,
      :subject => t(:'site.email_notifications.registration')
    )
  end
end
