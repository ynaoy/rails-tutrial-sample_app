# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/follow_notice
  def follow_notice
    from_user = User.first
    to_user = User.second
    NotificationMailer.follow_notice(from_user,to_user)
  end

end
